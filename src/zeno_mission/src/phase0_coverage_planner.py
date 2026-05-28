#!/usr/bin/env python
# -*- coding: utf-8 -*-

import rospy
import math
import numpy as np
import matplotlib.pyplot as plt
import rospkg
import os



def get_longest_edge_angle(polygon):

    # Dato il poliogno (ristretto) trova il lato più lungo e l'angolo , rispetto all'asse East che ha 
    max_length = 0.0
    best_angle = 0.0
    n_v = len(polygon)
    
    for i in range(n_v):
        p1 = polygon[i]
        p2 = polygon[(i + 1) % n_v]
        
        # dy = North, dx = East
        dy = p2[0] - p1[0]
        dx = p2[1] - p1[1]
        
        length = math.sqrt(dx**2 + dy**2)
        if length > max_length:
            max_length = length
            best_angle = math.atan2(dy, dx)
            
    return best_angle

def rotate_polygon(polygon, angle):

    # Rotazione poligono attorno all'origne (0,0) di angle 

    rotated = []
    cos_a = math.cos(angle)
    sin_a = math.sin(angle)
    
    for pt in polygon:
        y = pt[0] # North
        x = pt[1] # East
        
        # Matrice di rotazione standard
        x_new = x * cos_a - y * sin_a
        y_new = x * sin_a + y * cos_a
        rotated.append([y_new, x_new])
        
    return np.array(rotated)

def intersect_horizontal_line_convex_poly(y_level, polygon):
    # Trova i punti di intersezione (sinistro e destro)
    
    intersections_x = []
    n_v = len(polygon)
    
    for i in range(n_v):
        p1 = polygon[i]
        p2 = polygon[(i + 1) % n_v]
        
        y1, x1 = p1[0], p1[1]
        y2, x2 = p2[0], p2[1]
        
        # Controlliamo se il segmento attraversa il livello Y
        if (y1 <= y_level <= y2) or (y2 <= y_level <= y1):
            # Evitiamo divisioni per zero se il segmento è perfettamente orizzontale
            if abs(y2 - y1) > 1e-6:
                x_int = x1 + (x2 - x1) * (y_level - y1) / (y2 - y1)
                intersections_x.append(x_int)
            else:
                # Se è orizzontale e coincide con la linea, prendiamo entrambi gli estremi
                intersections_x.append(x1)
                intersections_x.append(x2)
                
    # Puliamo i duplicati e ordiniamo
    if len(intersections_x) >= 2:
        x_min = min(intersections_x)
        x_max = max(intersections_x)
        return (x_min, x_max)
    else:
        return None

def plan_coverage_path(restricted_poly, safety_offset=2.0):
    
    # Parmetri SSS
    spacing = 10.0   # Distanza tra trasetti intermedi (m)
    lb = 8.0        # Lower Bound: Distanza minima accettabile dal bordo originale (m)
    ub = 15.0        # Upper Bound: Distanza massima accettabile dal bordo originale (m)
  

    # Trova l'angolo ottimale (lato più lungo) e ruotiamo tutto
    theta = get_longest_edge_angle(restricted_poly)
    poly_flat = rotate_polygon(restricted_poly, -theta)
    
    # Trova i limiti verticali del poligono originale "piatto"
    y_min = np.min(poly_flat[:, 0])
    y_max = np.max(poly_flat[:, 0])
    
    # Altezza totale dell'area 
    total_height = (y_max - y_min)+(2.0 * safety_offset)
    
    rospy.loginfo("Altezza totale del poligono piatto (bordo originale): {:.2f} m".format(total_height))

    # Numero di massimo di transetti teorici distanziati spacing 
    max_N_theor = int(math.floor(total_height / spacing))
    
    selected_N = 0 # numero effettivo di transetti intermedi 
    selected_dist_ext = lb 
    
    # Scansioniamo a ritroso dal numero massimo di transetti possibili per trovare l'ottimo
    for N in range(max_N_theor, -1, -1):
        space_occupied_by_center = N * spacing
        remaining_space = total_height - space_occupied_by_center
        
        # Lo spazio rimanente viene diviso equamente tra il bordo inferiore e superiore
        dist_from_true_boundary = remaining_space / 2.0
        
        # Verifica se la distanza dell'esterno cade nel range consentito [lb, ub]
        if lb <= dist_from_true_boundary <= ub:
            selected_N = N
            selected_dist_ext = dist_from_true_boundary
            break
    else:
        # Cadiamo qui se il for finisce naturalmente -> non ci sono soluzioni al problema 

        for N in range(max_N_theor, -1, -1):
            space_occupied_by_center = N * spacing
            remaining_space = total_height - space_occupied_by_center
            dist_from_true_boundary = remaining_space / 2.0
            if dist_from_true_boundary >= lb:
                selected_N = N
                selected_dist_ext = dist_from_true_boundary
                rospy.logwarn("Impossibile rispettare l'Upper Bound di {:.2f}m. Scelta forzata.".format(ub))
                break

    # Calcoliamo lo shift effettivo sul poligono ristretto (che è già eroso di safety_offset)
    inward_shift = max(0.0, selected_dist_ext - safety_offset)
    
    rospy.loginfo("Distanza ottimale transetti esterni dal bordo vero: {:.2f} m (Range: [{:.1f}, {:.1f}])".format(selected_dist_ext, lb, ub))
    rospy.loginfo("Inward shift calcolato sul poligono ristretto: {:.2f} m".format(inward_shift))
    rospy.loginfo("Numero di intervalli centrali da esattamente {:.1f}m: {}".format(spacing, selected_N))

    # Posizionamento esatto del PRIMO e dell'ULTIMO transetto sul poligono ristretto
    y_start = y_min + inward_shift
    y_end = y_max - inward_shift

    # Generazione dei livelli Y
    y_levels = []
    if selected_N == 0:
        # Se l'area è talmente stretta da non contenere nemmeno un transetto intermedio a 10m,
        # facciamo un solo passaggio al centro esatto del poligono originale
        y_levels.append((y_min + y_max) / 2.0)
    else:
        # Generiamo il primo livello, tutti quelli intermedi distanziati rigorosamente di 'spacing', e l'ultimo
        for i in range(selected_N + 1):
            y_level = y_start + i * spacing
            y_levels.append(y_level)
            
    # INTERSEZIONE E CREAZIONE ZIG-ZAG (Invariata)
    flat_waypoints = []
    left_to_right = True 
    
    for y in y_levels:
        intersections = intersect_horizontal_line_convex_poly(y, poly_flat)
        if intersections:
            x_left, x_right = intersections
            
            if left_to_right:
                flat_waypoints.append([y, x_left])
                flat_waypoints.append([y, x_right])
            else:
                flat_waypoints.append([y, x_right])
                flat_waypoints.append([y, x_left])
                
            left_to_right = not left_to_right
            
    # Contro-rotazione per tornare nel mondo NED (Invariata)
    final_waypoints = rotate_polygon(np.array(flat_waypoints), theta)
    
    return final_waypoints



def save_waypoints_to_yaml(waypoints):
  
    try:
        
        rospack = rospkg.RosPack()
        pkg_path = rospack.get_path('zeno_mission') 
        
        file_path = os.path.join(pkg_path, 'config', 'waypoints_phase1.yaml')

        with open(file_path, 'w') as f:
            f.write("# Waypoints generated by the Coverage Planner w.r.t the fixed frame [North, East]m \n")
         
            
            f.write("waypoints_phase1:\n")
            for wp in waypoints:
                f.write("  - [{:.3f}, {:.3f}]\n".format(wp[0], wp[1]))

        rospy.loginfo("Waypoint salvati con successo in %s", file_path)

    except Exception as e:
        rospy.logerr("Errore durante il salvataggio del file YAML dei waypoint: %s", str(e))



if __name__ == "__main__":
    rospy.init_node("coverage_planner", anonymous=True)
    
    try:
        rospy.loginfo("Avvio generazione Coverage Path...")

        # LETTURA PARAMETRI DA SERVER 
        if not rospy.has_param('polygon_vertices/restricted'):
            rospy.logerr("Parametro 'polygon_vertices/restricted' NON TROVATO!")
            exit(1)
        
        raw_restricted_list = rospy.get_param('polygon_vertices/restricted')
        restricted_poly = np.array(raw_restricted_list)

        rospy.loginfo("Poligono ristretto caricato con successo ({} vertici).".format(len(restricted_poly)))
        
        # PLANNING 
        waypoints_ned = plan_coverage_path(restricted_poly, safety_offset=2.0)
        # Controllo di sicurezza: se l'algoritmo fallisce (es. area troppo stretta)
        if len(waypoints_ned) == 0:
            rospy.logwarn("Nessun waypoint generato. Esco.")
            exit(0)
        
        rospy.loginfo("Generati {} waypoint".format(len(waypoints_ned)))
        save_waypoints_to_yaml(waypoints_ned)

        
        # PLOT DI VERIFICA
        plt.figure(figsize=(8, 7))
        
        plot_poly = np.vstack([restricted_poly, restricted_poly[0]])
        plt.plot(plot_poly[:, 1], plot_poly[:, 0], 'g--s', linewidth=2, label='Perimetro Ristretto')
        
        wp_plot = np.array(waypoints_ned)
        plt.plot(wp_plot[:, 1], wp_plot[:, 0], 'b-o', linewidth=2, label='Coverage Path')
        
        plt.title("Coverage Path Planning (Sensor Footprint Optimized)")
        plt.xlabel("East [metri]")
        plt.ylabel("North [metri]")
        plt.grid(True, linestyle=':', alpha=0.6)
        plt.axis('equal')
        plt.legend()

        rospack = rospkg.RosPack()
        pkg_path = rospack.get_path('zeno_mission') 
        image_path = os.path.join(pkg_path, 'img', 'coverage_planner_debug.png')
        plt.savefig(image_path, dpi=300, bbox_inches='tight')
        rospy.loginfo("Grafico di debug salvato in: %s", image_path)

        plt.show()

    except Exception as e:
        rospy.logerr("Errore fatale: {}".format(str(e)))