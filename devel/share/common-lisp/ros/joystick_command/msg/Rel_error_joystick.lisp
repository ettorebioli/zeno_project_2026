; Auto-generated. Do not edit!


(cl:in-package joystick_command-msg)


;//! \htmlinclude Rel_error_joystick.msg.html

(cl:defclass <Rel_error_joystick> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (error_roll
    :reader error_roll
    :initarg :error_roll
    :type cl:float
    :initform 0.0)
   (error_pitch
    :reader error_pitch
    :initarg :error_pitch
    :type cl:float
    :initform 0.0)
   (error_yaw
    :reader error_yaw
    :initarg :error_yaw
    :type cl:float
    :initform 0.0)
   (error_distance
    :reader error_distance
    :initarg :error_distance
    :type cl:float
    :initform 0.0)
   (error_depth
    :reader error_depth
    :initarg :error_depth
    :type cl:float
    :initform 0.0)
   (error_surge_speed
    :reader error_surge_speed
    :initarg :error_surge_speed
    :type cl:float
    :initform 0.0)
   (error_sway_speed
    :reader error_sway_speed
    :initarg :error_sway_speed
    :type cl:float
    :initform 0.0))
)

(cl:defclass Rel_error_joystick (<Rel_error_joystick>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Rel_error_joystick>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Rel_error_joystick)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name joystick_command-msg:<Rel_error_joystick> is deprecated: use joystick_command-msg:Rel_error_joystick instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <Rel_error_joystick>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader joystick_command-msg:header-val is deprecated.  Use joystick_command-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'error_roll-val :lambda-list '(m))
(cl:defmethod error_roll-val ((m <Rel_error_joystick>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader joystick_command-msg:error_roll-val is deprecated.  Use joystick_command-msg:error_roll instead.")
  (error_roll m))

(cl:ensure-generic-function 'error_pitch-val :lambda-list '(m))
(cl:defmethod error_pitch-val ((m <Rel_error_joystick>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader joystick_command-msg:error_pitch-val is deprecated.  Use joystick_command-msg:error_pitch instead.")
  (error_pitch m))

(cl:ensure-generic-function 'error_yaw-val :lambda-list '(m))
(cl:defmethod error_yaw-val ((m <Rel_error_joystick>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader joystick_command-msg:error_yaw-val is deprecated.  Use joystick_command-msg:error_yaw instead.")
  (error_yaw m))

(cl:ensure-generic-function 'error_distance-val :lambda-list '(m))
(cl:defmethod error_distance-val ((m <Rel_error_joystick>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader joystick_command-msg:error_distance-val is deprecated.  Use joystick_command-msg:error_distance instead.")
  (error_distance m))

(cl:ensure-generic-function 'error_depth-val :lambda-list '(m))
(cl:defmethod error_depth-val ((m <Rel_error_joystick>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader joystick_command-msg:error_depth-val is deprecated.  Use joystick_command-msg:error_depth instead.")
  (error_depth m))

(cl:ensure-generic-function 'error_surge_speed-val :lambda-list '(m))
(cl:defmethod error_surge_speed-val ((m <Rel_error_joystick>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader joystick_command-msg:error_surge_speed-val is deprecated.  Use joystick_command-msg:error_surge_speed instead.")
  (error_surge_speed m))

(cl:ensure-generic-function 'error_sway_speed-val :lambda-list '(m))
(cl:defmethod error_sway_speed-val ((m <Rel_error_joystick>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader joystick_command-msg:error_sway_speed-val is deprecated.  Use joystick_command-msg:error_sway_speed instead.")
  (error_sway_speed m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Rel_error_joystick>) ostream)
  "Serializes a message object of type '<Rel_error_joystick>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'error_roll))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'error_pitch))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'error_yaw))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'error_distance))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'error_depth))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'error_surge_speed))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'error_sway_speed))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Rel_error_joystick>) istream)
  "Deserializes a message object of type '<Rel_error_joystick>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'error_roll) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'error_pitch) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'error_yaw) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'error_distance) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'error_depth) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'error_surge_speed) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'error_sway_speed) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Rel_error_joystick>)))
  "Returns string type for a message object of type '<Rel_error_joystick>"
  "joystick_command/Rel_error_joystick")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Rel_error_joystick)))
  "Returns string type for a message object of type 'Rel_error_joystick"
  "joystick_command/Rel_error_joystick")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Rel_error_joystick>)))
  "Returns md5sum for a message object of type '<Rel_error_joystick>"
  "eb21a06c4e8dda99b50b5307a898900c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Rel_error_joystick)))
  "Returns md5sum for a message object of type 'Rel_error_joystick"
  "eb21a06c4e8dda99b50b5307a898900c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Rel_error_joystick>)))
  "Returns full string definition for message of type '<Rel_error_joystick>"
  (cl:format cl:nil "Header header~%~%float64 error_roll          # Roll relative error   [deg]~%float64 error_pitch         # Pitch relative error  [deg]~%float64 error_yaw           # Yaw relative error    [deg]~%~%float64 error_distance      # Frontal distance relative error   [m]~%float64 error_depth         # Depth relative error              [m]~%~%float64 error_surge_speed   # Desired absolute surge speed (x axis) [m/s]~%float64 error_sway_speed    # Desired absolute sway speed (y axis)  [m/s]~%~%#                #     SURGE SPEED    #     SWAY SPEED    #     YAW RATE     #    DEPTH RATE    #     PITCH RATE     #~%# ------------------------------------------------------------------------------------------------------------------ #~%#    MAX VALUES  #      0.25 m/s      #      0.25 m/s     #     10 deg/s     #    0.125 m/s     #      5.0 deg/s     #~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Rel_error_joystick)))
  "Returns full string definition for message of type 'Rel_error_joystick"
  (cl:format cl:nil "Header header~%~%float64 error_roll          # Roll relative error   [deg]~%float64 error_pitch         # Pitch relative error  [deg]~%float64 error_yaw           # Yaw relative error    [deg]~%~%float64 error_distance      # Frontal distance relative error   [m]~%float64 error_depth         # Depth relative error              [m]~%~%float64 error_surge_speed   # Desired absolute surge speed (x axis) [m/s]~%float64 error_sway_speed    # Desired absolute sway speed (y axis)  [m/s]~%~%#                #     SURGE SPEED    #     SWAY SPEED    #     YAW RATE     #    DEPTH RATE    #     PITCH RATE     #~%# ------------------------------------------------------------------------------------------------------------------ #~%#    MAX VALUES  #      0.25 m/s      #      0.25 m/s     #     10 deg/s     #    0.125 m/s     #      5.0 deg/s     #~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Rel_error_joystick>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     8
     8
     8
     8
     8
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Rel_error_joystick>))
  "Converts a ROS message object to a list"
  (cl:list 'Rel_error_joystick
    (cl:cons ':header (header msg))
    (cl:cons ':error_roll (error_roll msg))
    (cl:cons ':error_pitch (error_pitch msg))
    (cl:cons ':error_yaw (error_yaw msg))
    (cl:cons ':error_distance (error_distance msg))
    (cl:cons ':error_depth (error_depth msg))
    (cl:cons ':error_surge_speed (error_surge_speed msg))
    (cl:cons ':error_sway_speed (error_sway_speed msg))
))
