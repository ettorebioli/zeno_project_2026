; Auto-generated. Do not edit!


(cl:in-package marta_msgs-msg)


;//! \htmlinclude LatitudeLongitudeDepth.msg.html

(cl:defclass <LatitudeLongitudeDepth> (roslisp-msg-protocol:ros-message)
  ((latitude
    :reader latitude
    :initarg :latitude
    :type cl:float
    :initform 0.0)
   (longitude
    :reader longitude
    :initarg :longitude
    :type cl:float
    :initform 0.0)
   (depth
    :reader depth
    :initarg :depth
    :type cl:float
    :initform 0.0))
)

(cl:defclass LatitudeLongitudeDepth (<LatitudeLongitudeDepth>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LatitudeLongitudeDepth>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LatitudeLongitudeDepth)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name marta_msgs-msg:<LatitudeLongitudeDepth> is deprecated: use marta_msgs-msg:LatitudeLongitudeDepth instead.")))

(cl:ensure-generic-function 'latitude-val :lambda-list '(m))
(cl:defmethod latitude-val ((m <LatitudeLongitudeDepth>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:latitude-val is deprecated.  Use marta_msgs-msg:latitude instead.")
  (latitude m))

(cl:ensure-generic-function 'longitude-val :lambda-list '(m))
(cl:defmethod longitude-val ((m <LatitudeLongitudeDepth>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:longitude-val is deprecated.  Use marta_msgs-msg:longitude instead.")
  (longitude m))

(cl:ensure-generic-function 'depth-val :lambda-list '(m))
(cl:defmethod depth-val ((m <LatitudeLongitudeDepth>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:depth-val is deprecated.  Use marta_msgs-msg:depth instead.")
  (depth m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LatitudeLongitudeDepth>) ostream)
  "Serializes a message object of type '<LatitudeLongitudeDepth>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'latitude))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'longitude))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'depth))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LatitudeLongitudeDepth>) istream)
  "Deserializes a message object of type '<LatitudeLongitudeDepth>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'latitude) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'longitude) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'depth) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LatitudeLongitudeDepth>)))
  "Returns string type for a message object of type '<LatitudeLongitudeDepth>"
  "marta_msgs/LatitudeLongitudeDepth")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LatitudeLongitudeDepth)))
  "Returns string type for a message object of type 'LatitudeLongitudeDepth"
  "marta_msgs/LatitudeLongitudeDepth")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LatitudeLongitudeDepth>)))
  "Returns md5sum for a message object of type '<LatitudeLongitudeDepth>"
  "0f7d102e64867310c926f4f670659eba")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LatitudeLongitudeDepth)))
  "Returns md5sum for a message object of type 'LatitudeLongitudeDepth"
  "0f7d102e64867310c926f4f670659eba")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LatitudeLongitudeDepth>)))
  "Returns full string definition for message of type '<LatitudeLongitudeDepth>"
  (cl:format cl:nil "float64 latitude~%float64 longitude~%float64 depth~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LatitudeLongitudeDepth)))
  "Returns full string definition for message of type 'LatitudeLongitudeDepth"
  (cl:format cl:nil "float64 latitude~%float64 longitude~%float64 depth~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LatitudeLongitudeDepth>))
  (cl:+ 0
     8
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LatitudeLongitudeDepth>))
  "Converts a ROS message object to a list"
  (cl:list 'LatitudeLongitudeDepth
    (cl:cons ':latitude (latitude msg))
    (cl:cons ':longitude (longitude msg))
    (cl:cons ':depth (depth msg))
))
