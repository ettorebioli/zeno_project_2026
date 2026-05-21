;; Auto-generated. Do not edit!


(when (boundp 'joystick_command::Rel_error_joystick)
  (if (not (find-package "JOYSTICK_COMMAND"))
    (make-package "JOYSTICK_COMMAND"))
  (shadow 'Rel_error_joystick (find-package "JOYSTICK_COMMAND")))
(unless (find-package "JOYSTICK_COMMAND::REL_ERROR_JOYSTICK")
  (make-package "JOYSTICK_COMMAND::REL_ERROR_JOYSTICK"))

(in-package "ROS")
;;//! \htmlinclude Rel_error_joystick.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass joystick_command::Rel_error_joystick
  :super ros::object
  :slots (_header _error_roll _error_pitch _error_yaw _error_distance _error_depth _error_surge_speed _error_sway_speed ))

(defmethod joystick_command::Rel_error_joystick
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:error_roll __error_roll) 0.0)
    ((:error_pitch __error_pitch) 0.0)
    ((:error_yaw __error_yaw) 0.0)
    ((:error_distance __error_distance) 0.0)
    ((:error_depth __error_depth) 0.0)
    ((:error_surge_speed __error_surge_speed) 0.0)
    ((:error_sway_speed __error_sway_speed) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _error_roll (float __error_roll))
   (setq _error_pitch (float __error_pitch))
   (setq _error_yaw (float __error_yaw))
   (setq _error_distance (float __error_distance))
   (setq _error_depth (float __error_depth))
   (setq _error_surge_speed (float __error_surge_speed))
   (setq _error_sway_speed (float __error_sway_speed))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:error_roll
   (&optional __error_roll)
   (if __error_roll (setq _error_roll __error_roll)) _error_roll)
  (:error_pitch
   (&optional __error_pitch)
   (if __error_pitch (setq _error_pitch __error_pitch)) _error_pitch)
  (:error_yaw
   (&optional __error_yaw)
   (if __error_yaw (setq _error_yaw __error_yaw)) _error_yaw)
  (:error_distance
   (&optional __error_distance)
   (if __error_distance (setq _error_distance __error_distance)) _error_distance)
  (:error_depth
   (&optional __error_depth)
   (if __error_depth (setq _error_depth __error_depth)) _error_depth)
  (:error_surge_speed
   (&optional __error_surge_speed)
   (if __error_surge_speed (setq _error_surge_speed __error_surge_speed)) _error_surge_speed)
  (:error_sway_speed
   (&optional __error_sway_speed)
   (if __error_sway_speed (setq _error_sway_speed __error_sway_speed)) _error_sway_speed)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float64 _error_roll
    8
    ;; float64 _error_pitch
    8
    ;; float64 _error_yaw
    8
    ;; float64 _error_distance
    8
    ;; float64 _error_depth
    8
    ;; float64 _error_surge_speed
    8
    ;; float64 _error_sway_speed
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float64 _error_roll
       (sys::poke _error_roll (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _error_pitch
       (sys::poke _error_pitch (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _error_yaw
       (sys::poke _error_yaw (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _error_distance
       (sys::poke _error_distance (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _error_depth
       (sys::poke _error_depth (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _error_surge_speed
       (sys::poke _error_surge_speed (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _error_sway_speed
       (sys::poke _error_sway_speed (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float64 _error_roll
     (setq _error_roll (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _error_pitch
     (setq _error_pitch (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _error_yaw
     (setq _error_yaw (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _error_distance
     (setq _error_distance (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _error_depth
     (setq _error_depth (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _error_surge_speed
     (setq _error_surge_speed (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _error_sway_speed
     (setq _error_sway_speed (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get joystick_command::Rel_error_joystick :md5sum-) "eb21a06c4e8dda99b50b5307a898900c")
(setf (get joystick_command::Rel_error_joystick :datatype-) "joystick_command/Rel_error_joystick")
(setf (get joystick_command::Rel_error_joystick :definition-)
      "Header header

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
================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

")



(provide :joystick_command/Rel_error_joystick "eb21a06c4e8dda99b50b5307a898900c")


