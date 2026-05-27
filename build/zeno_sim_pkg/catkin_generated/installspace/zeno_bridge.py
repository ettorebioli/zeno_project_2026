#!/usr/bin/env python2

import rospy
import tf
import numpy as np

from geodesy.utm            import fromLatLong
from nav_msgs.msg           import Odometry
from geometry_msgs.msg      import PointStamped
from visualization_msgs.msg import Marker

from marta_msgs.msg         import NavStatus
from joystick_command.msg   import Rel_error_joystick

def wrapToPi(angle):
    return (angle + np.pi) % (2 * np.pi) - np.pi

def make_zeno_marker(point, radius, color=(1.0, 1.0, 0.0)):
    marker = Marker()
    marker.header.frame_id = "map"
    marker.header.stamp = rospy.Time.now()
    marker.ns = "zeno"
    marker.id = 0
    marker.type = Marker.CYLINDER
    marker.action = Marker.ADD
    marker.pose.position.x = point[0]
    marker.pose.position.y = point[1]
    marker.pose.position.z = 0.0
    marker.pose.orientation.x = 0.0
    marker.pose.orientation.y = 0.0
    marker.pose.orientation.z = 0.0
    marker.pose.orientation.w = 1.0
    marker.scale.x = 2.0 * radius
    marker.scale.y = 2.0 * radius
    marker.scale.z = 0.05
    marker.color.a = 1.0
    marker.color.r = color[0]
    marker.color.g = color[1]
    marker.color.b = color[2]
    return marker


class ZenoBridge():

    def __init__(self):
        rospy.init_node('zeno_bridge')
        self.rate   = rospy.Rate(10)
        self.ns     = rospy.get_namespace()
        self.frame  = self.ns + "base_link"
        
        self.utm_map_listener   = tf.TransformListener()
        self.pub_odom           = rospy.Publisher("odom", Odometry, queue_size=1)
        self.broadcast_odom     = tf.TransformBroadcaster()

        if self.ns == "/zeno_1/" or self.ns == "":
            nav_status      = "/nav_status"
            relative_error  = "/relative_error"
            self.marker_color = (1.0, 1.0, 0.0)
        else:
            nav_status      = "nav_status"
            relative_error  = "relative_error"
            self.marker_color = (1.0, 0.5, 0.0)

        rospy.Subscriber(nav_status, NavStatus, self.nav_status_callback)
        rospy.Subscriber("enu_relative_error", Rel_error_joystick, self.enu_relative_error_callback)

        self.pub_rel_error  = rospy.Publisher(relative_error, Rel_error_joystick, queue_size=1)
        self.pub_marker     = rospy.Publisher("zeno_marker", Marker, queue_size=1)

    def enu_relative_error_callback(self, msg):
        """
        Callback per la gestione degli errori relativi.
        Questa funzione prende gli errori in terna ENU (East-North-Up) dal messaggio ricevuto
        e li pubblica in terna NED (North-East-Down) su /relative_error.
        Args:
            msg: Messaggio contenente gli errori in terna ENU.
        """
        ned_error = Rel_error_joystick()
    
        ned_error.error_yaw             = - msg.error_yaw
        ned_error.error_surge_speed     = msg.error_surge_speed
        ned_error.error_sway_speed      = - msg.error_sway_speed

        self.pub_rel_error.publish(ned_error)  

    def get_map_coordinates(self, utm_position):
        """
        Converts the input from a UTM coordinate system to the map coordinate system.

        Args:
            utm_position: The position in UTM coordinates.

        Returns:
            A tuple of (x, y) in the map frame, or (None, None) if the transform fails.
        """
        # Extract the UTM coordinates
        x   = utm_position.easting
        y   = utm_position.northing

        # Prepare the PointStamped message
        utm_point                   = PointStamped()
        utm_point.header.stamp      = rospy.Time(0)
        utm_point.header.frame_id   = "utm"
        utm_point.point.x           = x
        utm_point.point.y           = y
        utm_point.point.z           = 0.0

        try:
            self.utm_map_listener.waitForTransform("map", "utm", rospy.Time(0), rospy.Duration(15.0))
            map_point = self.utm_map_listener.transformPoint("map", utm_point)
            x = map_point.point.x
            y = map_point.point.y
            return x, y 

        except (tf.LookupException, tf.ConnectivityException, tf.ExtrapolationException) as e:
            rospy.logerr("Error in transformation from 'utm' to 'map': " + str(e))
            return None, None
        
    def nav_status_callback(self, msg):
        """
        This function processes the navigation status message, converts the GPS coordinates to UTM,
        transforms them to the map frame, and publishes the corresponding odometry message.
    
        Args:
            msg (NavStatus): The navigation status message containing position, orientation, and speed information.
        """

        lat = msg.position.latitude
        lon = msg.position.longitude

        # Check if the latitude and longitude are valid data
        if not (-90 <= lat <= 90 and -180 <= lon <= 180):
            rospy.logerr("Invalid latitude or longitude in NavStatus message")
            return
        
        utm_position    = fromLatLong(lat, lon)

        enu_x, enu_y    = self.get_map_coordinates(utm_position)
        ned_yaw         = msg.orientation.yaw
        enu_yaw         = wrapToPi(np.pi/2 - msg.orientation.yaw)
        enu_quaternion  = tf.transformations.quaternion_from_euler(0, 0, enu_yaw)

        # Check if the transformation was successful
        if enu_x is None or enu_y is None:
            return

        body_v_surge    = msg.ned_speed.x * np.cos(ned_yaw) + msg.ned_speed.y * np.sin(ned_yaw)
        body_v_sway     = + msg.ned_speed.x * np.sin(ned_yaw) - msg.ned_speed.y * np.cos(ned_yaw)
        body_omega      = - msg.omega_body.z

        # Prepare the odometry message
        odom = Odometry()
        odom.header.stamp       = rospy.Time.now()
        odom.header.frame_id    = "map"
        odom.child_frame_id     = self.frame

        # Fill the pose fields with the ENU coordinates
        odom.pose.pose.position.x       = enu_x
        odom.pose.pose.position.y       = enu_y
        odom.pose.pose.position.z       = 0.0
        odom.pose.pose.orientation.x    = enu_quaternion[0]
        odom.pose.pose.orientation.y    = enu_quaternion[1]
        odom.pose.pose.orientation.z    = enu_quaternion[2]
        odom.pose.pose.orientation.w    = enu_quaternion[3]

        # Fill the twist fields with the body velocities
        odom.twist.twist.linear.x   = body_v_surge
        odom.twist.twist.linear.y   = body_v_sway
        odom.twist.twist.angular.z  = body_omega

        # Publish the odometry message
        self.pub_odom.publish(odom)

        # Broadcast the transform map -> base_link
        self.broadcast_odom.sendTransform(  
            (enu_x, enu_y, 0), 
            enu_quaternion,
            rospy.Time.now(), 
            self.frame, 
            "map")
        
        # Publish the marker
        marker = make_zeno_marker((enu_x, enu_y), radius=0.5, color=self.marker_color)
        self.pub_marker.publish(marker)

    def run(self):
        while not rospy.is_shutdown():
            self.rate.sleep()


if __name__ == "__main__":
    try:
        zeno_bridge = ZenoBridge()
        zeno_bridge.run()
    except rospy.ROSInterrupt:
        pass

