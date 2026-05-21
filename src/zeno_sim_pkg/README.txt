######################################################################################
                                ZENO_SIM_PKG PKG
######################################################################################

The purpose of this package is to simulate Zeno dynamics in 2D plane and it's ROS 
architecture. You can use the node included in this package as a black box with the
same inputs and outputs of Zeno:

\relative_error ------> zeno_simulation ------> \nav_status
(topic)                 (node)                  (topic)

\relative_error: in this topic is possible to send a joystick_command\Rel_error_joystick 
message to control the Zeno simuation in 2D plane

\nav_status: in this topic a marta_msgs\NavStatus message will be pubished.

###################################  DEPENDENCIES  ###################################

With this package is needed also the packages:
1.  marta_msgs
2.  joystick_command

You will find the installation guide of those packages inside their folders.

###################################  INSTALLATION  ###################################

To include 'zeno_sim_pkg' package in your ROS workspace, follow these steps:

1. Copy the 'zeno_sim_pkg' package into your workspace source directory:

your_workspace
|---src
    |--- zeno_sim_pkg
    |--- other_pkg 
    ...

2. Build your workspace:
cd ~/your_workspace
catkin_make

######################################  USAGE  #######################################

To correctly execute the node definied in this package, it must be launched with the
following command:

roslaunch zeno_sim_pkg zeno.launch

This launcher loads some parameters that are mandatory for a correcrt usage.

After the file is launched it's possible to send some commands to Zeno throught the 
\relative_error topic and read it's status update throught \nav_staus topic.

###################################  PARAMETERS  #####################################

In the file config/params.yaml you can modify the following parameters:

# Coordinates of a fixed NED frame. The purpose of this origin is for being able to 
# define zeno initial pose w.r.t that frame. The coordinates give are located at the 
# lakes that will be used for the experiments.

origin:
  coordinates:
      latitude:   43.706259955156185    # deg
      longitude:  10.47519700159793     # deg


# Here you can change Zeno initial pose w.r.t. the origin NED frame defined above.
zeno:
  init_pose:
    north:  0.0     # m
    east:   0.0     # m
    down:   0.0     # m
    yaw:    0.0     # deg