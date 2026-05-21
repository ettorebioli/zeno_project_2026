
(cl:in-package :asdf)

(defsystem "zeno_python-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
)
  :components ((:file "_package")
    (:file "WaypointPath" :depends-on ("_package_WaypointPath"))
    (:file "_package_WaypointPath" :depends-on ("_package"))
  ))