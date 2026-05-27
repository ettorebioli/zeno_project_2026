
(cl:in-package :asdf)

(defsystem "joystick_command-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :std_msgs-msg
)
  :components ((:file "_package")
    (:file "Rel_error_joystick" :depends-on ("_package_Rel_error_joystick"))
    (:file "_package_Rel_error_joystick" :depends-on ("_package"))
  ))