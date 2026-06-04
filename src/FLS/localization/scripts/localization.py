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
        
        # Mantenuto a 5.5 come richiesto
        self.CLUSTER_RADIUS_M = 5.5
        rp = rospkg.RosPack()  

        # --- CARTELLA DI OUTPUT ESPLICITA ---
        try:
            pkg_path = rp.get_path('localization')
            self.output_dir = os.path.join(pkg_path, "output_mappe")
        except Exception as e:
            rospy.logwarn("Pacchetto non trovato, salvataggio di emergenza nella Home. Errore: {}".format(e))
            self.output_dir = os.path.expanduser("~/mappa_target")

        if not os.path.exists(self.output_dir):
            os.makedirs(self.output_dir)
            
        self.log_file_path = os.path.join(self.output_dir, "localized_targets_log.txt")
        self.final_map_path = os.path.join(self.output_dir, "final_target_map.json")
        
        # ---> AGGIUNTA DEI PATH YAML <---
        self.targets_yaml_path = os.path.join(self.output_dir, "targets_fls.yaml")
        self.obstacles_yaml_path = os.path.join(self.output_dir, "obstacle_fls.yaml")
        
        with open(self.log_file_path, "w") as f:
            f.write("=== LOG TARGET LOCALIZZATI ===\n\n")

        # Subscribers e Publishers
        rospy.Subscriber('/nav_status', NavStatus, self.nav_callback)
        rospy.Subscriber('/perception/target_json', String, self.target_callback)
        
        self.pub_localized = rospy.Publisher('/perception/target_localized_json', String, queue_size=10)
        self.pub_global_map = rospy.Publisher('/perception/global_map_json', String, queue_size=1, latch=True)

        rospy.on_shutdown(self.save_final_target_list)

        rospy.loginfo("Nodo di Localizzazione avviato.")
        rospy.loginfo("I file verranno salvati in modo sicuro in: {}".format(self.output_dir))

    def save_final_target_list(self):
        """Salva la mappa su file JSON e YAML e fa un'ultima pubblicazione sul topic prima di morire."""
        rospy.loginfo("Generazione delle mappe finali in: {}".format(self.output_dir))
        try:
            # 1. Filtriamo la mappa
            MIN_OBS_COUNT = 35 
            confirmed_targets = {}
            
            for t_id, t_data in self.global_targets.items():
                if t_data['obs_count'] >= MIN_OBS_COUNT:
                    confirmed_targets[t_id] = t_data

            # 2. Salviamo il JSON
            with open(self.final_map_path, 'w') as f:
                json.dump(confirmed_targets, f, indent=4)
                
            # 3. Prepariamo le strutture a lista semplice per i file YAML
            targets_data = {"targets": []}
            obstacles_data = {"obstacles": []}

            for t_id, info in confirmed_targets.items():
                if "boa" in info["type"]:
                    # Formato puro per i Target: [lat, lon]
                    targets_data["targets"].append([info["lat"], info["lon"]])
                elif "tubo" in info["type"]:
                    # Formato puro per gli Ostacoli: [lat, lon, 2.5]
                    obstacles_data["obstacles"].append([info["lat"], info["lon"], 2.5])

            # 4. Scriviamo i file YAML per il Path Planning (default_flow_style=None per le liste in linea)
            with open(self.targets_yaml_path, 'w') as f:
                yaml.dump(targets_data, f, default_flow_style=None)

            with open(self.obstacles_yaml_path, 'w') as f:
                yaml.dump(obstacles_data, f, default_flow_style=None)
                
            rospy.loginfo("Mappe salvate con successo! Trovate {} Boe e {} Tubi.".format(
                len(targets_data["targets"]), len(obstacles_data["obstacles"])
            ))
            
            # Un'ultima pubblicazione di sicurezza sul topic prima di chiudere
            map_msg = String()
            map_msg.data = json.dumps(confirmed_targets)
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
                
            vertices_ned = data['polygon_vertices']['original']
            lat_o = data['origin']['coordinates']['latitude']
            lon_o = data['origin']['coordinates']['longitude']
            self.map_origin = (lat_o, lon_o)
            
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
                    'yaw': msg.orientation.yaw,
                    'pitch': msg.orientation.pitch, # <-- Aggiunto
                    'roll': msg.orientation.roll    # <-- Aggiunto
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
                u_t = float(center[0])
                v_t = float(center[1])
                H_TARGET_EST = 0.37 
                
            elif "boa" in raw_type:
                x1, y1, ew, eh = bbox
                u_t = x1 + (ew / 2.0)
                v_t = float(y1 + eh)
                H_TARGET_EST = 0.35

            X_slant = (self.V_0 - v_t) * self.S_F
            Y_slant = (u_t - self.U_0) * self.S_F
            R_slant = math.sqrt(X_slant**2 + Y_slant**2)
            
            h_sonar = (self.NOMINAL_ALTITUDE - self.OFFSET_Z_SONAR) - H_TARGET_EST
            
            if R_slant > h_sonar:
                R_ground = math.sqrt(R_slant**2 - h_sonar**2)
                correction_factor = R_ground / R_slant
                X_body = (X_slant * correction_factor) + self.OFFSET_X_BODY
                Y_body = (Y_slant * correction_factor)
            else:
                return

            # Estraiamo gli angoli di Eulero dal nav_state
            yaw = nav_state['yaw']
            pitch = nav_state.get('pitch', 0.0) # Usa 0.0 come fallback se non è presente
            roll = nav_state.get('roll', 0.0)
            Z_body = h_sonar
           
            # Pre-calcoliamo seni e coseni per efficienza
            cy = math.cos(yaw)
            sy = math.sin(yaw)
            cp = math.cos(pitch)
            sp = math.sin(pitch)
            cr = math.cos(roll)
            sr = math.sin(roll)

            # Applichiamo la matrice di rotazione completa R_b^n (Body to NED)
            X_ned = X_body * (cy * cp) + \
                    Y_body * (cy * sp * sr - sy * cr) + \
                    Z_body * (cy * sp * cr + sy * sr)
                    
            Y_ned = X_body * (sy * cp) + \
                    Y_body * (sy * sp * sr + cy * cr) + \
                    Z_body * (sy * sp * cr - cy * sr)

            raw_lat, raw_lon = ne2ll((nav_state['lat'], nav_state['lon']), (X_ned, Y_ned))
            raw_type = str(target_data.get('type', 'unknown')).lower()
            raw_conf = target_data.get('confidence', 0.0)
            current_range = math.sqrt(X_body**2 + Y_body**2)

            # --------------------------------------------------------
            # GEOFENCING NED
            # --------------------------------------------------------
            if self.safe_zone_vertices is not None and hasattr(self, 'map_origin'):
                tgt_n, tgt_e = ll2ne(self.map_origin, (raw_lat, raw_lon))
                if not self.point_in_polygon(tgt_n, tgt_e, self.safe_zone_vertices):
                    return
            # --------------------------------------------------------

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
                ALPHA = 0.2 
    
                g_tgt['lat'] = (1 - ALPHA) * g_tgt['lat'] + ALPHA * raw_lat
                g_tgt['lon'] = (1 - ALPHA) * g_tgt['lon'] + ALPHA * raw_lon
    
                g_tgt['obs_count'] += 1
                
                if raw_type in g_tgt['type_votes']:
                    g_tgt['type_votes'][raw_type] += float(raw_conf)
                else:
                    g_tgt['type_votes'][raw_type] = float(raw_conf)
                    
                g_tgt['type'] = max(g_tgt['type_votes'], key=g_tgt['type_votes'].get)
                g_tgt['confidence'] = round(g_tgt['type_votes'][g_tgt['type']] / g_tgt['obs_count'], 3)
                
            else:
                best_global_id = self.next_global_id
                self.next_global_id += 1
                self.global_targets[best_global_id] = {
                    'lat': raw_lat,
                    'lon': raw_lon,
                    'type': raw_type,
                    'confidence': raw_conf,
                    'obs_count': 1,
                    'type_votes': {raw_type: float(raw_conf)} 
                }

            target_data['target_id'] = best_global_id
            target_data['target_lat'] = self.global_targets[best_global_id]['lat']
            target_data['target_lon'] = self.global_targets[best_global_id]['lon']
            target_data['type'] = self.global_targets[best_global_id]['type']
            
            out_msg = String()
            out_msg.data = json.dumps(target_data)
            self.pub_localized.publish(out_msg)

            # ---> TRACK CONFIRMATION E PUBBLICAZIONE <---
            MIN_OBS_COUNT = 35
            confirmed_targets = {}
            
            for t_id, t_data in self.global_targets.items():
                if t_data['obs_count'] >= MIN_OBS_COUNT:
                    confirmed_targets[t_id] = t_data

            map_msg = String()
            map_msg.data = json.dumps(confirmed_targets)
            self.pub_global_map.publish(map_msg)

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