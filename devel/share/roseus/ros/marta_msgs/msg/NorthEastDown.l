;; Auto-generated. Do not edit!


(when (boundp 'marta_msgs::NorthEastDown)
  (if (not (find-package "MARTA_MSGS"))
    (make-package "MARTA_MSGS"))
  (shadow 'NorthEastDown (find-package "MARTA_MSGS")))
(unless (find-package "MARTA_MSGS::NORTHEASTDOWN")
  (make-package "MARTA_MSGS::NORTHEASTDOWN"))

(in-package "ROS")
;;//! \htmlinclude NorthEastDown.msg.html


(defclass marta_msgs::NorthEastDown
  :super ros::object
  :slots (_north _east _down ))

(defmethod marta_msgs::NorthEastDown
  (:init
   (&key
    ((:north __north) 0.0)
    ((:east __east) 0.0)
    ((:down __down) 0.0)
    )
   (send-super :init)
   (setq _north (float __north))
   (setq _east (float __east))
   (setq _down (float __down))
   self)
  (:north
   (&optional __north)
   (if __north (setq _north __north)) _north)
  (:east
   (&optional __east)
   (if __east (setq _east __east)) _east)
  (:down
   (&optional __down)
   (if __down (setq _down __down)) _down)
  (:serialization-length
   ()
   (+
    ;; float64 _north
    8
    ;; float64 _east
    8
    ;; float64 _down
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _north
       (sys::poke _north (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _east
       (sys::poke _east (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _down
       (sys::poke _down (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _north
     (setq _north (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _east
     (setq _east (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _down
     (setq _down (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get marta_msgs::NorthEastDown :md5sum-) "81fca827a727a73c11e9d24a75a9174f")
(setf (get marta_msgs::NorthEastDown :datatype-) "marta_msgs/NorthEastDown")
(setf (get marta_msgs::NorthEastDown :definition-)
      "float64 north
float64 east
float64 down

")



(provide :marta_msgs/NorthEastDown "81fca827a727a73c11e9d24a75a9174f")


