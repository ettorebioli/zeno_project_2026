#!/usr/bin/env python
# -*- coding: utf-8 -*-

import rospy
import math
import json
import threading
import os
import rospkg
import yaml
from collections import deque
from std_msgs.msg import String

from geodetic_functions import ne2ll, ll2distance, ll2ne
from marta_msgs.msg import NavStatus 

class FLSLocalizationNode:
    def __init__(self):
        rospy.init_node('fls_localization_node', anonymous=False)

        self.NOMINAL_ALTITUDE = 3.6
        self.R_MAX = 15.0               
        self.U_0 = 512.0                
        self.V_0 = 768.0                
        self.V_ARC = 18.0              
        self.S_F = self.R_MAX / (self.V_0 - self.V_ARC) 
        self.OFFSET_X_BODY = 0.375      
        self.OFFSET_Z_SONAR = 0.103     

        self.nav_buffer = deque(maxlen=100)
        self.buffer_lock = threading.Lock()

        # --- CARICAMENTO AREA DI GARA ---
        self.safe_zone_vertices = self.load_safe_zone()

        # Memoria della mappa
        self.global_targets = {}
        self.next_global_id = 1
        self.CLUSTER_RADIUS_M = 5.5
        rp = rospkg.RosPack()  

        # --- CARTELLA DI OUTPUT ESPLICITA NELLA HOME ---
        try:
            # Trova dinamicamente la cartella del tuo pacchetto 
            # ATTENZIONE: Sostituisci 'nome_del_tuo_pacchetto' con il vero nome (es. 'localization_pkg' o 'marta_guide')
            pkg_path = rp.get_path('localization')
            
            # Crea una sottocartella chiamata "output_mappe" dentro il tuo pacchetto
            self.output_dir = os.path.join(pkg_path, "output_mappe")
            
        except Exception as e:
            # Fallback di emergenza se il pacchetto non viene trovato
            rospy.logwarn("Pacchetto non trovato, salvataggio di emergenza nella Home. Errore: {}".format(e))
            self.output_dir = os.path.expanduser("~/mappa_target")

        # Crea la cartella se non esiste
        if not os.path.exists(self.output_dir):
            os.makedirs(self.output_dir)
            
        self.log_file_path = os.path.join(self.output_dir, "localized_targets_log.txt")
        self.final_map_path = os.path.join(self.output_dir, "final_target_map.json")
        
        with open(self.log_file_path, "w") as f:
            f.write("=== LOG TARGET LOCALIZZATI ===\n\n")

        # Subscribers e Publishers
        rospy.Subscriber('/nav_status', NavStatus, self.nav_callback)
        rospy.Subscriber('/perception/target_json', String, self.target_callback)
        
        self.pub_localized = rospy.Publisher('/perception/target_localized_json', String, queue_size=10)
        
        # NUOVO TOPIC: Pubblica l'intera mappa pulita costantemente (latch=True mantiene in memoria l'ultimo messaggio)
        self.pub_global_map = rospy.Publisher('/perception/global_map_json', String, queue_size=1, latch=True)

        rospy.on_shutdown(self.save_final_target_list)

        rospy.loginfo("Nodo di Localizzazione avviato.")
        rospy.loginfo("I file verranno salvati in modo sicuro in: {}".format(self.output_dir))

    def save_final_target_list(self):
        """Salva la mappa su file JSON e fa un'ultima pubblicazione sul topic prima di morire."""
        rospy.loginfo("Generazione della mappa finale in: {}".format(self.final_map_path))
        try:
            with open(self.final_map_path, 'w') as f:
                json.dump(self.global_targets, f, indent=4)
            rospy.loginfo("Mappa salvata con successo! Trovati {} target unici.".format(len(self.global_targets)))
            
            # Un'ultima pubblicazione di sicurezza sul topic prima di chiudere
            map_msg = String()
            map_msg.data = json.dumps(self.global_targets)
            self.pub_global_map.publish(map_msg)
        except Exception as e:
            rospy.logerr("Errore nel salvataggio: {}".format(e))


    def load_safe_zone(self):
        try:
            rp = rospkg.RosPack()
            pkg_path = rp.get_path('zeno_mission') 
            yaml_file = os.path.join(pkg_path, 'config', 'region_params.yaml')
            
            with open(yaml_file, 'r') as f:
                data = yaml.safe_load(f)
                
            # ---> MODIFICA: Ora estraiamo il poligono 'original' <---
            vertices_ned = data['polygon_vertices']['original']
            
            # SALVIAMO L'ORIGINE PER LE CONVERSIONI!
            lat_o = data['origin']['coordinates']['latitude']
            lon_o = data['origin']['coordinates']['longitude']
            self.map_origin = (lat_o, lon_o)
            
            # ---> MODIFICA: Aggiornato anche il log per coerenza visiva a terminale <---
            rospy.loginfo("Area di gara ORIGINALE caricata con successo da YAML.")
            return vertices_ned
            
        except Exception as e:
            rospy.logwarn("File region_params.yaml non trovato, geofencing disabilitato: {}".format(e))
            return None

    def point_in_polygon(self, x, y, polygon):
        if not polygon: return False
        n = len(polygon)
        inside = False
        p1x, p1y = polygon[0]
        for i in range(1, n + 1):
            p2x, p2y = polygon[i % n]
            if y > min(p1y, p2y):
                if y <= max(p1y, p2y):
                    if x <= max(p1x, p2x):
                        if p1y != p2y:
                            xints = (y - p1y) * (p2x - p1x) / (p2y - p1y) + p1x
                        if p1x == p2x or x <= xints:
                            inside = not inside
            p1x, p1y = p2x, p2y
        return inside

    def nav_callback(self, msg):
        if msg.initialized:
            stamp_sec = msg.header.stamp.to_sec()
            nav_state = {
                'lat': msg.position.latitude,
                'lon': msg.position.longitude,
                'yaw': msg.orientation.yaw
            }
            with self.buffer_lock:
                self.nav_buffer.append((stamp_sec, nav_state))

    def target_callback(self, msg):
        try:
            target_data = json.loads(msg.data)
            fls_stamp = target_data.get('fls_stamp_sec')
            if fls_stamp is None:
                return

            with self.buffer_lock:
                if len(self.nav_buffer) == 0:
                    return
                closest_match = min(self.nav_buffer, key=lambda x: abs(x[0] - fls_stamp))
                nav_state_backup = self.nav_buffer[-1][1] 
            
            matched_time, nav_state = closest_match[0], closest_match[1]
            if abs(matched_time - fls_stamp) > 0.5:
                if abs(matched_time - fls_stamp) > 100000: 
                    nav_state = nav_state_backup 
                else:
                    return 
            
            center = target_data.get('center_px')
            bbox = target_data.get('bbox_px')
            raw_type = str(target_data.get('type', 'unknown')).lower()

            if center is None or bbox is None:
                return

            # --- SELEZIONE DINAMICA DEL PUNTO DI CONTATTO ACUSTICO ---
            if "tubo" in raw_type:
                # Per il tubo inclinato, il centroide è geometricamente stabile e cade sempre sul corpo
                u_t = float(center[0])
                v_t = float(center[1])
                
                # Regoliamo l'altezza stimata: il centroide del tubo si trova a circa 
                # metà del suo diametro (altezza totale 0.75m -> centro a ~0.37m)
                H_TARGET_EST = 0.37 
                
            elif "boa" in raw_type:
                # Per la boa, il centro del lato inferiore della bbox prende la base di cemento
                x1, y1, ew, eh = bbox
                u_t = x1 + (ew / 2.0)
                v_t = float(y1 + eh)
                
                # La base poggia sul fondo, il centro di riflessione del blocco è a ~0.35m
                H_TARGET_EST = 0.35

            # x1, y1, ew, eh = bbox
            # u_t = x1 + (ew / 2.0)
            # v_t = float(y1 + eh)

            # center = target_data.get('center_px')
            # if center is None:
            #     return

            # u_t = float(center[0])
            # v_t = float(center[1])

            X_slant = (self.V_0 - v_t) * self.S_F
            Y_slant = (u_t - self.U_0) * self.S_F
            R_slant = math.sqrt(X_slant**2 + Y_slant**2)
            
            # raw_type = str(target_data.get('type', 'unknown')).lower()

            # # --- CORREZIONE DI PARALLASSE DINAMICA ---
            # if "tubo" in raw_type:
            #     # Il tubo è alto 0.75m sul fondale
            #     H_TARGET_EST = 0.7 
            # elif "boa" in raw_type:
            #     # La sfera della boa si trova a oltre 1.5m dal fondale
            #     H_TARGET_EST = 1.8

            # Calcoliamo l'h relativo tra sonar e punto d'impatto
            h_sonar = (self.NOMINAL_ALTITUDE - self.OFFSET_Z_SONAR) - H_TARGET_EST
            
            if R_slant > h_sonar:
                R_ground = math.sqrt(R_slant**2 - h_sonar**2)
                correction_factor = R_ground / R_slant
                X_body = (X_slant * correction_factor) + self.OFFSET_X_BODY
                Y_body = (Y_slant * correction_factor)
            else:
                return

            yaw = nav_state['yaw']
            X_ned = X_body * math.cos(yaw) - Y_body * math.sin(yaw)
            Y_ned = X_body * math.sin(yaw) + Y_body * math.cos(yaw)

            raw_lat, raw_lon = ne2ll((nav_state['lat'], nav_state['lon']), (X_ned, Y_ned))
            raw_type = str(target_data.get('type', 'unknown')).lower()
            raw_conf = target_data.get('confidence', 0.5)
            current_range = math.sqrt(X_body**2 + Y_body**2)

            # --------------------------------------------------------
            # GEOFENCING NED: IL TARGET È DENTRO L'AREA DI GARA?
            # --------------------------------------------------------
            if self.safe_zone_vertices is not None and hasattr(self, 'map_origin'):
                # Convertiamo le cordinate assolute in NED rispetto all'origine della mappa!
                tgt_n, tgt_e = ll2ne(self.map_origin, (raw_lat, raw_lon))
                
                # yaml_vertices sono [North, East]. Usiamo tgt_n come X e tgt_e come Y
                if not self.point_in_polygon(tgt_n, tgt_e, self.safe_zone_vertices):
                    return
            # --------------------------------------------------------

            raw_type = str(target_data.get('type', 'unknown')).lower()
            raw_conf = target_data.get('confidence', 0.5)

            # --- LOGICA DEL CLUSTERING ---
            best_global_id = None
            min_dist = float('inf')

            for gid, gdata in self.global_targets.items():
                dist = ll2distance((raw_lat, raw_lon), (gdata['lat'], gdata['lon']))
                if dist < self.CLUSTER_RADIUS_M and dist < min_dist:
                    min_dist = dist
                    best_global_id = gid

            if best_global_id is not None:
                g_tgt = self.global_targets[best_global_id]
                # --- MODIFICA: Filtro Esponenziale (EMA) ---
                # ALPHA = 0.2 significa: la nuova misura pesa il 20%, la vecchia storia l'80%
                # Il baricentro sarà fluido ma non resterà "bloccato" da 1000 frame vecchi sballati.
                ALPHA = 0.2 
    
                g_tgt['lat'] = (1 - ALPHA) * g_tgt['lat'] + ALPHA * raw_lat
                g_tgt['lon'] = (1 - ALPHA) * g_tgt['lon'] + ALPHA * raw_lon
    
                g_tgt['obs_count'] += 1
                
                # Se lo vediamo da più vicino, aggiorniamo la classe in cui crediamo
                if current_range < g_tgt['min_range']:
                    g_tgt['type'] = raw_type
                    g_tgt['confidence'] = raw_conf
                    g_tgt['min_range'] = current_range
            else:
                best_global_id = self.next_global_id
                self.next_global_id += 1
                self.global_targets[best_global_id] = {
                    'lat': raw_lat,
                    'lon': raw_lon,
                    'type': raw_type,
                    'confidence': raw_conf,
                    'min_range': current_range,
                    'obs_count': 1
                }

            # 1. Pubblichiamo il target singolo aggiornato (come prima)
            target_data['target_id'] = best_global_id
            target_data['target_lat'] = self.global_targets[best_global_id]['lat']
            target_data['target_lon'] = self.global_targets[best_global_id]['lon']
            target_data['type'] = self.global_targets[best_global_id]['type']
            
            out_msg = String()
            out_msg.data = json.dumps(target_data)
            self.pub_localized.publish(out_msg)

            # 2. PUBBLICHIAMO L'INTERA MAPPA GLOBALE (Il dizionario pulito!)
            map_msg = String()
            map_msg.data = json.dumps(self.global_targets)
            self.pub_global_map.publish(map_msg)

            # Salvataggio log continuo (nella Home)
            try:
                with open(self.log_file_path, "a") as f:
                    f.write(json.dumps(target_data, indent=4) + "\n" + "-"*50 + "\n")
            except Exception:
                pass

        except Exception as e:
            rospy.logerr("Errore: {}".format(e))

if __name__ == '__main__':
    try:
        node = FLSLocalizationNode()
        rospy.spin()
    except rospy.ROSInterruptException:
        pass