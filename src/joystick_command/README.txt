######################################################################################
                                JOYSTICK_COMMAND PKG
######################################################################################

This package has two different functions:

1. It contains a script that interfaces with Zeno AUV allowing to send commands 
to Zeno. 

2. It defines a custom message 'joystick_command\Rel_error_joystick' that will be 
used to send the commands to Zeno. 

###################################  DEPENDENCIES  ###################################

With this package is needed also the package:
1.  marta_msgs

You will find the installation guide of the package inside it's folder.

###################################  INSTALLATION  ###################################

To include 'joystick_command' package in your ROS workspace, follow these steps:

1. Copy the 'joystick_command' package into your workspace source directory:

your_workspace
|---src
    |--- joystick_command
    |--- other_pkg 
    ...

2. Build your workspace:
cd ~/your_workspace
catkin_make

##############################  USAGE IN OTHER PACKAGES ##############################

In order to use the custom message 'joystick_command\Rel_error_joystick' in other 
packages, you must add 'joystick_command' as a dependency following these steps:

1. In your other package go in 'package.xml' and add:

<build_depend>joystick_command</build_depend>
<exec_depend>joystick_command</exec_depend>
<exec_depend>message_runtime</exec_depend>   # To utilize custom generated msgs

2. In your other package go in 'CMakeList.txt', add the 'joystick_command' to 
the following commands:

find_package(catkin REQUIRED COMPONENTS
    ...  (other dependencies here)
    message_runtime     
    joystick_command
)

generate_messages(
    DEPENDENCIES ... (other dependencies here) ... joystick_command)

catkin_package(
    CATKIN_DEPENDS ... (other dependencies here) ... joystick_command)


3. After these steps, rebuild your workspace to incorporate changes:

cd ~/your_workspace 
catkin_make

4. In order to utilize the desired message in your ROS node you must include them as
follows:

C++ 
#include joystick_command/Rel_error_joystick.h

python
from joystick_command import Rel_error_joystick

######################################  USAGE  #######################################

This ROS node connects to both Zeno Simulation MDMHmi and the zeno simulation node 
in the zeno_sim_pkg.

Launch command: 

roslaunch joystick_command Zeno_reference.launch

Subscribed topic:   /relative_error
Message type:       joystick_command/Rel_error_joystick

Once launched it will listen to a topic called /relative_error that receives a message
of type 'joystick_command/Rel_error_joystick.msg'. The structure of the message is the 
following:

Header header

float64 error_roll          # Roll relative error   [deg]
float64 error_pitch         # Pitch relative error  [deg]
float64 error_yaw           # Yaw relative error    [deg]

float64 error_distance      # Frontal distance relative error   [m]
float64 error_depth         # Depth relative error              [m]

float64 error_surge_speed   # Desired absolute surge speed (x axis) [m/s]
float64 error_sway_speed    # Desired absolute sway speed (y axis)  [m/s]

For the student exercises, only the following fields can be used:

1. error_yaw
2. error_surge_speed

All the other fields of the message must be left untouched.

The maximum allowed command values are:

1. error_yaw: 45 deg
2. error_surge_speed: 0.20 m/s

This means that students can command Zeno only by setting a desired relative yaw
angle and a desired surge speed. Sway, depth, roll, pitch and all the other
controls must not be used.

Example of usage (python):

If you want to control Zeno surge speed at 0.20 m/s and set a relative yaw of 30 deg,
you must create a message:

import rospy 
from joystick_command.msg import Rel_error_joystick

rospy.init_node('example_publisher') 
pub = rospy.Publisher('/relative_error', Rel_error_joystick, queue_size=1)

# Command: set surge speed to 0.20 m/s and relative yaw to 30 deg

msg = Rel_error_joystick() 
msg.error_surge_speed = 0.20
msg.error_yaw = 30.0
pub.publish(msg)

Upon receiving a message, Zeno updates its reference and converges to the 
desired value over time and once reached, will stay at that value.

# To stop Zeno: publish an empty message

stop_msg = Rel_error_joystick() 
pub.publish(stop_msg)

########################## USAGE WITH ZENO #######################################

When using it on the real Zeno it's mandatory to not include this launcher in any 
of your launch files, it must be launched in a dedicated terminal in order to be 
able to stop the execution at any moment.