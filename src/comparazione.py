#!/usr/bin/env python
# -*- coding: utf-8 -*-

import math
import json
import os
import rospkg
import yaml
import csv
from geodetic_functions import ll2ne

# ============================================================
# 1. FUNZIONI GEOMETRICHE E HAVERSINE
# ============================================================
def haversine_dist(lat1, lon1, lat2, lon2):
    R = 6371000.0  # Raggio della Terra in metri
    phi1, phi2 = math.radians(lat1), math.radians(lat2)
    dphi = math.radians(lat2 - lat1)
    dlambda = math.radians(lon2 - lon1)
    a = math.sin(dphi / 2.0)**2 + math.cos(phi1) * math.cos(phi2) * math.sin(dlambda / 2.0)**2
    return 2 * R * math.atan2(math.sqrt(a), math.sqrt(1 - a))

def point_in_polygon(x, y, polygon):
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

# ============================================================
# 2. CARICAMENTO DATI E GEOFENCING
# ============================================================
def load_json(filepath):
    try:
        with open(filepath, 'r') as f:
            return json.load(f)
    except Exception as e:
        print("Errore nel caricamento di {}: {}".format(filepath, e))
        return None

def load_safe_zone():
    try:
        rp = rospkg.RosPack()
        pkg_path = rp.get_path('zeno_mission') 
        yaml_file = os.path.join(pkg_path, 'config', 'region_params.yaml')
        
        with open(yaml_file, 'r') as f:
            data = yaml.safe_load(f)
            
        vertices_ned = data['polygon_vertices']['original']
        lat_o = data['origin']['coordinates']['latitude']
        lon_o = data['origin']['coordinates']['longitude']
        map_origin = (lat_o, lon_o)
        
        print("Area di gara ORIGINALE caricata con successo da YAML.")
        return vertices_ned, map_origin
        
    except Exception as e:
        print("File region_params.yaml non trovato, geofencing disabilitato: {}".format(e))
        return None, None

# ============================================================
# MAIN SCRIPT
# ============================================================
print("--- INIZIO CROSS-CHECK SENSORI ---")

rp = rospkg.RosPack()

try:
    zeno_mission_pkg_path = rp.get_path('zeno_mission')
    config_path = os.path.join(zeno_mission_pkg_path, "config")
except Exception as e:
    print("[ATTENZIONE] Pacchetto 'zeno_mission' non trovato. Uso cartella corrente.")
    config_path = '.'

# ---> RISOLUZIONE DINAMICA PATH FLS <---
try:
    fls_pkg_path = rp.get_path('localization')
    FLS_FILE = os.path.join(fls_pkg_path, 'output_mappe', 'final_target_map.json')
except Exception as e:
    print("[ATTENZIONE] Pacchetto 'localization' non trovato. Uso file locale.")
    FLS_FILE = 'final_target_map.json'

# ---> RISOLUZIONE DINAMICA PATH SSS <---
try:
    sss_pkg_path = rp.get_path('sss_package')
    SSS_FILE = os.path.join(sss_pkg_path, 'results', '9_list_texts', 'SSS_object_list_10.json')
except Exception as e:
    print("[ATTENZIONE] Pacchetto 'sss_package' non trovato. Uso file locale.")
    SSS_FILE = 'final_object_list.json'

fls_data = load_json(FLS_FILE)
sss_raw_data = load_json(SSS_FILE)

if not fls_data or not sss_raw_data:
    print("Impossibile procedere: file mancanti.")
    exit()

sss_data = sss_raw_data.get('final_list', {})
print("Dati grezzi: {} target FLS, {} target SSS.".format(len(fls_data), len(sss_data)))

# ---> APPLICAZIONE GEOFENCING SUI DATI SSS <---
safe_zone_vertices, map_origin = load_safe_zone()

if safe_zone_vertices and map_origin:
    print("Applicazione Geofencing sui target SSS...")
    filtered_sss_data = {}
    for sss_id, sss_info in sss_data.items():
        tgt_n, tgt_e = ll2ne(map_origin, (sss_info['lat'], sss_info['lon']))
        if point_in_polygon(tgt_n, tgt_e, safe_zone_vertices):
            filtered_sss_data[sss_id] = sss_info
            
    removed_count = len(sss_data) - len(filtered_sss_data)
    sss_data = filtered_sss_data
    print("Rimossi {} target SSS perché esterni all'area di gara.".format(removed_count))

# ============================================================
# 3. ALGORITMO DI MATCHING E DECISIONE (FUSION)
# ============================================================
MATCH_THRESHOLD_M = 4.0
unmatched_fls = []
unmatched_sss = list(sss_data.keys()) 

# Struttura completa per il SUPER FILE
merged_list_data = {
    "final_map": {},          
    "fusion_diagnostics": {   
        "matched_targets": [],
        "isolated_targets": []
    }
}

next_final_id = 1

print("\n--- RISULTATI ASSOCIAZIONE E MERGE (Soglia: {} m) ---".format(MATCH_THRESHOLD_M))

for fls_id, fls_info in fls_data.items():
    best_match_id = None
    min_dist = float('inf')
    
    # Ricerca del match
    for sss_id, sss_info in sss_data.items():
        dist = haversine_dist(fls_info['lat'], fls_info['lon'], sss_info['lat'], sss_info['lon'])
        if dist < min_dist:
            min_dist = dist
            best_match_id = sss_id

    # MATCH TROVATO: Dobbiamo decidere chi vince
    if best_match_id and min_dist <= MATCH_THRESHOLD_M:
        if best_match_id in unmatched_sss:
            unmatched_sss.remove(best_match_id)
            
        sss_info = sss_data[best_match_id]
        
        # --- LOGICA DECISIONALE ---
        fls_conf = float(fls_info.get("confidence", 0.0))
        fls_obs = float(fls_info.get("obs_count", 1.0))
        sss_conf = float(sss_info.get("confidence", 0.0))
        sss_obs = float(sss_info.get("obs_count", 1.0))
        
        fls_score = fls_conf * math.log10(fls_obs + 1)
        sss_score = sss_conf * math.log10(sss_obs + 1)
        
        if sss_score > fls_score:
            winner = "SSS"
            chosen_data = sss_info
            
            # ---> NUOVA RIGA: Forziamo la classe del FLS perché è più affidabile sulla forma! <---
            chosen_data['type'] = fls_info['type']
            
        else:
            winner = "FLS"
            chosen_data = fls_info
            
        print("[MERGE] Match FLS[{}] - SSS[{}] | Vince: {} | Distanza: {:.2f}m".format(
            fls_id.zfill(2), best_match_id.zfill(2), winner, min_dist
        ))

        # Aggiungiamo alla mappa finale il vincitore
        merged_list_data["final_map"][str(next_final_id)] = {
            "source": "FUSION (Won by {})".format(winner),
            "original_fls_id": int(fls_id),
            "original_sss_id": int(best_match_id),
            "lat": chosen_data['lat'],
            "lon": chosen_data['lon'],
            "type": chosen_data['type'],
            "confidence": chosen_data.get('confidence', 0.0),
            "obs_count": chosen_data.get('obs_count', 1)
        }
        
        merged_list_data["fusion_diagnostics"]["matched_targets"].append({
            "final_id": next_final_id,
            "winner": winner,
            "fls_id": int(fls_id), "fls_conf": fls_conf, "fls_obs": fls_obs, "fls_type": fls_info.get('type'),
            "sss_id": int(best_match_id), "sss_conf": sss_conf, "sss_obs": sss_obs, "sss_type": sss_info.get('type'),
            "distance_m": round(min_dist, 3)
        })
        
        next_final_id += 1
    else:
        unmatched_fls.append(fls_id)

# ============================================================
# 4. GESTIONE TARGET ISOLATI (LOGICA FLS-CENTRICA)
# ============================================================
print("\n--- AGGIUNTA TARGET ISOLATI ALLA MAPPA FINALE ---")

# 1. FLS ISOLATI -> VENGONO AGGIUNTI (Protezione frontale)
for f_id in unmatched_fls:
    print("[+] FLS ID [{}] isolato: RECUPERATO e aggiunto alla mappa finale.".format(f_id))
    merged_list_data["final_map"][str(next_final_id)] = {
        "source": "FLS_ONLY",
        "original_id": int(f_id),
        "lat": fls_data[f_id]['lat'],
        "lon": fls_data[f_id]['lon'],
        "type": fls_data[f_id]['type'],
        "confidence": fls_data[f_id].get('confidence', 0.0),
        "obs_count": fls_data[f_id].get('obs_count', 1)
    }
    merged_list_data["fusion_diagnostics"]["isolated_targets"].append({
        "final_id": next_final_id, "sensor": "FLS", "id": int(f_id), "type": fls_data[f_id]['type'], "status": "KEPT"
    })
    next_final_id += 1

# 2. SSS ISOLATI -> VENGONO SCARTATI (Riflessi laterali o fuori rotta)
for s_id in unmatched_sss:
    print("[-] SSS ID [{}] isolato: SCARTATO dalla mappa finale.".format(s_id))
    merged_list_data["fusion_diagnostics"]["isolated_targets"].append({
        "final_id": None, "sensor": "SSS", "id": int(s_id), "type": sss_data[s_id]['type'], "status": "DISCARDED"
    })

# ============================================================
# 5. SALVATAGGIO DEI FILE (JSON, YAML e CSV)
# ============================================================

# 5a. Salvataggio Super File JSON
merged_file_path = os.path.join(config_path, 'merged_target_list.json')
try:
    with open(merged_file_path, 'w') as f:  # <--- CORRETTO QUI
        json.dump(merged_list_data, f, indent=4)
    print("\n[OK] Super file di fusione salvato in: {}".format(merged_file_path)) # <--- CORRETTO QUI
except Exception as e:
    print("\n[ERRORE] Impossibile salvare il super file: {}".format(e))

# 5b. Generazione e Salvataggio YAML (targets e obstacles)
targets_data = {"targets": []}
obstacles_data = {"obstacles": []}

for final_id, item_data in merged_list_data["final_map"].items():
    if "boa" in item_data["type"]:
        targets_data["targets"].append([item_data["lat"], item_data["lon"]])
    elif "tubo" in item_data["type"]:
        obstacles_data["obstacles"].append([item_data["lat"], item_data["lon"], 2.5])

targets_yaml_path = os.path.join(config_path, 'targets.yaml')
obstacles_yaml_path = os.path.join(config_path, 'obstacles.yaml')

try:
    with open(targets_yaml_path, 'w') as f:
        yaml.dump(targets_data, f, default_flow_style=None)
    with open(obstacles_yaml_path, 'w') as f:
        yaml.dump(obstacles_data, f, default_flow_style=None)
        
    print("[OK] Generato {} con {} boe (target).".format(targets_yaml_path, len(targets_data["targets"])))
    print("[OK] Generato {} con {} tubi (ostacoli).".format(obstacles_yaml_path, len(obstacles_data["obstacles"])))
except Exception as e:
    print("\n[ERRORE] Impossibile salvare i file YAML: {}".format(e))

# 5c. Generazione e Salvataggio CSV (In Italiano)
csv_file_path = os.path.join(config_path, 'final_map.csv')
try:
    with open(csv_file_path, mode='w') as csv_file:
        writer = csv.writer(csv_file, delimiter=',')
        
        # Intestazione in italiano
        writer.writerow(['nome', 'lat', 'lon'])
        
        for final_id, item_data in merged_list_data["final_map"].items():
            # Mappatura in italiano pulita
            if "boa" in item_data["type"]:
                obj_name = "boa"
            elif "tubo" in item_data["type"]:
                obj_name = "tubo"
            else:
                obj_name = "sconosciuto"
                
            writer.writerow([obj_name, item_data["lat"], item_data["lon"]])
            
    print("[OK] Generato {} con il riepilogo per l'analisi visiva.".format(csv_file_path))
    print("\nMappa generata con successo! Totale Target Validi: {}".format(len(merged_list_data["final_map"])))
except Exception as e:
    print("\n[ERRORE] Impossibile salvare il file CSV: {}".format(e))