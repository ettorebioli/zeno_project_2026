Header header

float64 error_roll          # Roll relative error   [deg]
float64 error_pitch         # Pitch relative error  [deg]
float64 error_yaw           # Yaw relative error    [deg]

float64 error_distance      # Frontal distance relative error   [m]
float64 error_depth         # Depth relative error              [m]

float64 error_surge_speed   # Desired absolute surge speed (x axis) [m/s]
float64 error_sway_speed    # Desired absolute sway speed (y axis)  [m/s]

#                #     SURGE SPEED    #     SWAY SPEED    #     YAW RATE     #    DEPTH RATE    #     PITCH RATE     #
# ------------------------------------------------------------------------------------------------------------------ #
#    MAX VALUES  #      0.25 m/s      #      0.25 m/s     #     10 deg/s     #    0.125 m/s     #      5.0 deg/s     #