#!/usr/bin/env python

import  rospy
import  tf

import  numpy as np

from joystick_command.msg   import Rel_error_joystick
from marta_msgs.msg         import NavStatus

from geodetic_functions import ne2ll

def wrapToPi(angle):
    return (angle + np.pi) % (2 * np.pi) - np.pi

class ZenoSim():
    def __init__(self):

        # Initialize the ROS node
        rospy.init_node('zeno')

        # Initialize the rate
        self.rate = rospy.Rate(10)

        # Import origin coordinates from parameters in lat lon format     
        self.origin         = self.init_origin()

        # Import Zeno velocity limits from parameters files
        self.v_surge_max    = rospy.get_param('/zeno/vel_max/surge', 0.2)               # m/s
        self.v_sway_max     = rospy.get_param('/zeno/vel_max/sway', 0.2)                # m/s
        self.v_heave_max    = rospy.get_param('/zeno/vel_max/heave', 0.125)               # m/s
        self.omega_max      = np.deg2rad(rospy.get_param('/zeno/vel_max/omega', 10.0))  # rad/s
        
        # Import PID gains from parameters
        K_yaw   = rospy.get_param('/zeno/P_controller/yaw', 0.20)
        K_omega = rospy.get_param('/zeno/P_controller/omega', 0.50)
        K_surge = rospy.get_param('/zeno/P_controller/surge', 0.25)
        K_sway  = rospy.get_param('/zeno/P_controller/sway', 0.25)
        K_depth = rospy.get_param('/zeno/P_controller/depth', 0.01)
        K_heave = rospy.get_param('/zeno/P_controller/heave', 0.1)

        # Store the PID gains in a dictionary
        self.K  = {'yaw': K_yaw, 'omega': K_omega, 'v_surge': K_surge, 'v_sway': K_sway, 'v_heave': K_heave, 'depth': K_depth}	

        # Initialize Zeno Pose, which is the position of the robot w.r.t. the origin
        self.x      = rospy.get_param('/zeno/init_pose/north', 0.0)                  # m
        self.y      = rospy.get_param('/zeno/init_pose/east', 0.0)                 # m
        self.depth  = rospy.get_param('/zeno/init_pose/depth', 0.0)                 # m
        self.yaw    = np.deg2rad(rospy.get_param('/zeno/init_pose/yaw', 0.0))       # deg -> rad

        # Initialize Zeno Twist
        self.v_surge    = 0.0   # m/s
        self.v_sway     = 0.0   # m/s
        self.v_heave    = 0.0   # m/s   
        self.omega      = 0.0   # rad/s

        # Initialize Zeno commands 
        self.yaw_des        = np.rad2deg(self.yaw)  # deg
        self.v_surge_des    = 0.0                   # m/s
        self.v_sway_des     = 0.0                   # m/s
        self.depth_des      = self.depth            # m

        # Subscribe to the relative error topic
        rospy.Subscriber("/relative_error", Rel_error_joystick, self.rel_error_callback)

        # Initialize the nav_status publisher
        self.pub_nav_status = rospy.Publisher("/nav_status", NavStatus, queue_size=1)

        # # Initialize the transform broadcaster
        self.broadcaster = tf.TransformBroadcaster()

    def init_origin(self):
        """
        Initialize the origin coordinates of the NED frame in latitude, longitude and depth format.
        The origin coordinates are retrieved from the ROS parameter server.
        Returns:
            [latitude, longitude, depth]: The coordinates of the origin.
        """

        # Retrieve the origin coordinates from the parameters
        coordinates = rospy.get_param('/origin/coordinates', None)

        # Check if the coordinates were found
        if coordinates is None:
            rospy.logerr("Origin coordinates not found in parameters.")
            return None, None, None
        
        lat     = coordinates['latitude']
        lon     = coordinates['longitude']
        depth   = coordinates['depth']

        return [lat, lon, depth]

    def update_pose(self, dt):
        """
        Update the pose of the robot based on the current velocities and accelerations of the robot for
        a given time step.
        Parameters:
            dt (float): The time step to update the pose of the robot.
        """
        # type: (float) -> None

        # Update errors with respect to the desired values
        yaw_error      = wrapToPi(self.yaw_des - self.yaw)
        depth_error    = self.depth_des - self.depth
        v_surge_error  = self.v_surge_des - self.v_surge
        v_sway_error   = self.v_sway_des - self.v_sway

        # PID controller for the accelerations of the robot (angular and linear)
        alpha       = self.K['yaw'] * yaw_error - self.K['omega'] * self.omega
        a_surge     = self.K['v_surge'] * v_surge_error
        a_sway      = self.K['v_sway'] * v_sway_error
        a_heave     = self.K['depth'] * depth_error - self.K['v_heave'] * self.v_heave

        # Update the velocities of the robot based on the accelerations calculated
        # on the previous step
        self.omega      = np.clip(self.omega + alpha * dt, - self.omega_max, self.omega_max)
        self.v_surge    = np.clip(self.v_surge + a_surge * dt, - self.v_surge_max, self.v_surge_max)
        self.v_sway     = np.clip(self.v_sway + a_sway * dt, - self.v_sway_max, self.v_sway_max)
        self.v_heave    = np.clip(self.v_heave + a_heave * dt, - self.v_heave_max, self.v_heave_max)

        # Update the pose of the robot based on the velocities calculated on the previous step
        self.yaw    = wrapToPi(self.yaw + self.omega * dt)
        self.x      = self.x + (self.v_surge * np.cos(self.yaw) - self.v_sway * np.sin(self.yaw)) * dt
        self.y      = self.y + (self.v_surge * np.sin(self.yaw) + self.v_sway * np.cos(self.yaw)) * dt
        self.depth  = self.depth + self.v_heave * dt

        if self.depth < 0.0:
            self.depth = 0.0

    def position2latlon(self, x, y):
        """
        This function converts the (x, y) coordinates w.r.t the origin to 
        latitude, longitude coordinates.
        Args:
            x (float): The x coordinate in meters.
            y (float): The y coordinate in meters.
        Returns:
            [latitude, longitude]: The latitude, longitude coordinates.
        """
        lat, lon = ne2ll(self.origin[0:2], (x, y))

        return [lat, lon]
        
    def nav_status_publish(self):
        """
        Publish the NavStatus message containing the robot's position, orientation, and speed.
        """

        # Get Zeno coordinates in lat lon format
        lat, lon = self.position2latlon(self.x, self.y)

        # Convert the velocities to NED coordinates
        # (positive surge is forward, positive sway is right, positive omega is clockwise)
        ned_v_x     = self.v_surge * np.cos(self.yaw) - self.v_sway * np.sin(self.yaw)
        ned_v_y      = self.v_surge * np.sin(self.yaw) + self.v_sway * np.cos(self.yaw)

        # Initialize the NavStatus message
        nav_status                  = NavStatus() 
        nav_status.header.stamp     = rospy.Time.now()
        nav_status.header.frame_id  = ""

        # Position
        nav_status.position.latitude    = lat
        nav_status.position.longitude   = lon
        nav_status.position.depth       = self.depth

        # Orientation
        nav_status.orientation.roll      = 0.0
        nav_status.orientation.pitch     = 0.0
        nav_status.orientation.yaw       = self.yaw

        # Orientation quaternion
        q = tf.transformations.quaternion_from_euler(0.0, 0.0, self.yaw)
        nav_status.quaternion.x = q[0]
        nav_status.quaternion.y = q[1]
        nav_status.quaternion.z = q[2]
        nav_status.quaternion.w = q[3]

        # NED speed
        nav_status.ned_speed.x = ned_v_x
        nav_status.ned_speed.y = ned_v_y
        nav_status.ned_speed.z = self.v_heave

        # Omega body
        nav_status.omega_body.x = 0.0
        nav_status.omega_body.y = 0.0
        nav_status.omega_body.z = self.omega

        # Other fields
        nav_status.gps_status   = 1
        nav_status.initialized  = True

        # Publish the NavStatus message
        self.pub_nav_status.publish(nav_status)

    def rel_error_callback(self, msg):
        """
        Callback function executed when a new joystick command is received.
        After receiving the command, the desired yaw and velocities are updated.
        Parameters:
            msg (Rel_error_joystick): The message containing the joystick commands.
        """

        # Convert joystick commands from NED to ENU
        error_yaw           = msg.error_yaw
        error_surge_speed   = msg.error_surge_speed
        error_sway_speed    = msg.error_sway_speed
        error_depth         = msg.error_depth

        # Update the desired yaw and velocities based on the joystick commands
        # The yaw is converted from degrees to radians
        # The velocities are clipped to the maximum values
        self.yaw_des        = wrapToPi(np.deg2rad(error_yaw) + self.yaw)
        self.v_surge_des    = np.clip(error_surge_speed, -self.v_surge_max, self.v_surge_max)
        self.v_sway_des     = np.clip(error_sway_speed, -self.v_sway_max, self.v_sway_max)
        self.depth_des      = max(0.0, self.depth + error_depth)

    def run(self):
        """ 
        Main loop of the Zeno node.
        Once the node is initialized, it enters a loop where it updates the pose of the robot
        based on the current velocities and accelerations of the robot.
        After updating the pose, it publishes the NavStatus message.
        """

        # Initialize the last time variable
        last_time = rospy.Time.now()

        # Main loop
        while not rospy.is_shutdown():

            # Get the current time
            current_time = rospy.Time.now()

            # Compute the time elapsed since the last iteration of the loop
            dt = (current_time - last_time).to_sec()

            # Update the pose 
            self.update_pose(dt)

            # Publish the NavStatus message
            self.nav_status_publish()

            # Update the last time variable
            last_time = current_time

            # Wait for the next iteration
            self.rate.sleep()      


if __name__ == "__main__":
    try:
        # Create an instance of the ZenoSim class
        zeno = ZenoSim()

        # Run the node
        zeno.run()
    except rospy.ROSInterruptException:
        pass