#!/usr/bin/env python2.7
# -*- coding: utf-8 -*-

# ============================================================
# IMPORT LIBRERIE
# ============================================================
import math
import os
import rospkg
import sys
import json
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
# DATI MANUALI PER MAPPA FINALE
# ============================================================
# Inserire punti come (latitudine, longitudine).
MANUAL_POLYGON_POINTS = [

    # allenamento_7_10
    (43.7065117, 10.4750928),
    (43.7062829, 10.4755984),
    (43.7063663, 10.4757727),
    (43.7067269, 10.4754723),
    (43.7067599, 10.4752309),
    (43.7065117, 10.4750928)
]

# inserire oggetti noti del file .csv
MANUAL_REFERENCE_OBJECTS = [
    
    # allenamento_7
    {'type': 'boa', 'lat': 43.7065128, 'lon': 10.4752562},
    {'type': 'boa', 'lat': 43.7066204, 'lon': 10.4754251},
    {'type': 'boa', 'lat': 43.7066514, 'lon': 10.4752405},
    {'type': 'boa', 'lat': 43.7064982, 'lon': 10.4754498},
    {'type': 'boa', 'lat': 43.7063935, 'lon': 10.4756603},
    {'type': 'boa', 'lat': 43.7064003, 'lon': 10.4755168},
    {'type': 'tubo', 'lat': 43.706569, 'lon': 10.4753291},
    {'type': 'tubo', 'lat': 43.7064866, 'lon': 10.4755785},
    {'type': 'tubo', 'lat': 43.7064439, 'lon': 10.4753747},
    {'type': 'tubo', 'lat': 43.7066902, 'lon': 10.4753438},
    {'type': 'tubo', 'lat': 43.706347, 'lon': 10.4755799},
    {'type': 'tubo', 'lat': 43.706568, 'lon': 10.4755034},
    {'type': 'tubo', 'lat': 43.7065293, 'lon': 10.4751467}

    # allenamento_10

    #{'type': 'boa', 'lat': 43.7065128, 'lon': 10.4752562},
    #{'type': 'boa', 'lat': 43.7066204, 'lon': 10.4754251},
    #{'type': 'boa', 'lat': 43.7066514, 'lon': 10.4752405},
    #{'type': 'boa', 'lat': 43.7064982, 'lon': 10.4754498},
    #{'type': 'boa', 'lat': 43.7063935, 'lon': 10.4756603},
    #{'type': 'boa', 'lat': 43.7064003, 'lon': 10.4755168},
   # 
    #{'type': 'tubo', 'lat': 43.7065690, 'lon': 10.4753291},
    #{'type': 'tubo', 'lat': 43.7064866, 'lon': 10.4755785},
    #{'type': 'tubo', 'lat': 43.7064439, 'lon': 10.4753747},
    #{'type': 'tubo', 'lat': 43.7066902, 'lon': 10.4753438},
    #{'type': 'tubo', 'lat': 43.7063470, 'lon': 10.4755799},
    #{'type': 'tubo', 'lat': 43.7065680, 'lon': 10.4755034},
    #{'type': 'tubo', 'lat': 43.7065293, 'lon': 10.4751467}

]


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

        # creazione cartelle per i risultati
        rospack = rospkg.RosPack()
        pkg_path = rospack.get_path('sss_package') 
        default_folder = os.path.join(pkg_path, 'results', '9_list_texts')
        self.list_text_folder = rospy.get_param('~list_text_folder', default_folder)
        if not os.path.exists(self.list_text_folder):
            os.makedirs(self.list_text_folder)

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

    def update_complete_object_list(self, geolocated_objects):
        for geolocated_object in geolocated_objects:
            object_type = self.convert_classification(geolocated_object.object_class)
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
        for geolocated_object in geolocated_objects:
            object_type = self.convert_classification(geolocated_object.object_class)
            if object_type is None:
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

    def convert_classification(self, object_class):
        if object_class == 'buoy':
            return 'boa_probabile'
        if object_class == 'tube':
            return 'tubo_probabile'
        return None

    def find_matching_object(self, geolocated_object, object_type):
        best_object = None
        best_distance = None

        for stored_object in self.object_list:
            if stored_object['type'] != object_type:
                continue

            distance = self.distance_between_objects(stored_object, geolocated_object)
            if distance <= self.object_match_distance_m:
                if best_distance is None or distance < best_distance:
                    best_distance = distance
                    best_object = stored_object

        return best_object

    def distance_between_objects(self, stored_object, geolocated_object):
        north_m, east_m = ll2ne(
            [stored_object['lat'], stored_object['lon']],
            [float(geolocated_object.latitude), float(geolocated_object.longitude)]
        )
        return math.sqrt((north_m * north_m) + (east_m * east_m))

    def update_existing_object(self, stored_object, geolocated_object):
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

    def build_complete_object_list_output(self):
        output = OrderedDict()
        for complete_object in self.complete_object_list:
            output[str(complete_object['id'])] = OrderedDict([
                ('confidence', round(float(complete_object['confidence']), 3)),
                ('obs_count', int(complete_object['obs_count'])),
                ('lon', float(complete_object['lon'])),
                ('lat', float(complete_object['lat'])),
                ('type', complete_object['type'])
            ])

        return output

    def save_object_list_json(self):
        filename = os.path.join(self.list_text_folder, "final_object_list.json")
        output = OrderedDict([
            ('final_list', self.build_object_list_output()),
            ('complete_list', self.build_complete_object_list_output())
        ])

        try:
            with open(filename, 'w') as json_file:
                json_file.write(json.dumps(output, indent=4))
                json_file.write("\n")
        except IOError as exc:
            rospy.logwarn("[SSS] Impossibile salvare lista finale JSON: {} ({})".format(filename, exc))

    def normalize_map_object_type(self, object_type):
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

    def save_detection_map(self):
        final_boas, final_tubos = self.split_map_objects_by_type(self.object_list)
        reference_boas, reference_tubos = self.split_map_objects_by_type(MANUAL_REFERENCE_OBJECTS)

        filename = os.path.join(self.list_text_folder, self.final_map_filename)
        fig = None

        try:
            fig, ax = plt.subplots(figsize=(9, 8))

            if len(MANUAL_POLYGON_POINTS) > 0:
                polygon_lats = [float(point[0]) for point in MANUAL_POLYGON_POINTS]
                polygon_lons = [float(point[1]) for point in MANUAL_POLYGON_POINTS]
                polygon_lats.append(float(MANUAL_POLYGON_POINTS[0][0]))
                polygon_lons.append(float(MANUAL_POLYGON_POINTS[0][1]))
                ax.plot(polygon_lons, polygon_lats, color='black', linewidth=1.8, label='poligono', zorder=2)

            self.plot_map_objects(ax, final_boas, 'green', 'o', 'SSS final boa', label_ids=True)
            self.plot_map_objects(ax, final_tubos, 'blue', 's', 'SSS final tubo', label_ids=True)
            self.plot_map_objects(ax, reference_boas, 'black', 'o', 'boa nota', facecolors='none')
            self.plot_map_objects(ax, reference_tubos, 'black', 's', 'tubo noto', facecolors='none')

            ax.set_xlabel('Longitude')
            ax.set_ylabel('Latitude')
            ax.set_title('SSS final object map')
            ax.grid(True, alpha=0.3)
            ax.axis('equal')
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
        # xc e la coordinata across-track; yc identifica il ping dell immagine waterfall
        centroid_x = float(msg.object_centroid_x_px[object_index])
        centroid_y = float(msg.object_centroid_y_px[object_index])
        row_index  = int(round(centroid_y))

        # convertire la coordinata x del centroide in distanza orizzontale sul fondale
        altitude_m = float(msg.altitudes[row_index])
        ranges = self.centroid_x_to_ranges(centroid_x, image_width, altitude_m)
        if ranges is None:
            return None
        slant_range_m, ground_range_m = ranges

        # sensor + conversioni body frame -> NED -> latitudine/longitudine
        nav_status = msg.nav_statuses[row_index]
        body_position = self.ground_range_to_body_position(centroid_x, image_width, ground_range_m)
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

    def centroid_x_to_ranges(self, centroid_x, image_width, altitude_m):
        # la colonna centrale rappresenta il nadir
        nadir_column = image_width / 2.0
        bins_per_side = image_width / 2.0
        if bins_per_side <= 0.0:
            return None

        # ogni pixel x misura una distanza obliqua
        range_bin = abs(float(centroid_x) - nadir_column)
        meters_per_pixel_slant = self.sonar_range_m / bins_per_side
        slant_range_m = range_bin * meters_per_pixel_slant
        if slant_range_m <= altitude_m:
            rospy.logwarn("Detection in water-column/blind-zone: slant={:.3f} altitude={:.3f}".format(slant_range_m, altitude_m))
            return None

        # proiezione sul fondale: ground^2 = slant^2 - altitude^2
        ground_range_m = math.sqrt((slant_range_m * slant_range_m) - (altitude_m * altitude_m))
        return slant_range_m, ground_range_m

    def ground_range_to_body_position(self, centroid_x, image_width, ground_range_m):
        # lato dell immagine rispetto al nadir
        nadir_column = image_width / 2.0
        side = -1.0 if float(centroid_x) < nadir_column else 1.0

        # coordinate nel body frame: offset del sonar + distanza across-track sul fondale
        x_body = self.sensor_x_offset_m
        y_body = side * (self.sensor_y_offset_m + ground_range_m)
        z_body = self.sensor_z_offset_m
        return [x_body, y_body, z_body]

    def body_to_ned(self, body_position, nav_status):
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

        #north = (cy * cp) * x_body + (cy * sp * sr - sy * cr) * y_body + (cy * sp * cr + sy * sr) * z_body
        #east = (sy * cp) * x_body + (sy * sp * sr + cy * cr) * y_body + (sy * sp * cr - cy * sr) * z_body
        #down = (-sp) * x_body + (cp * sr) * y_body + (cp * cr) * z_body
	

	# matrice di rotazione body -> NED (yaw)
	#x_body, y_body, z_body = body_position

        north = math.cos(yaw) * x_body - math.sin(yaw) * y_body		# segni!! (-)
        east  = math.sin(yaw) * x_body + math.cos(yaw) * y_body		# segni!! (+)
        down  = z_body

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
