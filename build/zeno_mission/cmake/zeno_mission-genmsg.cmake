# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "zeno_mission: 1 messages, 0 services")

set(MSG_I_FLAGS "-Izeno_mission:/home/student/catkin_ws/src/zeno_mission/msg;-Istd_msgs:/opt/ros/melodic/share/std_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/melodic/share/geometry_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(zeno_mission_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/student/catkin_ws/src/zeno_mission/msg/WaypointPath.msg" NAME_WE)
add_custom_target(_zeno_mission_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "zeno_mission" "/home/student/catkin_ws/src/zeno_mission/msg/WaypointPath.msg" "geometry_msgs/Point"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(zeno_mission
  "/home/student/catkin_ws/src/zeno_mission/msg/WaypointPath.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/zeno_mission
)

### Generating Services

### Generating Module File
_generate_module_cpp(zeno_mission
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/zeno_mission
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(zeno_mission_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(zeno_mission_generate_messages zeno_mission_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/student/catkin_ws/src/zeno_mission/msg/WaypointPath.msg" NAME_WE)
add_dependencies(zeno_mission_generate_messages_cpp _zeno_mission_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(zeno_mission_gencpp)
add_dependencies(zeno_mission_gencpp zeno_mission_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS zeno_mission_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(zeno_mission
  "/home/student/catkin_ws/src/zeno_mission/msg/WaypointPath.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/zeno_mission
)

### Generating Services

### Generating Module File
_generate_module_eus(zeno_mission
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/zeno_mission
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(zeno_mission_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(zeno_mission_generate_messages zeno_mission_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/student/catkin_ws/src/zeno_mission/msg/WaypointPath.msg" NAME_WE)
add_dependencies(zeno_mission_generate_messages_eus _zeno_mission_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(zeno_mission_geneus)
add_dependencies(zeno_mission_geneus zeno_mission_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS zeno_mission_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(zeno_mission
  "/home/student/catkin_ws/src/zeno_mission/msg/WaypointPath.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/zeno_mission
)

### Generating Services

### Generating Module File
_generate_module_lisp(zeno_mission
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/zeno_mission
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(zeno_mission_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(zeno_mission_generate_messages zeno_mission_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/student/catkin_ws/src/zeno_mission/msg/WaypointPath.msg" NAME_WE)
add_dependencies(zeno_mission_generate_messages_lisp _zeno_mission_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(zeno_mission_genlisp)
add_dependencies(zeno_mission_genlisp zeno_mission_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS zeno_mission_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(zeno_mission
  "/home/student/catkin_ws/src/zeno_mission/msg/WaypointPath.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/zeno_mission
)

### Generating Services

### Generating Module File
_generate_module_nodejs(zeno_mission
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/zeno_mission
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(zeno_mission_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(zeno_mission_generate_messages zeno_mission_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/student/catkin_ws/src/zeno_mission/msg/WaypointPath.msg" NAME_WE)
add_dependencies(zeno_mission_generate_messages_nodejs _zeno_mission_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(zeno_mission_gennodejs)
add_dependencies(zeno_mission_gennodejs zeno_mission_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS zeno_mission_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(zeno_mission
  "/home/student/catkin_ws/src/zeno_mission/msg/WaypointPath.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/zeno_mission
)

### Generating Services

### Generating Module File
_generate_module_py(zeno_mission
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/zeno_mission
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(zeno_mission_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(zeno_mission_generate_messages zeno_mission_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/student/catkin_ws/src/zeno_mission/msg/WaypointPath.msg" NAME_WE)
add_dependencies(zeno_mission_generate_messages_py _zeno_mission_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(zeno_mission_genpy)
add_dependencies(zeno_mission_genpy zeno_mission_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS zeno_mission_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/zeno_mission)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/zeno_mission
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(zeno_mission_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(zeno_mission_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/zeno_mission)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/zeno_mission
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(zeno_mission_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(zeno_mission_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/zeno_mission)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/zeno_mission
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(zeno_mission_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(zeno_mission_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/zeno_mission)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/zeno_mission
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(zeno_mission_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(zeno_mission_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/zeno_mission)
  install(CODE "execute_process(COMMAND \"/usr/bin/python2\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/zeno_mission\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/zeno_mission
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(zeno_mission_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(zeno_mission_generate_messages_py geometry_msgs_generate_messages_py)
endif()
