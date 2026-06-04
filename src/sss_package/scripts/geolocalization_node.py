#!/usr/bin/env python2.7
# -*- coding: utf-8 -*-

# ============================================================
# IMPORT LIBRERIE
# ============================================================
import math
import os
import rospkg
import json
import yaml
from collections import OrderedDict
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import rospy
from std_msgs.msg import String
from sss_package.msg import ImageMetadata
from sss_package.msg import GeolocatedObject
from geodetic_functions import ll2ne 
from geodetic_functions import ne2ll 


# ============================================================
# DATI PER MAPPA FINALE
# ============================================================
# inserire coordinate 
MANUAL_POLYGON_POINTS = []
MANUAL_REFERENCE_OBJECTS = []

# Conversione tra le classi pubblicate dal classificatore e le etichette usate
# nella lista finale SSS.
CLASSIFICATION_TYPES = {
    'buoy': 'boa_probabile',
    'tube': 'tubo_probabile'
}


# ============================================================
# CLASSE PRINCIPALE NODO GEOLOCALIZATION
# ============================================================
class GeolocalizationNode:

    def __init__(self):

	print("[SSS] geolocalization_node.py initialization\n")

        # inizializzare subscriber/publisher
        rospy.Subscriber('/classified_objects_topic', ImageMetadata, self.classified_objects_callback)
        self.pub_object_list = rospy.Publisher('list_topic', String, queue_size=20)

        # definire parametri Zeno e sensore
        self.sonar_range_m     = float(rospy.get_param('~sonar_range_m', 25.0))
        self.sensor_x_offset_m = float(rospy.get_param('~sensor_x_offset_m', 0.063))
        self.sensor_y_offset_m = float(rospy.get_param('~sensor_y_offset_m', 0.354))
        self.sensor_z_offset_m = float(rospy.get_param('~sensor_z_offset_m', 0.096))
        self.object_match_distance_m = float(rospy.get_param('~object_match_distance_m', 3.0))
        self.final_map_filename = rospy.get_param('~final_map_filename', 'final_detection_map.png')
        self.safezone_polygon_points = self.load_safezone_polygon_points()

        # creazione cartelle per i risultati
        rospack = rospkg.RosPack()
        pkg_path = rospack.get_path('sss_package') 
        default_folder = os.path.join(pkg_path, 'results', '9_list_texts')
        self.list_text_folder = rospy.get_param('~list_text_folder', default_folder)
        if not os.path.exists(self.list_text_folder):
            os.makedirs(self.list_text_folder)
        self.object_list_json_filename = os.path.join(self.list_text_folder, "SSS_object_list.json")

        # definire parametri oggetti
        self.list_text_index = 0
        self.object_list = []
        self.complete_object_list = []
        self.next_object_id = 1
        self.next_complete_object_id = 1


# ________________________________________________________________________________________________________________________________


    # ========================================================
    # CALLBACK PER GEOLOCALIZZAZIONE
    # ========================================================
    def classified_objects_callback(self, msg):
        # 1. prepara la lista degli oggetti geolocalizzati per questa immagine
        geolocated_objects = []

        # 2. individua il nadir
        image_width = int(msg.image.width)
        localization_infos = []

        # 3. geolocalizza ogni oggetto rilevato
        for object_index in range(len(msg.object_classes)):
            result = self.geolocalize_detection(msg, object_index, image_width)
            if result is not None:
                geolocated_object, localization_info = result
                geolocated_objects.append(geolocated_object)
                localization_infos.append(localization_info)

	# 4. aggiorna e pubblica solo la lista finale degli oggetti
        self.update_complete_object_list(geolocated_objects)
        self.update_object_list(geolocated_objects)
        self.publish_object_list()
        self.save_geolocated_list_text(geolocated_objects, localization_infos)



# ________________________________________________________________________________________________________________________________

    # ========================================================
    # LISTA
    # ========================================================
    def update_complete_object_list(self, geolocated_objects):
        # Mantiene una lista completa di tutte le detection valide, senza clustering
        # e senza filtro safezone. Serve come conteggio diagnostico.
        for geolocated_object in geolocated_objects:
            object_type = CLASSIFICATION_TYPES.get(geolocated_object.object_class)
            if object_type is None:
                continue

            self.complete_object_list.append({
                'id': self.next_complete_object_id,
                'confidence': float(geolocated_object.confidence),
                'obs_count': 1,
                'lon': float(geolocated_object.longitude),
                'lat': float(geolocated_object.latitude),
                'type': object_type
            })
            self.next_complete_object_id += 1

    def update_object_list(self, geolocated_objects):
        # Aggiorna la lista finale: filtra fuori safezone e fonde detection vicine
        # dello stesso tipo nello stesso oggetto osservato piu volte.
        for geolocated_object in geolocated_objects:
            object_type = CLASSIFICATION_TYPES.get(geolocated_object.object_class)
            if object_type is None:
                continue
            if not self.is_point_inside_safezone(
                float(geolocated_object.latitude),
                float(geolocated_object.longitude)
            ):
                rospy.loginfo("[SSS] Detection esclusa dalla lista finale: fuori safezone lat={:.10f} lon={:.10f}".format(
                    float(geolocated_object.latitude),
                    float(geolocated_object.longitude)
                ))
                continue

            existing_object = self.find_matching_object(geolocated_object, object_type)
            if existing_object is None:
                self.object_list.append({
                    'id': self.next_object_id,
                    'confidence': float(geolocated_object.confidence),
                    'obs_count': 1,
                    'lon': float(geolocated_object.longitude),
                    'lat': float(geolocated_object.latitude),
                    'type': object_type
                })
                self.next_object_id += 1
            else:
                self.update_existing_object(existing_object, geolocated_object)

    def find_matching_object(self, geolocated_object, object_type):
        # Cerca l'oggetto gia salvato piu vicino alla nuova detection.
        # La distanza viene calcolata in metri convertendo lat/lon in Nord-Est locale.
        best_object = None
        best_distance = None

        for stored_object in self.object_list:
            if stored_object['type'] != object_type:
                continue

            north_m, east_m = ll2ne(
                [stored_object['lat'], stored_object['lon']],
                [float(geolocated_object.latitude), float(geolocated_object.longitude)]
            )
            distance = math.sqrt((north_m * north_m) + (east_m * east_m))
            if distance <= self.object_match_distance_m:
                if best_distance is None or distance < best_distance:
                    best_distance = distance
                    best_object = stored_object

        return best_object

    def is_point_inside_safezone(self, latitude, longitude):
        # Se la safezone non e disponibile, non blocchiamo le detection.
        if len(self.safezone_polygon_points) < 3:
            return True

        # Ray casting in coordinate geografiche: ogni attraversamento del bordo
        # alterna lo stato dentro/fuori. I punti esattamente sul bordo sono validi.
        inside = False
        point_lat = float(latitude)
        point_lon = float(longitude)
        previous_lat = float(self.safezone_polygon_points[-1][0])
        previous_lon = float(self.safezone_polygon_points[-1][1])

        for point in self.safezone_polygon_points:
            current_lat = float(point[0])
            current_lon = float(point[1])

            epsilon = 1e-12
            cross_product = (
                (point_lon - previous_lon) * (current_lat - previous_lat) -
                (point_lat - previous_lat) * (current_lon - previous_lon)
            )
            if abs(cross_product) <= epsilon:
                min_lat = min(previous_lat, current_lat) - epsilon
                max_lat = max(previous_lat, current_lat) + epsilon
                min_lon = min(previous_lon, current_lon) - epsilon
                max_lon = max(previous_lon, current_lon) + epsilon
                if min_lat <= point_lat <= max_lat and min_lon <= point_lon <= max_lon:
                    return True

            crosses_latitude = ((current_lat > point_lat) != (previous_lat > point_lat))
            if crosses_latitude:
                lon_at_point_lat = (
                    (previous_lon - current_lon) * (point_lat - current_lat) /
                    (previous_lat - current_lat)
                ) + current_lon
                if point_lon < lon_at_point_lat:
                    inside = not inside

            previous_lat = current_lat
            previous_lon = current_lon

        return inside

    def update_existing_object(self, stored_object, geolocated_object):
        # Media incrementale: aggiorna posizione e confidenza senza conservare
        # tutte le detection precedenti dell'oggetto.
        old_count = int(stored_object['obs_count'])
        new_count = old_count + 1

        stored_object['confidence'] = (
            (stored_object['confidence'] * old_count) + float(geolocated_object.confidence)
        ) / float(new_count)
        stored_object['lat'] = (
            (stored_object['lat'] * old_count) + float(geolocated_object.latitude)
        ) / float(new_count)
        stored_object['lon'] = (
            (stored_object['lon'] * old_count) + float(geolocated_object.longitude)
        ) / float(new_count)
        stored_object['obs_count'] = new_count

    def publish_object_list(self):
        output = self.build_object_list_output()
        json_text = json.dumps(output, indent=4)
        self.pub_object_list.publish(String(data=json_text))
        rospy.loginfo("[SSS] list_topic: pubblicata lista finale con {} oggetti unici e {} detection totali".format(
            len(self.object_list),
            len(self.complete_object_list)
        ))
        self.save_object_list_json()
        self.save_detection_map()

    def build_object_list_output(self):
        # Costruisce il JSON pubblicato e salvato su file mantenendo un ordine stabile
        # dei campi per rendere piu leggibili i risultati.
        output = OrderedDict()
        for stored_object in self.object_list:
            output[str(stored_object['id'])] = OrderedDict([
                ('confidence', round(float(stored_object['confidence']), 3)),
                ('obs_count', int(stored_object['obs_count'])),
                ('lon', float(stored_object['lon'])),
                ('lat', float(stored_object['lat'])),
                ('type', stored_object['type'])
            ])

        return output

    def save_object_list_json(self):
        output = OrderedDict([
            ('final_list', self.build_object_list_output()),
            #('complete_list', self.build_complete_object_list_output())
        ])

        try:
            with open(self.object_list_json_filename, 'w') as json_file:
                json_file.write(json.dumps(output, indent=4))
                json_file.write("\n")
        except IOError as exc:
            rospy.logwarn("[SSS] Impossibile salvare lista finale JSON: {} ({})".format(
                self.object_list_json_filename,
                exc
            ))

    def normalize_map_object_type(self, object_type):
        # Uniforma nomi italiani/inglesi e classi probabili prima di separare
        # boe e tubi nella mappa finale.
        object_type = str(object_type).strip().lower()
        if object_type in ['boa', 'buoy', 'boa_probabile', 'buoy_probabile']:
            return 'boa'
        if object_type in ['tubo', 'tube', 'tubo_probabile', 'tube_probabile']:
            return 'tubo'
        return None

    def split_map_objects_by_type(self, object_list):
        boas = []
        tubos = []

        for stored_object in object_list:
            object_type = self.normalize_map_object_type(stored_object.get('type', ''))
            map_object = {
                'id': stored_object.get('id', ''),
                'lat': float(stored_object['lat']),
                'lon': float(stored_object['lon'])
            }
            if object_type == 'boa':
                boas.append(map_object)
            elif object_type == 'tubo':
                tubos.append(map_object)

        return boas, tubos


# ________________________________________________________________________________________________________________________________

    # ========================================================
    # MAPPA
    # ========================================================
    def plot_map_objects(self, ax, objects, color, marker, label, label_ids=False, facecolors=None):
        if len(objects) == 0:
            return

        lats = [obj['lat'] for obj in objects]
        lons = [obj['lon'] for obj in objects]

        ax.scatter(
            lons,
            lats,
            s=70,
            c=color if facecolors is None else None,
            marker=marker,
            edgecolors=color,
            facecolors=facecolors,
            linewidths=1.5,
            label=label,
            zorder=4
        )

        if label_ids:
            for obj in objects:
                ax.text(
                    obj['lon'],
                    obj['lat'],
                    str(obj['id']),
                    fontsize=8,
                    color=color,
                    ha='left',
                    va='bottom',
                    zorder=5
                )

    def load_safezone_polygon_points(self):
        polygon_points = []

        try:
            # Stessa procedura usata da FLS: rospkg trova il pacchetto zeno_mission,
            # poi leggiamo i vertici NED del poligono da region_params.yaml.
            rospack = rospkg.RosPack()
            pkg_path = rospack.get_path('zeno_mission')
            yaml_file = os.path.join(pkg_path, 'config', 'region_params.yaml')

            with open(yaml_file, 'r') as safezone_file:
                data = yaml.safe_load(safezone_file)

            origin = data['origin']['coordinates']
            map_origin = (
                float(origin['latitude']),
                float(origin['longitude'])
            )
            vertices_ned = data['polygon_vertices']['original']

            # SSS lavora e disegna in lat/lon, quindi i vertici [North, East]
            # vengono convertiti rispetto all'origine della mappa.
            for vertex in vertices_ned:
                north = float(vertex[0])
                east = float(vertex[1])
                latitude, longitude = ne2ll(map_origin, (north, east))
                polygon_points.append((float(latitude), float(longitude)))

            rospy.loginfo("[SSS] Safezone caricata da region_params.yaml con {} vertici".format(
                len(polygon_points)
            ))
            return polygon_points
        except Exception as exc:
            rospy.logwarn("[SSS] Impossibile leggere safezone da region_params.yaml: {}".format(exc))
            return []

    def plot_polygon_points(self, ax, polygon_points, color, label):
        if len(polygon_points) == 0:
            return

        polygon_lats = [float(point[0]) for point in polygon_points]
        polygon_lons = [float(point[1]) for point in polygon_points]
        polygon_lats.append(float(polygon_points[0][0]))
        polygon_lons.append(float(polygon_points[0][1]))
        ax.plot(polygon_lons, polygon_lats, color=color, linewidth=1.8, label=label, zorder=2)

    def save_detection_map(self):
        # Salva una figura riassuntiva con safezone, oggetti finali e riferimenti manuali.
        final_boas, final_tubos = self.split_map_objects_by_type(self.object_list)
        reference_boas, reference_tubos = self.split_map_objects_by_type(MANUAL_REFERENCE_OBJECTS)

        filename = os.path.join(self.list_text_folder, self.final_map_filename)
        fig = None

        try:
            fig, ax = plt.subplots(figsize=(9, 8))

            self.plot_polygon_points(ax, MANUAL_POLYGON_POINTS, 'black', 'poligono manuale')
            self.plot_polygon_points(ax, self.safezone_polygon_points, 'red', 'safezone')

            self.plot_map_objects(ax, final_boas, 'green', 'o', 'SSS final boa', label_ids=True)
            self.plot_map_objects(ax, final_tubos, 'blue', 's', 'SSS final tubo', label_ids=True)
            self.plot_map_objects(ax, reference_boas, 'black', 'o', 'boa nota', facecolors='none')
            self.plot_map_objects(ax, reference_tubos, 'black', 's', 'tubo noto', facecolors='none')

            # Usa tutti i punti disponibili per impostare limiti coerenti della figura,
            # evitando mappe troppo strette quando ci sono pochi oggetti.
            axis_points = []
            for object_group in [final_boas, final_tubos, reference_boas, reference_tubos]:
                for map_object in object_group:
                    axis_points.append((float(map_object['lat']), float(map_object['lon'])))

            for polygon_group in [MANUAL_POLYGON_POINTS, self.safezone_polygon_points]:
                for point in polygon_group:
                    axis_points.append((float(point[0]), float(point[1])))

            if len(axis_points) > 0:
                lats = [point[0] for point in axis_points]
                lons = [point[1] for point in axis_points]
                min_lat = min(lats)
                max_lat = max(lats)
                min_lon = min(lons)
                max_lon = max(lons)

                lat_span = max_lat - min_lat
                lon_span = max_lon - min_lon
                min_span = 0.0001
                lat_padding = min_span / 2.0 if lat_span < min_span else lat_span * 0.15
                lon_padding = min_span / 2.0 if lon_span < min_span else lon_span * 0.15

                ax.set_xlim(min_lon - lon_padding, max_lon + lon_padding)
                ax.set_ylim(min_lat - lat_padding, max_lat + lat_padding)

            ax.set_xlabel('Longitude')
            ax.set_ylabel('Latitude')
            ax.set_title('SSS final object map')
            ax.grid(True, alpha=0.3)
            ax.set_aspect('equal', adjustable='box')
            ax.legend(loc='best')

            fig.savefig(filename, dpi=200, bbox_inches='tight')
            plt.close(fig)
            return filename
        except Exception as exc:
            rospy.logwarn("Impossibile salvare mappa detection: {} ({})".format(filename, exc))
            if fig is not None:
                plt.close(fig)
            return None


# ________________________________________________________________________________________________________________________________

    # ========================================================
    # GEOLOCALIZZAZIONE
    # ========================================================

    def geolocalize_detection(self, msg, object_index, image_width):
        # xc e' la coordinata across-track; yc identifica il ping dell'immagine waterfall
        centroid_x = float(msg.object_centroid_x_px[object_index])
        centroid_y = float(msg.object_centroid_y_px[object_index])
        row_index  = int(round(centroid_y))

        # convertire la coordinata x del centroide in distanza orizzontale sul fondale
        altitude_m = float(msg.altitudes[row_index])
        nadir_column = image_width / 2.0
        bins_per_side = image_width / 2.0
        if bins_per_side <= 0.0:
            return None

        range_bin = abs(float(centroid_x) - nadir_column)
        meters_per_pixel_slant = self.sonar_range_m / bins_per_side
        slant_range_m = range_bin * meters_per_pixel_slant
        if slant_range_m <= altitude_m:
            rospy.logwarn("Detection in water-column/blind-zone: slant={:.3f} altitude={:.3f}".format(slant_range_m, altitude_m))
            return None

        # Proiezione sul fondale: ground^2 = slant^2 - altitude^2.
        ground_range_m = math.sqrt((slant_range_m * slant_range_m) - (altitude_m * altitude_m))

        # sensor + conversioni body frame -> NED -> latitudine/longitudine
        nav_status = msg.nav_statuses[row_index]
        side = -1.0 if float(centroid_x) < nadir_column else 1.0
        # Nel body frame x e l'offset longitudinale del sensore, y e la distanza
        # laterale dal nadir piu l'offset fisico del sonar.
        body_position = [
            self.sensor_x_offset_m,
            side * (self.sensor_y_offset_m + ground_range_m),
            self.sensor_z_offset_m
        ]
        north_m, east_m, down_m = self.body_to_ned(body_position, nav_status)

        object_latitude, object_longitude = ne2ll(
            [float(nav_status.position.latitude), float(nav_status.position.longitude)],
            [north_m, east_m]
        )

        # risultati geolocalizzazione
        output = GeolocatedObject()
        output.object_class = msg.object_classes[object_index]
        output.confidence = float(msg.object_confidences[object_index])
        output.latitude   = float(object_latitude)
        output.longitude  = float(object_longitude)
        output.ping_index = int(msg.ping_indices[row_index])
        output.ping_stamp = msg.ping_stamps[row_index]
        output.centroid_x_px = centroid_x
        output.centroid_y_px = centroid_y

        if object_index < len(msg.object_bbox_x_px):
            output.bbox_x_px = int(msg.object_bbox_x_px[object_index])
            output.bbox_y_px = int(msg.object_bbox_y_px[object_index])
            output.bbox_width_px = int(msg.object_bbox_width_px[object_index])
            output.bbox_height_px = int(msg.object_bbox_height_px[object_index])

        localization_info = {
            'object_index': int(object_index),
            'row_index': int(row_index),
            'image_width': int(image_width),
            'auv_latitude': float(nav_status.position.latitude),
            'auv_longitude': float(nav_status.position.longitude),
            'auv_yaw_rad': float(nav_status.orientation.yaw),
            'altitude_m': float(altitude_m),
            'slant_range_m': float(slant_range_m),
            'ground_range_m': float(ground_range_m),
            'body_x_m': float(body_position[0]),
            'body_y_m': float(body_position[1]),
            'body_z_m': float(body_position[2]),
            'north_offset_m': float(north_m),
            'east_offset_m': float(east_m),
            'down_offset_m': float(down_m)
        }

        return output, localization_info

    def body_to_ned(self, body_position, nav_status):
        # Converte un punto espresso nel frame body del veicolo nel frame NED locale
        # usando roll, pitch e yaw disponibili nel messaggio di navigazione.
        # orientazione AUV
        roll  = float(nav_status.orientation.roll)
        pitch = float(nav_status.orientation.pitch)
        yaw   = float(nav_status.orientation.yaw)

	
	# matrice di rotazione body -> NED (roll-pitch-yaw)
        cr = math.cos(roll)
        sr = math.sin(roll)
        cp = math.cos(pitch)
        sp = math.sin(pitch)
        cy = math.cos(yaw)
        sy = math.sin(yaw)

        x_body, y_body, z_body = body_position

        north = (cy * cp) * x_body + (cy * sp * sr - sy * cr) * y_body + (cy * sp * cr + sy * sr) * z_body
        east = (sy * cp) * x_body + (sy * sp * sr + cy * cr) * y_body + (sy * sp * cr - cy * sr) * z_body
        down = (-sp) * x_body + (cp * sr) * y_body + (cp * cr) * z_body
	

	# matrice di rotazione body -> NED (yaw)
	#x_body, y_body, z_body = body_position

        #north = math.cos(yaw) * x_body - math.sin(yaw) * y_body
        #east  = math.sin(yaw) * x_body + math.cos(yaw) * y_body
        #down  = z_body

        return north, east, down

    def save_geolocated_list_text(self, geolocated_objects, localization_infos):
        # salvare su file la lista finale con coordinate e dettagli della geolocalizzazione
        filename = os.path.join(self.list_text_folder, "geolocated_list_{:03d}.txt".format(self.list_text_index))
        self.list_text_index += 1

        try:
            with open(filename, 'w') as text_file:
                text_file.write("geolocated_objects_count: {}\n".format(len(geolocated_objects)))
                text_file.write("sonar_range_m: {:.3f}\n".format(self.sonar_range_m))
                text_file.write("sensor_x_offset_m: {:.3f}\n".format(self.sensor_x_offset_m))
                text_file.write("sensor_y_offset_m: {:.3f}\n".format(self.sensor_y_offset_m))
                text_file.write("sensor_z_offset_m: {:.3f}\n".format(self.sensor_z_offset_m))

                if len(geolocated_objects) == 0:
                    text_file.write("\nNessun oggetto geolocalizzato.\n")
                    return filename

                for index, geolocated_object in enumerate(geolocated_objects):
                    info = localization_infos[index]
                    text_file.write("\nOBJECT {}\n".format(index + 1))
                    text_file.write("classification: {}\n".format(geolocated_object.object_class))
                    text_file.write("confidence: {:.3f}\n".format(geolocated_object.confidence))
                    text_file.write("latitude: {:.10f}\n".format(geolocated_object.latitude))
                    text_file.write("longitude: {:.10f}\n".format(geolocated_object.longitude))
                    text_file.write("ping_index: {}\n".format(geolocated_object.ping_index))
                    text_file.write("ping_stamp: {:.9f}\n".format(geolocated_object.ping_stamp.to_sec()))
                    text_file.write("row_index: {}\n".format(info['row_index']))
                    text_file.write("centroid_px: [{:.2f}, {:.2f}]\n".format(geolocated_object.centroid_x_px, geolocated_object.centroid_y_px))
                    text_file.write("bbox_px: [{}, {}, {}, {}]\n".format(
                        geolocated_object.bbox_x_px,
                        geolocated_object.bbox_y_px,
                        geolocated_object.bbox_width_px,
                        geolocated_object.bbox_height_px
                    ))
                    text_file.write("auv_latitude: {:.10f}\n".format(info['auv_latitude']))
                    text_file.write("auv_longitude: {:.10f}\n".format(info['auv_longitude']))
                    text_file.write("auv_yaw_rad: {:.6f}\n".format(info['auv_yaw_rad']))
                    text_file.write("altitude_m: {:.3f}\n".format(info['altitude_m']))
                    text_file.write("slant_range_m: {:.3f}\n".format(info['slant_range_m']))
                    text_file.write("ground_range_m: {:.3f}\n".format(info['ground_range_m']))
                    text_file.write("body_position_m: [{:.3f}, {:.3f}, {:.3f}]\n".format(
                        info['body_x_m'],
                        info['body_y_m'],
                        info['body_z_m']
                    ))
                    text_file.write("ned_offset_m: [{:.3f}, {:.3f}, {:.3f}]\n".format(
                        info['north_offset_m'],
                        info['east_offset_m'],
                        info['down_offset_m']
                    ))
        except IOError as exc:
            rospy.logwarn("Impossibile salvare lista geolocalizzata: {} ({})".format(filename, exc))

        return filename

# ============================================================
# MAIN
# ============================================================
if __name__ == "__main__":

    # inizializzare nodo ROS
    rospy.init_node('geolocalization_node', anonymous=True)
    # istanziare GeolocalizationNode
    node = GeolocalizationNode()
    # spin ROS
    rospy.spin()
