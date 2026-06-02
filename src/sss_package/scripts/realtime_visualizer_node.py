#!/usr/bin/env python2.7
# -*- coding: utf-8 -*-


# ============================================================
# IMPORT LIBRERIE
# ============================================================
import cv2
import rospy
from cv_bridge import CvBridge, CvBridgeError
from sss_package.msg import ImageMetadata



# ============================================================
# CLASSE PRINCIPALE NODO REAL-TIME VISUALIZER
# ============================================================
class RealtimeVisualizerNode:

    def __init__(self):

        print("[SSS] realtime_visualizer_node.py is active\n")

        # inizializzare subscriber/publisher
        rospy.Subscriber('/waterfall_realtime_topic', ImageMetadata, self.realtime_waterfall_callback, queue_size=100)
        rospy.Subscriber('/classified_objects_topic', ImageMetadata, self.classified_objects_callback, queue_size=100)
        rospy.on_shutdown(cv2.destroyAllWindows)

        # inizializzare CvBridge
        self.bridge = CvBridge()

        # inizializzare parametri display
        self.window_name        = rospy.get_param('~window_name', 'SSS live waterfall detections')
        self.max_display_width  = int(rospy.get_param('~max_display_width', 1200))
        self.max_display_height = int(rospy.get_param('~max_display_height', 800))
        self.detection_history = []


# ________________________________________________________________________________________________________________________________


    # ========================================================
    # CALLBACK DETECTED OBJECTS
    # ========================================================
    def classified_objects_callback(self, msg):
        # 1. ricevere le detection da object_classification_node e per ciascuna salvare
        # bbox, classe, confidenza e ping corrispondenti
        detections = []
        for index, object_class in enumerate(msg.object_classes):
            y = int(msg.object_bbox_y_px[index])
            h = int(msg.object_bbox_height_px[index])
            bottom_y = y + h - 1
            centroid_y = int(round(msg.object_centroid_y_px[index]))

            # 2. salvare le detection usando gli indici dei ping
            # cosi il box resta allineato mentre la waterfall scorre verso il basso
            detections.append({
                'class': object_class,
                'confidence': float(msg.object_confidences[index]),
                'x': int(msg.object_bbox_x_px[index]),
                'w': int(msg.object_bbox_width_px[index]),
                'top_ping': int(msg.ping_indices[y]),
                'bottom_ping': int(msg.ping_indices[bottom_y]),
                'centroid_ping': int(msg.ping_indices[centroid_y]),
                'centroid_x': float(msg.object_centroid_x_px[index])
            })

        self.detection_history.extend(detections)


    # ========================================================
    # CALLBACK LIVE WATERFALL
    # ========================================================
    def realtime_waterfall_callback(self, msg):
        # 1. convertire live waterfall
        try:
            image = self.bridge.imgmsg_to_cv2(msg.image, desired_encoding='mono8')
        except CvBridgeError as exc:
            rospy.logerr("Errore conversione live waterfall: %s", exc)
            return

        # 2. sovrapporre bbox
        overlay = cv2.cvtColor(image, cv2.COLOR_GRAY2BGR)
        self.draw_detection_history(overlay, msg.ping_indices)

        # 3. display risultati 
        cv2.imshow(self.window_name, self.fit_to_screen(overlay))
        cv2.waitKey(1)



    def draw_detection_history(self, image, live_ping_indices):
        # mappare ogni ping attualmente visibile alla sua riga nella waterfall live
        ping_to_row = {}
        for row, ping_index in enumerate(live_ping_indices):
            ping_to_row[int(ping_index)] = int(row)

        visible_detections = []
        for detection in self.detection_history:
            # se il box esce dalla finestra di 500 ping, viene eliminato
            if detection['top_ping'] not in ping_to_row or detection['bottom_ping'] not in ping_to_row:
                continue

            # ricostruire la posizione verticale del box nella waterfall corrente
            y1 = ping_to_row[detection['top_ping']]
            y2 = ping_to_row[detection['bottom_ping']]
            top_y = min(y1, y2)
            height = abs(y2 - y1) + 1

            x = detection['x']
            w = detection['w']
            label = "{} {:.2f}".format(detection['class'], detection['confidence'])

            # colori in formato BGR di OpenCV
            if detection['class'] == 'buoy':
                color = (0, 255, 0)      # verde
            elif detection['class'] == 'tube':
                color = (255, 0, 0)      # blu
            else:
                color = (255, 0, 255)    # magenta

            cv2.rectangle(image, (x, top_y), (x + w, top_y + height), color, 2)

            # disegnare anche il centroide dell'oggetto rilevato
            cx = int(round(detection['centroid_x']))
            cy = ping_to_row[detection['centroid_ping']]
            cv2.circle(image, (cx, cy), 3, color, -1)

            cv2.putText(image, label, (x, max(15, top_y - 6)),
                        cv2.FONT_HERSHEY_SIMPLEX, 0.45, color, 1, cv2.LINE_AA)
            visible_detections.append(detection)

        self.detection_history = visible_detections

        # mostrare quante detection sono ancora visibili nella finestra da 500 ping
        cv2.putText(image, "detections: {}".format(len(visible_detections)), (8, 18),
                    cv2.FONT_HERSHEY_SIMPLEX, 0.5, (255, 255, 255), 1, cv2.LINE_AA)

    def fit_to_screen(self, image):
        # ridimensionare solo se l'immagine e piu grande della finestra massima
        height, width = image.shape[:2]
        scale = min(float(self.max_display_width) / float(width),
                    float(self.max_display_height) / float(height),
                    1.0)
        if scale < 1.0:
            return cv2.resize(image, None, fx=scale, fy=scale, interpolation=cv2.INTER_AREA)
        return image


# ============================================================
# MAIN
# ============================================================
if __name__ == '__main__':
    rospy.init_node('realtime_visualizer_node')
    RealtimeVisualizerNode()
    rospy.spin()
