;; Auto-generated. Do not edit!


(when (boundp 'zeno_python::WaypointPath)
  (if (not (find-package "ZENO_PYTHON"))
    (make-package "ZENO_PYTHON"))
  (shadow 'WaypointPath (find-package "ZENO_PYTHON")))
(unless (find-package "ZENO_PYTHON::WAYPOINTPATH")
  (make-package "ZENO_PYTHON::WAYPOINTPATH"))

(in-package "ROS")
;;//! \htmlinclude WaypointPath.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass zeno_python::WaypointPath
  :super ros::object
  :slots (_waypoints ))

(defmethod zeno_python::WaypointPath
  (:init
   (&key
    ((:waypoints __waypoints) (let (r) (dotimes (i 0) (push (instance geometry_msgs::Point :init) r)) r))
    )
   (send-super :init)
   (setq _waypoints __waypoints)
   self)
  (:waypoints
   (&rest __waypoints)
   (if (keywordp (car __waypoints))
       (send* _waypoints __waypoints)
     (progn
       (if __waypoints (setq _waypoints (car __waypoints)))
       _waypoints)))
  (:serialization-length
   ()
   (+
    ;; geometry_msgs/Point[] _waypoints
    (apply #'+ (send-all _waypoints :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/Point[] _waypoints
     (write-long (length _waypoints) s)
     (dolist (elem _waypoints)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/Point[] _waypoints
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _waypoints (let (r) (dotimes (i n) (push (instance geometry_msgs::Point :init) r)) r))
     (dolist (elem- _waypoints)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get zeno_python::WaypointPath :md5sum-) "0511c019d3d3f0edeb56aaf3709c8aea")
(setf (get zeno_python::WaypointPath :datatype-) "zeno_python/WaypointPath")
(setf (get zeno_python::WaypointPath :definition-)
      "geometry_msgs/Point[] waypoints 
================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

")



(provide :zeno_python/WaypointPath "0511c019d3d3f0edeb56aaf3709c8aea")


