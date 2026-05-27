; Auto-generated. Do not edit!


(cl:in-package marta_msgs-msg)


;//! \htmlinclude NavStatus.msg.html

(cl:defclass <NavStatus> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (position
    :reader position
    :initarg :position
    :type marta_msgs-msg:Position
    :initform (cl:make-instance 'marta_msgs-msg:Position))
   (orientation
    :reader orientation
    :initarg :orientation
    :type marta_msgs-msg:Euler
    :initform (cl:make-instance 'marta_msgs-msg:Euler))
   (quaternion
    :reader quaternion
    :initarg :quaternion
    :type marta_msgs-msg:Quaternion
    :initform (cl:make-instance 'marta_msgs-msg:Quaternion))
   (ned_speed
    :reader ned_speed
    :initarg :ned_speed
    :type geometry_msgs-msg:Vector3
    :initform (cl:make-instance 'geometry_msgs-msg:Vector3))
   (omega_body
    :reader omega_body
    :initarg :omega_body
    :type geometry_msgs-msg:Vector3
    :initform (cl:make-instance 'geometry_msgs-msg:Vector3))
   (gps_status
    :reader gps_status
    :initarg :gps_status
    :type cl:fixnum
    :initform 0)
   (initialized
    :reader initialized
    :initarg :initialized
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass NavStatus (<NavStatus>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <NavStatus>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'NavStatus)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name marta_msgs-msg:<NavStatus> is deprecated: use marta_msgs-msg:NavStatus instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <NavStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:header-val is deprecated.  Use marta_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'position-val :lambda-list '(m))
(cl:defmethod position-val ((m <NavStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:position-val is deprecated.  Use marta_msgs-msg:position instead.")
  (position m))

(cl:ensure-generic-function 'orientation-val :lambda-list '(m))
(cl:defmethod orientation-val ((m <NavStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:orientation-val is deprecated.  Use marta_msgs-msg:orientation instead.")
  (orientation m))

(cl:ensure-generic-function 'quaternion-val :lambda-list '(m))
(cl:defmethod quaternion-val ((m <NavStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:quaternion-val is deprecated.  Use marta_msgs-msg:quaternion instead.")
  (quaternion m))

(cl:ensure-generic-function 'ned_speed-val :lambda-list '(m))
(cl:defmethod ned_speed-val ((m <NavStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:ned_speed-val is deprecated.  Use marta_msgs-msg:ned_speed instead.")
  (ned_speed m))

(cl:ensure-generic-function 'omega_body-val :lambda-list '(m))
(cl:defmethod omega_body-val ((m <NavStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:omega_body-val is deprecated.  Use marta_msgs-msg:omega_body instead.")
  (omega_body m))

(cl:ensure-generic-function 'gps_status-val :lambda-list '(m))
(cl:defmethod gps_status-val ((m <NavStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:gps_status-val is deprecated.  Use marta_msgs-msg:gps_status instead.")
  (gps_status m))

(cl:ensure-generic-function 'initialized-val :lambda-list '(m))
(cl:defmethod initialized-val ((m <NavStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:initialized-val is deprecated.  Use marta_msgs-msg:initialized instead.")
  (initialized m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <NavStatus>) ostream)
  "Serializes a message object of type '<NavStatus>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'position) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'orientation) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'quaternion) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'ned_speed) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'omega_body) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'gps_status)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'initialized) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <NavStatus>) istream)
  "Deserializes a message object of type '<NavStatus>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'position) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'orientation) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'quaternion) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'ned_speed) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'omega_body) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'gps_status)) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'initialized) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<NavStatus>)))
  "Returns string type for a message object of type '<NavStatus>"
  "marta_msgs/NavStatus")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'NavStatus)))
  "Returns string type for a message object of type 'NavStatus"
  "marta_msgs/NavStatus")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<NavStatus>)))
  "Returns md5sum for a message object of type '<NavStatus>"
  "2652576ed189854bff45893603a05bc0")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'NavStatus)))
  "Returns md5sum for a message object of type 'NavStatus"
  "2652576ed189854bff45893603a05bc0")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<NavStatus>)))
  "Returns full string definition for message of type '<NavStatus>"
  (cl:format cl:nil "Header header~%~%marta_msgs/Position position~% ~%marta_msgs/Euler orientation~%~%marta_msgs/Quaternion quaternion~%~%geometry_msgs/Vector3 ned_speed~%~%geometry_msgs/Vector3 omega_body~%~%uint8 gps_status~%~%bool initialized~%~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: marta_msgs/Position~%float64 latitude~%float64 longitude~%float64 depth~%~%================================================================================~%MSG: marta_msgs/Euler~%float64 roll~%float64 pitch~%float64 yaw~%~%================================================================================~%MSG: marta_msgs/Quaternion~%float64 w~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'NavStatus)))
  "Returns full string definition for message of type 'NavStatus"
  (cl:format cl:nil "Header header~%~%marta_msgs/Position position~% ~%marta_msgs/Euler orientation~%~%marta_msgs/Quaternion quaternion~%~%geometry_msgs/Vector3 ned_speed~%~%geometry_msgs/Vector3 omega_body~%~%uint8 gps_status~%~%bool initialized~%~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: marta_msgs/Position~%float64 latitude~%float64 longitude~%float64 depth~%~%================================================================================~%MSG: marta_msgs/Euler~%float64 roll~%float64 pitch~%float64 yaw~%~%================================================================================~%MSG: marta_msgs/Quaternion~%float64 w~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <NavStatus>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'position))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'orientation))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'quaternion))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'ned_speed))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'omega_body))
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <NavStatus>))
  "Converts a ROS message object to a list"
  (cl:list 'NavStatus
    (cl:cons ':header (header msg))
    (cl:cons ':position (position msg))
    (cl:cons ':orientation (orientation msg))
    (cl:cons ':quaternion (quaternion msg))
    (cl:cons ':ned_speed (ned_speed msg))
    (cl:cons ':omega_body (omega_body msg))
    (cl:cons ':gps_status (gps_status msg))
    (cl:cons ':initialized (initialized msg))
))
