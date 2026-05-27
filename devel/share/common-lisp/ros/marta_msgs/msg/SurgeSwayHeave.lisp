; Auto-generated. Do not edit!


(cl:in-package marta_msgs-msg)


;//! \htmlinclude SurgeSwayHeave.msg.html

(cl:defclass <SurgeSwayHeave> (roslisp-msg-protocol:ros-message)
  ((surge
    :reader surge
    :initarg :surge
    :type cl:float
    :initform 0.0)
   (sway
    :reader sway
    :initarg :sway
    :type cl:float
    :initform 0.0)
   (heave
    :reader heave
    :initarg :heave
    :type cl:float
    :initform 0.0))
)

(cl:defclass SurgeSwayHeave (<SurgeSwayHeave>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SurgeSwayHeave>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SurgeSwayHeave)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name marta_msgs-msg:<SurgeSwayHeave> is deprecated: use marta_msgs-msg:SurgeSwayHeave instead.")))

(cl:ensure-generic-function 'surge-val :lambda-list '(m))
(cl:defmethod surge-val ((m <SurgeSwayHeave>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:surge-val is deprecated.  Use marta_msgs-msg:surge instead.")
  (surge m))

(cl:ensure-generic-function 'sway-val :lambda-list '(m))
(cl:defmethod sway-val ((m <SurgeSwayHeave>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:sway-val is deprecated.  Use marta_msgs-msg:sway instead.")
  (sway m))

(cl:ensure-generic-function 'heave-val :lambda-list '(m))
(cl:defmethod heave-val ((m <SurgeSwayHeave>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:heave-val is deprecated.  Use marta_msgs-msg:heave instead.")
  (heave m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SurgeSwayHeave>) ostream)
  "Serializes a message object of type '<SurgeSwayHeave>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'surge))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'sway))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'heave))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SurgeSwayHeave>) istream)
  "Deserializes a message object of type '<SurgeSwayHeave>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'surge) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'sway) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'heave) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SurgeSwayHeave>)))
  "Returns string type for a message object of type '<SurgeSwayHeave>"
  "marta_msgs/SurgeSwayHeave")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SurgeSwayHeave)))
  "Returns string type for a message object of type 'SurgeSwayHeave"
  "marta_msgs/SurgeSwayHeave")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SurgeSwayHeave>)))
  "Returns md5sum for a message object of type '<SurgeSwayHeave>"
  "37a93273a4b90846c44a065401ed273f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SurgeSwayHeave)))
  "Returns md5sum for a message object of type 'SurgeSwayHeave"
  "37a93273a4b90846c44a065401ed273f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SurgeSwayHeave>)))
  "Returns full string definition for message of type '<SurgeSwayHeave>"
  (cl:format cl:nil "float64 surge~%float64 sway~%float64 heave~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SurgeSwayHeave)))
  "Returns full string definition for message of type 'SurgeSwayHeave"
  (cl:format cl:nil "float64 surge~%float64 sway~%float64 heave~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SurgeSwayHeave>))
  (cl:+ 0
     8
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SurgeSwayHeave>))
  "Converts a ROS message object to a list"
  (cl:list 'SurgeSwayHeave
    (cl:cons ':surge (surge msg))
    (cl:cons ':sway (sway msg))
    (cl:cons ':heave (heave msg))
))
