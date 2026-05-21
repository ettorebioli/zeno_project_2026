;; Auto-generated. Do not edit!


(when (boundp 'marta_msgs::SurgeSwayHeave)
  (if (not (find-package "MARTA_MSGS"))
    (make-package "MARTA_MSGS"))
  (shadow 'SurgeSwayHeave (find-package "MARTA_MSGS")))
(unless (find-package "MARTA_MSGS::SURGESWAYHEAVE")
  (make-package "MARTA_MSGS::SURGESWAYHEAVE"))

(in-package "ROS")
;;//! \htmlinclude SurgeSwayHeave.msg.html


(defclass marta_msgs::SurgeSwayHeave
  :super ros::object
  :slots (_surge _sway _heave ))

(defmethod marta_msgs::SurgeSwayHeave
  (:init
   (&key
    ((:surge __surge) 0.0)
    ((:sway __sway) 0.0)
    ((:heave __heave) 0.0)
    )
   (send-super :init)
   (setq _surge (float __surge))
   (setq _sway (float __sway))
   (setq _heave (float __heave))
   self)
  (:surge
   (&optional __surge)
   (if __surge (setq _surge __surge)) _surge)
  (:sway
   (&optional __sway)
   (if __sway (setq _sway __sway)) _sway)
  (:heave
   (&optional __heave)
   (if __heave (setq _heave __heave)) _heave)
  (:serialization-length
   ()
   (+
    ;; float64 _surge
    8
    ;; float64 _sway
    8
    ;; float64 _heave
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _surge
       (sys::poke _surge (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _sway
       (sys::poke _sway (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _heave
       (sys::poke _heave (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _surge
     (setq _surge (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _sway
     (setq _sway (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _heave
     (setq _heave (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get marta_msgs::SurgeSwayHeave :md5sum-) "37a93273a4b90846c44a065401ed273f")
(setf (get marta_msgs::SurgeSwayHeave :datatype-) "marta_msgs/SurgeSwayHeave")
(setf (get marta_msgs::SurgeSwayHeave :definition-)
      "float64 surge
float64 sway
float64 heave

")



(provide :marta_msgs/SurgeSwayHeave "37a93273a4b90846c44a065401ed273f")


