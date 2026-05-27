;; Auto-generated. Do not edit!


(when (boundp 'marta_msgs::SideScanSonar)
  (if (not (find-package "MARTA_MSGS"))
    (make-package "MARTA_MSGS"))
  (shadow 'SideScanSonar (find-package "MARTA_MSGS")))
(unless (find-package "MARTA_MSGS::SIDESCANSONAR")
  (make-package "MARTA_MSGS::SIDESCANSONAR"))

(in-package "ROS")
;;//! \htmlinclude SideScanSonar.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass marta_msgs::SideScanSonar
  :super ros::object
  :slots (_header _range _left_beam _right_beam ))

(defmethod marta_msgs::SideScanSonar
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:range __range) 0.0)
    ((:left_beam __left_beam) (instance std_msgs::UInt8MultiArray :init))
    ((:right_beam __right_beam) (instance std_msgs::UInt8MultiArray :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _range (float __range))
   (setq _left_beam __left_beam)
   (setq _right_beam __right_beam)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:range
   (&optional __range)
   (if __range (setq _range __range)) _range)
  (:left_beam
   (&rest __left_beam)
   (if (keywordp (car __left_beam))
       (send* _left_beam __left_beam)
     (progn
       (if __left_beam (setq _left_beam (car __left_beam)))
       _left_beam)))
  (:right_beam
   (&rest __right_beam)
   (if (keywordp (car __right_beam))
       (send* _right_beam __right_beam)
     (progn
       (if __right_beam (setq _right_beam (car __right_beam)))
       _right_beam)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _range
    4
    ;; std_msgs/UInt8MultiArray _left_beam
    (send _left_beam :serialization-length)
    ;; std_msgs/UInt8MultiArray _right_beam
    (send _right_beam :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _range
       (sys::poke _range (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; std_msgs/UInt8MultiArray _left_beam
       (send _left_beam :serialize s)
     ;; std_msgs/UInt8MultiArray _right_beam
       (send _right_beam :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _range
     (setq _range (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; std_msgs/UInt8MultiArray _left_beam
     (send _left_beam :deserialize buf ptr-) (incf ptr- (send _left_beam :serialization-length))
   ;; std_msgs/UInt8MultiArray _right_beam
     (send _right_beam :deserialize buf ptr-) (incf ptr- (send _right_beam :serialization-length))
   ;;
   self)
  )

(setf (get marta_msgs::SideScanSonar :md5sum-) "88e1d1c22f1868590e9f2ba229dda693")
(setf (get marta_msgs::SideScanSonar :datatype-) "marta_msgs/SideScanSonar")
(setf (get marta_msgs::SideScanSonar :definition-)
      "Header                     header

float32                    range

std_msgs/UInt8MultiArray   left_beam

std_msgs/UInt8MultiArray   right_beam

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
MSG: std_msgs/UInt8MultiArray
# Please look at the MultiArrayLayout message definition for
# documentation on all multiarrays.

MultiArrayLayout  layout        # specification of data layout
uint8[]           data          # array of data


================================================================================
MSG: std_msgs/MultiArrayLayout
# The multiarray declares a generic multi-dimensional array of a
# particular data type.  Dimensions are ordered from outer most
# to inner most.

MultiArrayDimension[] dim # Array of dimension properties
uint32 data_offset        # padding elements at front of data

# Accessors should ALWAYS be written in terms of dimension stride
# and specified outer-most dimension first.
# 
# multiarray(i,j,k) = data[data_offset + dim_stride[1]*i + dim_stride[2]*j + k]
#
# A standard, 3-channel 640x480 image with interleaved color channels
# would be specified as:
#
# dim[0].label  = \"height\"
# dim[0].size   = 480
# dim[0].stride = 3*640*480 = 921600  (note dim[0] stride is just size of image)
# dim[1].label  = \"width\"
# dim[1].size   = 640
# dim[1].stride = 3*640 = 1920
# dim[2].label  = \"channel\"
# dim[2].size   = 3
# dim[2].stride = 3
#
# multiarray(i,j,k) refers to the ith row, jth column, and kth channel.

================================================================================
MSG: std_msgs/MultiArrayDimension
string label   # label of given dimension
uint32 size    # size of given dimension (in type units)
uint32 stride  # stride of given dimension
")



(provide :marta_msgs/SideScanSonar "88e1d1c22f1868590e9f2ba229dda693")


