;; Auto-generated. Do not edit!


(when (boundp 'marta_msgs::MotionReference)
  (if (not (find-package "MARTA_MSGS"))
    (make-package "MARTA_MSGS"))
  (shadow 'MotionReference (find-package "MARTA_MSGS")))
(unless (find-package "MARTA_MSGS::MOTIONREFERENCE")
  (make-package "MARTA_MSGS::MOTIONREFERENCE"))

(in-package "ROS")
;;//! \htmlinclude MotionReference.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass marta_msgs::MotionReference
  :super ros::object
  :slots (_header _lla _lld _quaternion _rpy _rpy_dot _rpy_dot_dot _pn_wrt_home _pn_dot _pn_dot_dot _vb _vb_dot _wb _wb_dot _depth_unconstrained _final_reference _lla_final _rpy_final ))

(defmethod marta_msgs::MotionReference
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:lla __lla) (instance marta_msgs::LatitudeLongitudeAltitude :init))
    ((:lld __lld) (instance marta_msgs::LatitudeLongitudeDepth :init))
    ((:quaternion __quaternion) (instance marta_msgs::Quaternion :init))
    ((:rpy __rpy) (instance marta_msgs::RollPitchYaw :init))
    ((:rpy_dot __rpy_dot) (instance marta_msgs::RollPitchYaw :init))
    ((:rpy_dot_dot __rpy_dot_dot) (instance marta_msgs::RollPitchYaw :init))
    ((:pn_wrt_home __pn_wrt_home) (instance marta_msgs::NorthEastDown :init))
    ((:pn_dot __pn_dot) (instance marta_msgs::NorthEastDown :init))
    ((:pn_dot_dot __pn_dot_dot) (instance marta_msgs::NorthEastDown :init))
    ((:vb __vb) (instance marta_msgs::SurgeSwayHeave :init))
    ((:vb_dot __vb_dot) (instance marta_msgs::SurgeSwayHeave :init))
    ((:wb __wb) (instance marta_msgs::SurgeSwayHeave :init))
    ((:wb_dot __wb_dot) (instance marta_msgs::SurgeSwayHeave :init))
    ((:depth_unconstrained __depth_unconstrained) 0.0)
    ((:final_reference __final_reference) nil)
    ((:lla_final __lla_final) (instance marta_msgs::LatitudeLongitudeAltitude :init))
    ((:rpy_final __rpy_final) (instance marta_msgs::RollPitchYaw :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _lla __lla)
   (setq _lld __lld)
   (setq _quaternion __quaternion)
   (setq _rpy __rpy)
   (setq _rpy_dot __rpy_dot)
   (setq _rpy_dot_dot __rpy_dot_dot)
   (setq _pn_wrt_home __pn_wrt_home)
   (setq _pn_dot __pn_dot)
   (setq _pn_dot_dot __pn_dot_dot)
   (setq _vb __vb)
   (setq _vb_dot __vb_dot)
   (setq _wb __wb)
   (setq _wb_dot __wb_dot)
   (setq _depth_unconstrained (float __depth_unconstrained))
   (setq _final_reference __final_reference)
   (setq _lla_final __lla_final)
   (setq _rpy_final __rpy_final)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:lla
   (&rest __lla)
   (if (keywordp (car __lla))
       (send* _lla __lla)
     (progn
       (if __lla (setq _lla (car __lla)))
       _lla)))
  (:lld
   (&rest __lld)
   (if (keywordp (car __lld))
       (send* _lld __lld)
     (progn
       (if __lld (setq _lld (car __lld)))
       _lld)))
  (:quaternion
   (&rest __quaternion)
   (if (keywordp (car __quaternion))
       (send* _quaternion __quaternion)
     (progn
       (if __quaternion (setq _quaternion (car __quaternion)))
       _quaternion)))
  (:rpy
   (&rest __rpy)
   (if (keywordp (car __rpy))
       (send* _rpy __rpy)
     (progn
       (if __rpy (setq _rpy (car __rpy)))
       _rpy)))
  (:rpy_dot
   (&rest __rpy_dot)
   (if (keywordp (car __rpy_dot))
       (send* _rpy_dot __rpy_dot)
     (progn
       (if __rpy_dot (setq _rpy_dot (car __rpy_dot)))
       _rpy_dot)))
  (:rpy_dot_dot
   (&rest __rpy_dot_dot)
   (if (keywordp (car __rpy_dot_dot))
       (send* _rpy_dot_dot __rpy_dot_dot)
     (progn
       (if __rpy_dot_dot (setq _rpy_dot_dot (car __rpy_dot_dot)))
       _rpy_dot_dot)))
  (:pn_wrt_home
   (&rest __pn_wrt_home)
   (if (keywordp (car __pn_wrt_home))
       (send* _pn_wrt_home __pn_wrt_home)
     (progn
       (if __pn_wrt_home (setq _pn_wrt_home (car __pn_wrt_home)))
       _pn_wrt_home)))
  (:pn_dot
   (&rest __pn_dot)
   (if (keywordp (car __pn_dot))
       (send* _pn_dot __pn_dot)
     (progn
       (if __pn_dot (setq _pn_dot (car __pn_dot)))
       _pn_dot)))
  (:pn_dot_dot
   (&rest __pn_dot_dot)
   (if (keywordp (car __pn_dot_dot))
       (send* _pn_dot_dot __pn_dot_dot)
     (progn
       (if __pn_dot_dot (setq _pn_dot_dot (car __pn_dot_dot)))
       _pn_dot_dot)))
  (:vb
   (&rest __vb)
   (if (keywordp (car __vb))
       (send* _vb __vb)
     (progn
       (if __vb (setq _vb (car __vb)))
       _vb)))
  (:vb_dot
   (&rest __vb_dot)
   (if (keywordp (car __vb_dot))
       (send* _vb_dot __vb_dot)
     (progn
       (if __vb_dot (setq _vb_dot (car __vb_dot)))
       _vb_dot)))
  (:wb
   (&rest __wb)
   (if (keywordp (car __wb))
       (send* _wb __wb)
     (progn
       (if __wb (setq _wb (car __wb)))
       _wb)))
  (:wb_dot
   (&rest __wb_dot)
   (if (keywordp (car __wb_dot))
       (send* _wb_dot __wb_dot)
     (progn
       (if __wb_dot (setq _wb_dot (car __wb_dot)))
       _wb_dot)))
  (:depth_unconstrained
   (&optional __depth_unconstrained)
   (if __depth_unconstrained (setq _depth_unconstrained __depth_unconstrained)) _depth_unconstrained)
  (:final_reference
   (&optional __final_reference)
   (if __final_reference (setq _final_reference __final_reference)) _final_reference)
  (:lla_final
   (&rest __lla_final)
   (if (keywordp (car __lla_final))
       (send* _lla_final __lla_final)
     (progn
       (if __lla_final (setq _lla_final (car __lla_final)))
       _lla_final)))
  (:rpy_final
   (&rest __rpy_final)
   (if (keywordp (car __rpy_final))
       (send* _rpy_final __rpy_final)
     (progn
       (if __rpy_final (setq _rpy_final (car __rpy_final)))
       _rpy_final)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; marta_msgs/LatitudeLongitudeAltitude _lla
    (send _lla :serialization-length)
    ;; marta_msgs/LatitudeLongitudeDepth _lld
    (send _lld :serialization-length)
    ;; marta_msgs/Quaternion _quaternion
    (send _quaternion :serialization-length)
    ;; marta_msgs/RollPitchYaw _rpy
    (send _rpy :serialization-length)
    ;; marta_msgs/RollPitchYaw _rpy_dot
    (send _rpy_dot :serialization-length)
    ;; marta_msgs/RollPitchYaw _rpy_dot_dot
    (send _rpy_dot_dot :serialization-length)
    ;; marta_msgs/NorthEastDown _pn_wrt_home
    (send _pn_wrt_home :serialization-length)
    ;; marta_msgs/NorthEastDown _pn_dot
    (send _pn_dot :serialization-length)
    ;; marta_msgs/NorthEastDown _pn_dot_dot
    (send _pn_dot_dot :serialization-length)
    ;; marta_msgs/SurgeSwayHeave _vb
    (send _vb :serialization-length)
    ;; marta_msgs/SurgeSwayHeave _vb_dot
    (send _vb_dot :serialization-length)
    ;; marta_msgs/SurgeSwayHeave _wb
    (send _wb :serialization-length)
    ;; marta_msgs/SurgeSwayHeave _wb_dot
    (send _wb_dot :serialization-length)
    ;; float64 _depth_unconstrained
    8
    ;; bool _final_reference
    1
    ;; marta_msgs/LatitudeLongitudeAltitude _lla_final
    (send _lla_final :serialization-length)
    ;; marta_msgs/RollPitchYaw _rpy_final
    (send _rpy_final :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; marta_msgs/LatitudeLongitudeAltitude _lla
       (send _lla :serialize s)
     ;; marta_msgs/LatitudeLongitudeDepth _lld
       (send _lld :serialize s)
     ;; marta_msgs/Quaternion _quaternion
       (send _quaternion :serialize s)
     ;; marta_msgs/RollPitchYaw _rpy
       (send _rpy :serialize s)
     ;; marta_msgs/RollPitchYaw _rpy_dot
       (send _rpy_dot :serialize s)
     ;; marta_msgs/RollPitchYaw _rpy_dot_dot
       (send _rpy_dot_dot :serialize s)
     ;; marta_msgs/NorthEastDown _pn_wrt_home
       (send _pn_wrt_home :serialize s)
     ;; marta_msgs/NorthEastDown _pn_dot
       (send _pn_dot :serialize s)
     ;; marta_msgs/NorthEastDown _pn_dot_dot
       (send _pn_dot_dot :serialize s)
     ;; marta_msgs/SurgeSwayHeave _vb
       (send _vb :serialize s)
     ;; marta_msgs/SurgeSwayHeave _vb_dot
       (send _vb_dot :serialize s)
     ;; marta_msgs/SurgeSwayHeave _wb
       (send _wb :serialize s)
     ;; marta_msgs/SurgeSwayHeave _wb_dot
       (send _wb_dot :serialize s)
     ;; float64 _depth_unconstrained
       (sys::poke _depth_unconstrained (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; bool _final_reference
       (if _final_reference (write-byte -1 s) (write-byte 0 s))
     ;; marta_msgs/LatitudeLongitudeAltitude _lla_final
       (send _lla_final :serialize s)
     ;; marta_msgs/RollPitchYaw _rpy_final
       (send _rpy_final :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; marta_msgs/LatitudeLongitudeAltitude _lla
     (send _lla :deserialize buf ptr-) (incf ptr- (send _lla :serialization-length))
   ;; marta_msgs/LatitudeLongitudeDepth _lld
     (send _lld :deserialize buf ptr-) (incf ptr- (send _lld :serialization-length))
   ;; marta_msgs/Quaternion _quaternion
     (send _quaternion :deserialize buf ptr-) (incf ptr- (send _quaternion :serialization-length))
   ;; marta_msgs/RollPitchYaw _rpy
     (send _rpy :deserialize buf ptr-) (incf ptr- (send _rpy :serialization-length))
   ;; marta_msgs/RollPitchYaw _rpy_dot
     (send _rpy_dot :deserialize buf ptr-) (incf ptr- (send _rpy_dot :serialization-length))
   ;; marta_msgs/RollPitchYaw _rpy_dot_dot
     (send _rpy_dot_dot :deserialize buf ptr-) (incf ptr- (send _rpy_dot_dot :serialization-length))
   ;; marta_msgs/NorthEastDown _pn_wrt_home
     (send _pn_wrt_home :deserialize buf ptr-) (incf ptr- (send _pn_wrt_home :serialization-length))
   ;; marta_msgs/NorthEastDown _pn_dot
     (send _pn_dot :deserialize buf ptr-) (incf ptr- (send _pn_dot :serialization-length))
   ;; marta_msgs/NorthEastDown _pn_dot_dot
     (send _pn_dot_dot :deserialize buf ptr-) (incf ptr- (send _pn_dot_dot :serialization-length))
   ;; marta_msgs/SurgeSwayHeave _vb
     (send _vb :deserialize buf ptr-) (incf ptr- (send _vb :serialization-length))
   ;; marta_msgs/SurgeSwayHeave _vb_dot
     (send _vb_dot :deserialize buf ptr-) (incf ptr- (send _vb_dot :serialization-length))
   ;; marta_msgs/SurgeSwayHeave _wb
     (send _wb :deserialize buf ptr-) (incf ptr- (send _wb :serialization-length))
   ;; marta_msgs/SurgeSwayHeave _wb_dot
     (send _wb_dot :deserialize buf ptr-) (incf ptr- (send _wb_dot :serialization-length))
   ;; float64 _depth_unconstrained
     (setq _depth_unconstrained (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; bool _final_reference
     (setq _final_reference (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; marta_msgs/LatitudeLongitudeAltitude _lla_final
     (send _lla_final :deserialize buf ptr-) (incf ptr- (send _lla_final :serialization-length))
   ;; marta_msgs/RollPitchYaw _rpy_final
     (send _rpy_final :deserialize buf ptr-) (incf ptr- (send _rpy_final :serialization-length))
   ;;
   self)
  )

(setf (get marta_msgs::MotionReference :md5sum-) "f6865ee91600578e5e1d5b6edf162a80")
(setf (get marta_msgs::MotionReference :datatype-) "marta_msgs/MotionReference")
(setf (get marta_msgs::MotionReference :definition-)
      "Header header

LatitudeLongitudeAltitude lla

LatitudeLongitudeDepth lld

Quaternion quaternion

RollPitchYaw rpy

RollPitchYaw rpy_dot

RollPitchYaw rpy_dot_dot

NorthEastDown pn_wrt_home

NorthEastDown pn_dot

NorthEastDown pn_dot_dot

SurgeSwayHeave vb

SurgeSwayHeave vb_dot

SurgeSwayHeave wb

SurgeSwayHeave wb_dot

float64 depth_unconstrained
	
bool final_reference

LatitudeLongitudeAltitude lla_final

RollPitchYaw rpy_final
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
MSG: marta_msgs/LatitudeLongitudeAltitude
float64 latitude
float64 longitude
float64 altitude

================================================================================
MSG: marta_msgs/LatitudeLongitudeDepth
float64 latitude
float64 longitude
float64 depth

================================================================================
MSG: marta_msgs/Quaternion
float64 w
float64 x
float64 y
float64 z

================================================================================
MSG: marta_msgs/RollPitchYaw
float64 roll
float64 pitch
float64 yaw

================================================================================
MSG: marta_msgs/NorthEastDown
float64 north
float64 east
float64 down

================================================================================
MSG: marta_msgs/SurgeSwayHeave
float64 surge
float64 sway
float64 heave

")



(provide :marta_msgs/MotionReference "f6865ee91600578e5e1d5b6edf162a80")


