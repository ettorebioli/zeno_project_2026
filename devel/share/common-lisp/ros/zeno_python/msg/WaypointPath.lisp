; Auto-generated. Do not edit!


(cl:in-package zeno_python-msg)


;//! \htmlinclude WaypointPath.msg.html

(cl:defclass <WaypointPath> (roslisp-msg-protocol:ros-message)
  ((waypoints
    :reader waypoints
    :initarg :waypoints
    :type (cl:vector geometry_msgs-msg:Point)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Point :initial-element (cl:make-instance 'geometry_msgs-msg:Point))))
)

(cl:defclass WaypointPath (<WaypointPath>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <WaypointPath>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'WaypointPath)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name zeno_python-msg:<WaypointPath> is deprecated: use zeno_python-msg:WaypointPath instead.")))

(cl:ensure-generic-function 'waypoints-val :lambda-list '(m))
(cl:defmethod waypoints-val ((m <WaypointPath>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader zeno_python-msg:waypoints-val is deprecated.  Use zeno_python-msg:waypoints instead.")
  (waypoints m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <WaypointPath>) ostream)
  "Serializes a message object of type '<WaypointPath>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'waypoints))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'waypoints))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <WaypointPath>) istream)
  "Deserializes a message object of type '<WaypointPath>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'waypoints) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'waypoints)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'geometry_msgs-msg:Point))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<WaypointPath>)))
  "Returns string type for a message object of type '<WaypointPath>"
  "zeno_python/WaypointPath")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'WaypointPath)))
  "Returns string type for a message object of type 'WaypointPath"
  "zeno_python/WaypointPath")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<WaypointPath>)))
  "Returns md5sum for a message object of type '<WaypointPath>"
  "0511c019d3d3f0edeb56aaf3709c8aea")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'WaypointPath)))
  "Returns md5sum for a message object of type 'WaypointPath"
  "0511c019d3d3f0edeb56aaf3709c8aea")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<WaypointPath>)))
  "Returns full string definition for message of type '<WaypointPath>"
  (cl:format cl:nil "geometry_msgs/Point[] waypoints ~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'WaypointPath)))
  "Returns full string definition for message of type 'WaypointPath"
  (cl:format cl:nil "geometry_msgs/Point[] waypoints ~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <WaypointPath>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'waypoints) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <WaypointPath>))
  "Converts a ROS message object to a list"
  (cl:list 'WaypointPath
    (cl:cons ':waypoints (waypoints msg))
))
