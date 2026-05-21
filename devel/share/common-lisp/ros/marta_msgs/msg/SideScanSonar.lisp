; Auto-generated. Do not edit!


(cl:in-package marta_msgs-msg)


;//! \htmlinclude SideScanSonar.msg.html

(cl:defclass <SideScanSonar> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (range
    :reader range
    :initarg :range
    :type cl:float
    :initform 0.0)
   (left_beam
    :reader left_beam
    :initarg :left_beam
    :type std_msgs-msg:UInt8MultiArray
    :initform (cl:make-instance 'std_msgs-msg:UInt8MultiArray))
   (right_beam
    :reader right_beam
    :initarg :right_beam
    :type std_msgs-msg:UInt8MultiArray
    :initform (cl:make-instance 'std_msgs-msg:UInt8MultiArray)))
)

(cl:defclass SideScanSonar (<SideScanSonar>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SideScanSonar>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SideScanSonar)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name marta_msgs-msg:<SideScanSonar> is deprecated: use marta_msgs-msg:SideScanSonar instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <SideScanSonar>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:header-val is deprecated.  Use marta_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'range-val :lambda-list '(m))
(cl:defmethod range-val ((m <SideScanSonar>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:range-val is deprecated.  Use marta_msgs-msg:range instead.")
  (range m))

(cl:ensure-generic-function 'left_beam-val :lambda-list '(m))
(cl:defmethod left_beam-val ((m <SideScanSonar>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:left_beam-val is deprecated.  Use marta_msgs-msg:left_beam instead.")
  (left_beam m))

(cl:ensure-generic-function 'right_beam-val :lambda-list '(m))
(cl:defmethod right_beam-val ((m <SideScanSonar>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marta_msgs-msg:right_beam-val is deprecated.  Use marta_msgs-msg:right_beam instead.")
  (right_beam m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SideScanSonar>) ostream)
  "Serializes a message object of type '<SideScanSonar>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'range))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'left_beam) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'right_beam) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SideScanSonar>) istream)
  "Deserializes a message object of type '<SideScanSonar>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'range) (roslisp-utils:decode-single-float-bits bits)))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'left_beam) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'right_beam) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SideScanSonar>)))
  "Returns string type for a message object of type '<SideScanSonar>"
  "marta_msgs/SideScanSonar")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SideScanSonar)))
  "Returns string type for a message object of type 'SideScanSonar"
  "marta_msgs/SideScanSonar")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SideScanSonar>)))
  "Returns md5sum for a message object of type '<SideScanSonar>"
  "88e1d1c22f1868590e9f2ba229dda693")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SideScanSonar)))
  "Returns md5sum for a message object of type 'SideScanSonar"
  "88e1d1c22f1868590e9f2ba229dda693")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SideScanSonar>)))
  "Returns full string definition for message of type '<SideScanSonar>"
  (cl:format cl:nil "Header                     header~%~%float32                    range~%~%std_msgs/UInt8MultiArray   left_beam~%~%std_msgs/UInt8MultiArray   right_beam~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: std_msgs/UInt8MultiArray~%# Please look at the MultiArrayLayout message definition for~%# documentation on all multiarrays.~%~%MultiArrayLayout  layout        # specification of data layout~%uint8[]           data          # array of data~%~%~%================================================================================~%MSG: std_msgs/MultiArrayLayout~%# The multiarray declares a generic multi-dimensional array of a~%# particular data type.  Dimensions are ordered from outer most~%# to inner most.~%~%MultiArrayDimension[] dim # Array of dimension properties~%uint32 data_offset        # padding elements at front of data~%~%# Accessors should ALWAYS be written in terms of dimension stride~%# and specified outer-most dimension first.~%# ~%# multiarray(i,j,k) = data[data_offset + dim_stride[1]*i + dim_stride[2]*j + k]~%#~%# A standard, 3-channel 640x480 image with interleaved color channels~%# would be specified as:~%#~%# dim[0].label  = \"height\"~%# dim[0].size   = 480~%# dim[0].stride = 3*640*480 = 921600  (note dim[0] stride is just size of image)~%# dim[1].label  = \"width\"~%# dim[1].size   = 640~%# dim[1].stride = 3*640 = 1920~%# dim[2].label  = \"channel\"~%# dim[2].size   = 3~%# dim[2].stride = 3~%#~%# multiarray(i,j,k) refers to the ith row, jth column, and kth channel.~%~%================================================================================~%MSG: std_msgs/MultiArrayDimension~%string label   # label of given dimension~%uint32 size    # size of given dimension (in type units)~%uint32 stride  # stride of given dimension~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SideScanSonar)))
  "Returns full string definition for message of type 'SideScanSonar"
  (cl:format cl:nil "Header                     header~%~%float32                    range~%~%std_msgs/UInt8MultiArray   left_beam~%~%std_msgs/UInt8MultiArray   right_beam~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: std_msgs/UInt8MultiArray~%# Please look at the MultiArrayLayout message definition for~%# documentation on all multiarrays.~%~%MultiArrayLayout  layout        # specification of data layout~%uint8[]           data          # array of data~%~%~%================================================================================~%MSG: std_msgs/MultiArrayLayout~%# The multiarray declares a generic multi-dimensional array of a~%# particular data type.  Dimensions are ordered from outer most~%# to inner most.~%~%MultiArrayDimension[] dim # Array of dimension properties~%uint32 data_offset        # padding elements at front of data~%~%# Accessors should ALWAYS be written in terms of dimension stride~%# and specified outer-most dimension first.~%# ~%# multiarray(i,j,k) = data[data_offset + dim_stride[1]*i + dim_stride[2]*j + k]~%#~%# A standard, 3-channel 640x480 image with interleaved color channels~%# would be specified as:~%#~%# dim[0].label  = \"height\"~%# dim[0].size   = 480~%# dim[0].stride = 3*640*480 = 921600  (note dim[0] stride is just size of image)~%# dim[1].label  = \"width\"~%# dim[1].size   = 640~%# dim[1].stride = 3*640 = 1920~%# dim[2].label  = \"channel\"~%# dim[2].size   = 3~%# dim[2].stride = 3~%#~%# multiarray(i,j,k) refers to the ith row, jth column, and kth channel.~%~%================================================================================~%MSG: std_msgs/MultiArrayDimension~%string label   # label of given dimension~%uint32 size    # size of given dimension (in type units)~%uint32 stride  # stride of given dimension~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SideScanSonar>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'left_beam))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'right_beam))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SideScanSonar>))
  "Converts a ROS message object to a list"
  (cl:list 'SideScanSonar
    (cl:cons ':header (header msg))
    (cl:cons ':range (range msg))
    (cl:cons ':left_beam (left_beam msg))
    (cl:cons ':right_beam (right_beam msg))
))
