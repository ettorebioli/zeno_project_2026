; Auto-generated. Do not edit!


(cl:in-package marta_msgs-msg)


;//! \htmlinclude MotionReference.msg.html

(cl:defclass <MotionReference> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (lla
    :reader lla
    :initarg :lla
    :type marta_msgs-msg:LatitudeLongitudeAltitude
    :initform (cl:make-instance 'marta_msgs-msg:LatitudeLongitudeAltitude))
   (lld
    :reader lld
    :initarg :lld
    :type marta_msgs-msg:LatitudeLongitudeDepth
    :initform (cl:make-instance 'marta_msgs-msg:LatitudeLongitudeDepth))
   (quaternion
    :reader quaternion
    :initarg :quaternion
    :type marta_msgs-msg:Quaternion
    :initform (cl:make-instance 'marta_msgs-msg:Quaternion))
   (rpy
    :reader rpy
    :initarg :rpy
    :type marta_msgs-msg:RollPitchYaw
    :initform (cl:make-instance 'marta_msgs-msg:RollPitchYaw))
   (rpy_dot
    :reader rpy_dot
    :initarg :rpy_dot
    :type marta_msgs-msg:RollPitchYaw
    :initform (cl:make-instance 'marta_msgs-msg:RollPitchYaw))
   (rpy_dot_dot
    :reader rpy_dot_dot
    :initarg :rpy_dot_dot
    :type marta_msgs-msg:RollPitchYaw
    :initform (cl:make-instance 'marta_msgs-msg:RollPitchYaw))
   (pn_wrt_home
    :reader pn_wrt_home
    :initarg :pn_wrt_home
    :type marta_msgs-msg:NorthEastDown
    :initform (cl:make-instance 'marta_msgs-msg:NorthEastDown))
   (pn_dot
    :reader pn_dot
    :initarg :pn_dot
    :type marta_msgs-msg:NorthEastDown
    :initform (cl:make-instance 'marta_msgs-msg:NorthEastDown))
   (pn_dot_dot
    :reader pn_dot_dot
    :initarg :pn_dot_dot
    :type marta_msgs-msg:NorthEastDown
    :initform (cl:make-instance 'marta_msgs-msg:NorthEastDown))
   (vb
    :reader vb
    :initarg :vb
    :type marta_msgs-msg:SurgeSwayHeave
    :initform (cl:make-instance 'marta_msgs-msg:SurgeSwayHeave))
   (vb_dot
    :reader vb_dot
    :initarg :vb_dot
    :type marta_msgs-msg:SurgeSwayHeave
    :initform (cl:make-instance 'marta_msgs-msg:SurgeSwayHeave))
   (wb
    :reader wb
    :initarg :wb
    :type marta_msgs-msg:SurgeSwayHeave
    :initform (cl:make-instance 'marta_msgs-msg:SurgeSwayHeave))
   (wb_dot
    :reader wb_dot
    :initarg :wb_dot
    :type marta_msgs-msg:SurgeSwayHeave
    :initform (cl:make-instance 'marta_msgs-msg:SurgeSwayHeave))
   (depth_unconstrained
    :reader depth_unconstrained
    :initarg :depth_unconstrained
    :type cl:float
    :initform 0.0)
   (final_reference
    :reader final_reference
    :initarg :final_reference
    :type cl:boolean
    :initform cl:nil)
   (lla_final
    :reader lla_final
    :initarg :lla_final
    :type marta_msgs-msg:LatitudeLongitudeAltitude
    :initform (cl:make-instance 'marta_msgs-msg:LatitudeLongitudeAltitude))
   (rpy_final
    :reader rpy_final
    :initarg :rpy_final
    :type marta_msgs-msg:RollPitchYaw
    :initform (cl:make-instance 'marta_msgs-msg:RollPitchYaw)))
)

(cl:defclass MotionReference (<MotionReference>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MotionReference>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MotionReference)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name marta_msgs-msg:<MotionReference> is deprecated: use marta_msgs-msg:MotionReference instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <MotionReference>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:header-val is deprecated.  Use marta_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'lla-val :lambda-list '(m))
(cl:defmethod lla-val ((m <MotionReference>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:lla-val is deprecated.  Use marta_msgs-msg:lla instead.")
  (lla m))

(cl:ensure-generic-function 'lld-val :lambda-list '(m))
(cl:defmethod lld-val ((m <MotionReference>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:lld-val is deprecated.  Use marta_msgs-msg:lld instead.")
  (lld m))

(cl:ensure-generic-function 'quaternion-val :lambda-list '(m))
(cl:defmethod quaternion-val ((m <MotionReference>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:quaternion-val is deprecated.  Use marta_msgs-msg:quaternion instead.")
  (quaternion m))

(cl:ensure-generic-function 'rpy-val :lambda-list '(m))
(cl:defmethod rpy-val ((m <MotionReference>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:rpy-val is deprecated.  Use marta_msgs-msg:rpy instead.")
  (rpy m))

(cl:ensure-generic-function 'rpy_dot-val :lambda-list '(m))
(cl:defmethod rpy_dot-val ((m <MotionReference>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:rpy_dot-val is deprecated.  Use marta_msgs-msg:rpy_dot instead.")
  (rpy_dot m))

(cl:ensure-generic-function 'rpy_dot_dot-val :lambda-list '(m))
(cl:defmethod rpy_dot_dot-val ((m <MotionReference>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:rpy_dot_dot-val is deprecated.  Use marta_msgs-msg:rpy_dot_dot instead.")
  (rpy_dot_dot m))

(cl:ensure-generic-function 'pn_wrt_home-val :lambda-list '(m))
(cl:defmethod pn_wrt_home-val ((m <MotionReference>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:pn_wrt_home-val is deprecated.  Use marta_msgs-msg:pn_wrt_home instead.")
  (pn_wrt_home m))

(cl:ensure-generic-function 'pn_dot-val :lambda-list '(m))
(cl:defmethod pn_dot-val ((m <MotionReference>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:pn_dot-val is deprecated.  Use marta_msgs-msg:pn_dot instead.")
  (pn_dot m))

(cl:ensure-generic-function 'pn_dot_dot-val :lambda-list '(m))
(cl:defmethod pn_dot_dot-val ((m <MotionReference>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:pn_dot_dot-val is deprecated.  Use marta_msgs-msg:pn_dot_dot instead.")
  (pn_dot_dot m))

(cl:ensure-generic-function 'vb-val :lambda-list '(m))
(cl:defmethod vb-val ((m <MotionReference>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:vb-val is deprecated.  Use marta_msgs-msg:vb instead.")
  (vb m))

(cl:ensure-generic-function 'vb_dot-val :lambda-list '(m))
(cl:defmethod vb_dot-val ((m <MotionReference>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:vb_dot-val is deprecated.  Use marta_msgs-msg:vb_dot instead.")
  (vb_dot m))

(cl:ensure-generic-function 'wb-val :lambda-list '(m))
(cl:defmethod wb-val ((m <MotionReference>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:wb-val is deprecated.  Use marta_msgs-msg:wb instead.")
  (wb m))

(cl:ensure-generic-function 'wb_dot-val :lambda-list '(m))
(cl:defmethod wb_dot-val ((m <MotionReference>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:wb_dot-val is deprecated.  Use marta_msgs-msg:wb_dot instead.")
  (wb_dot m))

(cl:ensure-generic-function 'depth_unconstrained-val :lambda-list '(m))
(cl:defmethod depth_unconstrained-val ((m <MotionReference>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:depth_unconstrained-val is deprecated.  Use marta_msgs-msg:depth_unconstrained instead.")
  (depth_unconstrained m))

(cl:ensure-generic-function 'final_reference-val :lambda-list '(m))
(cl:defmethod final_reference-val ((m <MotionReference>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:final_reference-val is deprecated.  Use marta_msgs-msg:final_reference instead.")
  (final_reference m))

(cl:ensure-generic-function 'lla_final-val :lambda-list '(m))
(cl:defmethod lla_final-val ((m <MotionReference>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:lla_final-val is deprecated.  Use marta_msgs-msg:lla_final instead.")
  (lla_final m))

(cl:ensure-generic-function 'rpy_final-val :lambda-list '(m))
(cl:defmethod rpy_final-val ((m <MotionReference>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:rpy_final-val is deprecated.  Use marta_msgs-msg:rpy_final instead.")
  (rpy_final m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MotionReference>) ostream)
  "Serializes a message object of type '<MotionReference>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'lla) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'lld) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'quaternion) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'rpy) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'rpy_dot) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'rpy_dot_dot) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pn_wrt_home) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pn_dot) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pn_dot_dot) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'vb) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'vb_dot) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'wb) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'wb_dot) ostream)
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'depth_unconstrained))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'final_reference) 1 0)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'lla_final) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'rpy_final) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MotionReference>) istream)
  "Deserializes a message object of type '<MotionReference>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'lla) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'lld) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'quaternion) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'rpy) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'rpy_dot) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'rpy_dot_dot) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pn_wrt_home) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pn_dot) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pn_dot_dot) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'vb) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'vb_dot) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'wb) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'wb_dot) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'depth_unconstrained) (roslisp-utils:decode-double-float-bits bits)))
    (cl:setf (cl:slot-value msg 'final_reference) (cl:not (cl:zerop (cl:read-byte istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'lla_final) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'rpy_final) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MotionReference>)))
  "Returns string type for a message object of type '<MotionReference>"
  "marta_msgs/MotionReference")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MotionReference)))
  "Returns string type for a message object of type 'MotionReference"
  "marta_msgs/MotionReference")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MotionReference>)))
  "Returns md5sum for a message object of type '<MotionReference>"
  "f6865ee91600578e5e1d5b6edf162a80")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MotionReference)))
  "Returns md5sum for a message object of type 'MotionReference"
  "f6865ee91600578e5e1d5b6edf162a80")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MotionReference>)))
  "Returns full string definition for message of type '<MotionReference>"
  (cl:format cl:nil "Header header~%~%LatitudeLongitudeAltitude lla~%~%LatitudeLongitudeDepth lld~%~%Quaternion quaternion~%~%RollPitchYaw rpy~%~%RollPitchYaw rpy_dot~%~%RollPitchYaw rpy_dot_dot~%~%NorthEastDown pn_wrt_home~%~%NorthEastDown pn_dot~%~%NorthEastDown pn_dot_dot~%~%SurgeSwayHeave vb~%~%SurgeSwayHeave vb_dot~%~%SurgeSwayHeave wb~%~%SurgeSwayHeave wb_dot~%~%float64 depth_unconstrained~%	~%bool final_reference~%~%LatitudeLongitudeAltitude lla_final~%~%RollPitchYaw rpy_final~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: marta_msgs/LatitudeLongitudeAltitude~%float64 latitude~%float64 longitude~%float64 altitude~%~%================================================================================~%MSG: marta_msgs/LatitudeLongitudeDepth~%float64 latitude~%float64 longitude~%float64 depth~%~%================================================================================~%MSG: marta_msgs/Quaternion~%float64 w~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: marta_msgs/RollPitchYaw~%float64 roll~%float64 pitch~%float64 yaw~%~%================================================================================~%MSG: marta_msgs/NorthEastDown~%float64 north~%float64 east~%float64 down~%~%================================================================================~%MSG: marta_msgs/SurgeSwayHeave~%float64 surge~%float64 sway~%float64 heave~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MotionReference)))
  "Returns full string definition for message of type 'MotionReference"
  (cl:format cl:nil "Header header~%~%LatitudeLongitudeAltitude lla~%~%LatitudeLongitudeDepth lld~%~%Quaternion quaternion~%~%RollPitchYaw rpy~%~%RollPitchYaw rpy_dot~%~%RollPitchYaw rpy_dot_dot~%~%NorthEastDown pn_wrt_home~%~%NorthEastDown pn_dot~%~%NorthEastDown pn_dot_dot~%~%SurgeSwayHeave vb~%~%SurgeSwayHeave vb_dot~%~%SurgeSwayHeave wb~%~%SurgeSwayHeave wb_dot~%~%float64 depth_unconstrained~%	~%bool final_reference~%~%LatitudeLongitudeAltitude lla_final~%~%RollPitchYaw rpy_final~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: marta_msgs/LatitudeLongitudeAltitude~%float64 latitude~%float64 longitude~%float64 altitude~%~%================================================================================~%MSG: marta_msgs/LatitudeLongitudeDepth~%float64 latitude~%float64 longitude~%float64 depth~%~%================================================================================~%MSG: marta_msgs/Quaternion~%float64 w~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: marta_msgs/RollPitchYaw~%float64 roll~%float64 pitch~%float64 yaw~%~%================================================================================~%MSG: marta_msgs/NorthEastDown~%float64 north~%float64 east~%float64 down~%~%================================================================================~%MSG: marta_msgs/SurgeSwayHeave~%float64 surge~%float64 sway~%float64 heave~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MotionReference>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'lla))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'lld))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'quaternion))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'rpy))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'rpy_dot))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'rpy_dot_dot))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pn_wrt_home))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pn_dot))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pn_dot_dot))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'vb))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'vb_dot))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'wb))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'wb_dot))
     8
     1
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'lla_final))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'rpy_final))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MotionReference>))
  "Converts a ROS message object to a list"
  (cl:list 'MotionReference
    (cl:cons ':header (header msg))
    (cl:cons ':lla (lla msg))
    (cl:cons ':lld (lld msg))
    (cl:cons ':quaternion (quaternion msg))
    (cl:cons ':rpy (rpy msg))
    (cl:cons ':rpy_dot (rpy_dot msg))
    (cl:cons ':rpy_dot_dot (rpy_dot_dot msg))
    (cl:cons ':pn_wrt_home (pn_wrt_home msg))
    (cl:cons ':pn_dot (pn_dot msg))
    (cl:cons ':pn_dot_dot (pn_dot_dot msg))
    (cl:cons ':vb (vb msg))
    (cl:cons ':vb_dot (vb_dot msg))
    (cl:cons ':wb (wb msg))
    (cl:cons ':wb_dot (wb_dot msg))
    (cl:cons ':depth_unconstrained (depth_unconstrained msg))
    (cl:cons ':final_reference (final_reference msg))
    (cl:cons ':lla_final (lla_final msg))
    (cl:cons ':rpy_final (rpy_final msg))
))
