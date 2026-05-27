; Auto-generated. Do not edit!


(cl:in-package marta_msgs-msg)


;//! \htmlinclude NorthEastDown.msg.html

(cl:defclass <NorthEastDown> (roslisp-msg-protocol:ros-message)
  ((north
    :reader north
    :initarg :north
    :type cl:float
    :initform 0.0)
   (east
    :reader east
    :initarg :east
    :type cl:float
    :initform 0.0)
   (down
    :reader down
    :initarg :down
    :type cl:float
    :initform 0.0))
)

(cl:defclass NorthEastDown (<NorthEastDown>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <NorthEastDown>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'NorthEastDown)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name marta_msgs-msg:<NorthEastDown> is deprecated: use marta_msgs-msg:NorthEastDown instead.")))

(cl:ensure-generic-function 'north-val :lambda-list '(m))
(cl:defmethod north-val ((m <NorthEastDown>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:north-val is deprecated.  Use marta_msgs-msg:north instead.")
  (north m))

(cl:ensure-generic-function 'east-val :lambda-list '(m))
(cl:defmethod east-val ((m <NorthEastDown>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:east-val is deprecated.  Use marta_msgs-msg:east instead.")
  (east m))

(cl:ensure-generic-function 'down-val :lambda-list '(m))
(cl:defmethod down-val ((m <NorthEastDown>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:down-val is deprecated.  Use marta_msgs-msg:down instead.")
  (down m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <NorthEastDown>) ostream)
  "Serializes a message object of type '<NorthEastDown>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'north))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'east))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'down))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <NorthEastDown>) istream)
  "Deserializes a message object of type '<NorthEastDown>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'north) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'east) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'down) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<NorthEastDown>)))
  "Returns string type for a message object of type '<NorthEastDown>"
  "marta_msgs/NorthEastDown")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'NorthEastDown)))
  "Returns string type for a message object of type 'NorthEastDown"
  "marta_msgs/NorthEastDown")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<NorthEastDown>)))
  "Returns md5sum for a message object of type '<NorthEastDown>"
  "81fca827a727a73c11e9d24a75a9174f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'NorthEastDown)))
  "Returns md5sum for a message object of type 'NorthEastDown"
  "81fca827a727a73c11e9d24a75a9174f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<NorthEastDown>)))
  "Returns full string definition for message of type '<NorthEastDown>"
  (cl:format cl:nil "float64 north~%float64 east~%float64 down~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'NorthEastDown)))
  "Returns full string definition for message of type 'NorthEastDown"
  (cl:format cl:nil "float64 north~%float64 east~%float64 down~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <NorthEastDown>))
  (cl:+ 0
     8
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <NorthEastDown>))
  "Converts a ROS message object to a list"
  (cl:list 'NorthEastDown
    (cl:cons ':north (north msg))
    (cl:cons ':east (east msg))
    (cl:cons ':down (down msg))
))
