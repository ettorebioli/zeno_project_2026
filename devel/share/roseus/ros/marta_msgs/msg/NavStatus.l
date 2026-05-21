;; Auto-generated. Do not edit!


(when (boundp 'marta_msgs::NavStatus)
  (if (not (find-package "MARTA_MSGS"))
    (make-package "MARTA_MSGS"))
  (shadow 'NavStatus (find-package "MARTA_MSGS")))
(unless (find-package "MARTA_MSGS::NAVSTATUS")
  (make-package "MARTA_MSGS::NAVSTATUS"))

(in-package "ROS")
;;//! \htmlinclude NavStatus.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass marta_msgs::NavStatus
  :super ros::object
  :slots (_header _position _orientation _quaternion _ned_speed _omega_body _gps_status _initialized ))

(defmethod marta_msgs::NavStatus
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:position __position) (instance marta_msgs::Position :init))
    ((:orientation __orientation) (instance marta_msgs::Euler :init))
    ((:quaternion __quaternion) (instance marta_msgs::Quaternion :init))
    ((:ned_speed __ned_speed) (instance geometry_msgs::Vector3 :init))
    ((:omega_body __omega_body) (instance geometry_msgs::Vector3 :init))
    ((:gps_status __gps_status) 0)
    ((:initialized __initialized) nil)
    )
   (send-super :init)
   (setq _header __header)
   (setq _position __position)
   (setq _orientation __orientation)
   (setq _quaternion __quaternion)
   (setq _ned_speed __ned_speed)
   (setq _omega_body __omega_body)
   (setq _gps_status (round __gps_status))
   (setq _initialized __initialized)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:position
   (&rest __position)
   (if (keywordp (car __position))
       (send* _position __position)
     (progn
       (if __position (setq _position (car __position)))
       _position)))
  (:orientation
   (&rest __orientation)
   (if (keywordp (car __orientation))
       (send* _orientation __orientation)
     (progn
       (if __orientation (setq _orientation (car __orientation)))
       _orientation)))
  (:quaternion
   (&rest __quaternion)
   (if (keywordp (car __quaternion))
       (send* _quaternion __quaternion)
     (progn
       (if __quaternion (setq _quaternion (car __quaternion)))
       _quaternion)))
  (:ned_speed
   (&rest __ned_speed)
   (if (keywordp (car __ned_speed))
       (send* _ned_speed __ned_speed)
     (progn
       (if __ned_speed (setq _ned_speed (car __ned_speed)))
       _ned_speed)))
  (:omega_body
   (&rest __omega_body)
   (if (keywordp (car __omega_body))
       (send* _omega_body __omega_body)
     (progn
       (if __omega_body (setq _omega_body (car __omega_body)))
       _omega_body)))
  (:gps_status
   (&optional __gps_status)
   (if __gps_status (setq _gps_status __gps_status)) _gps_status)
  (:initialized
   (&optional __initialized)
   (if __initialized (setq _initialized __initialized)) _initialized)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; marta_msgs/Position _position
    (send _position :serialization-length)
    ;; marta_msgs/Euler _orientation
    (send _orientation :serialization-length)
    ;; marta_msgs/Quaternion _quaternion
    (send _quaternion :serialization-length)
    ;; geometry_msgs/Vector3 _ned_speed
    (send _ned_speed :serialization-length)
    ;; geometry_msgs/Vector3 _omega_body
    (send _omega_body :serialization-length)
    ;; uint8 _gps_status
    1
    ;; bool _initialized
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; marta_msgs/Position _position
       (send _position :serialize s)
     ;; marta_msgs/Euler _orientation
       (send _orientation :serialize s)
     ;; marta_msgs/Quaternion _quaternion
       (send _quaternion :serialize s)
     ;; geometry_msgs/Vector3 _ned_speed
       (send _ned_speed :serialize s)
     ;; geometry_msgs/Vector3 _omega_body
       (send _omega_body :serialize s)
     ;; uint8 _gps_status
       (write-byte _gps_status s)
     ;; bool _initialized
       (if _initialized (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; marta_msgs/Position _position
     (send _position :deserialize buf ptr-) (incf ptr- (send _position :serialization-length))
   ;; marta_msgs/Euler _orientation
     (send _orientation :deserialize buf ptr-) (incf ptr- (send _orientation :serialization-length))
   ;; marta_msgs/Quaternion _quaternion
     (send _quaternion :deserialize buf ptr-) (incf ptr- (send _quaternion :serialization-length))
   ;; geometry_msgs/Vector3 _ned_speed
     (send _ned_speed :deserialize buf ptr-) (incf ptr- (send _ned_speed :serialization-length))
   ;; geometry_msgs/Vector3 _omega_body
     (send _omega_body :deserialize buf ptr-) (incf ptr- (send _omega_body :serialization-length))
   ;; uint8 _gps_status
     (setq _gps_status (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; bool _initialized
     (setq _initialized (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get marta_msgs::NavStatus :md5sum-) "2652576ed189854bff45893603a05bc0")
(setf (get marta_msgs::NavStatus :datatype-) "marta_msgs/NavStatus")
(setf (get marta_msgs::NavStatus :definition-)
      "Header header

marta_msgs/Position position
 
marta_msgs/Euler orientation

marta_msgs/Quaternion quaternion

geometry_msgs/Vector3 ned_speed

geometry_msgs/Vector3 omega_body

uint8 gps_status

bool initialized


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

================================================================================
MSG: marta_msgs/Position
float64 latitude
float64 longitude
float64 depth

================================================================================
MSG: marta_msgs/Euler
float64 roll
float64 pitch
float64 yaw

================================================================================
MSG: marta_msgs/Quaternion
float64 w
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Vector3
# This represents a vector in free space. 
# It is only meant to represent a direction. Therefore, it does not
# make sense to apply a translation to it (e.g., when applying a 
# generic rigid transformation to a Vector3, tf2 will only apply the
# rotation). If you want your data to be translatable too, use the
# geometry_msgs/Point message instead.

float64 x
float64 y
float64 z
")



(provide :marta_msgs/NavStatus "2652576ed189854bff45893603a05bc0")


