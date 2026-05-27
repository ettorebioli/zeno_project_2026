// Auto-generated. Do not edit!

// (in-package marta_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Position = require('./Position.js');
let Euler = require('./Euler.js');
let Quaternion = require('./Quaternion.js');
let geometry_msgs = _finder('geometry_msgs');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class NavStatus {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.position = null;
      this.orientation = null;
      this.quaternion = null;
      this.ned_speed = null;
      this.omega_body = null;
      this.gps_status = null;
      this.initialized = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('position')) {
        this.position = initObj.position
      }
      else {
        this.position = new Position();
      }
      if (initObj.hasOwnProperty('orientation')) {
        this.orientation = initObj.orientation
      }
      else {
        this.orientation = new Euler();
      }
      if (initObj.hasOwnProperty('quaternion')) {
        this.quaternion = initObj.quaternion
      }
      else {
        this.quaternion = new Quaternion();
      }
      if (initObj.hasOwnProperty('ned_speed')) {
        this.ned_speed = initObj.ned_speed
      }
      else {
        this.ned_speed = new geometry_msgs.msg.Vector3();
      }
      if (initObj.hasOwnProperty('omega_body')) {
        this.omega_body = initObj.omega_body
      }
      else {
        this.omega_body = new geometry_msgs.msg.Vector3();
      }
      if (initObj.hasOwnProperty('gps_status')) {
        this.gps_status = initObj.gps_status
      }
      else {
        this.gps_status = 0;
      }
      if (initObj.hasOwnProperty('initialized')) {
        this.initialized = initObj.initialized
      }
      else {
        this.initialized = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type NavStatus
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [position]
    bufferOffset = Position.serialize(obj.position, buffer, bufferOffset);
    // Serialize message field [orientation]
    bufferOffset = Euler.serialize(obj.orientation, buffer, bufferOffset);
    // Serialize message field [quaternion]
    bufferOffset = Quaternion.serialize(obj.quaternion, buffer, bufferOffset);
    // Serialize message field [ned_speed]
    bufferOffset = geometry_msgs.msg.Vector3.serialize(obj.ned_speed, buffer, bufferOffset);
    // Serialize message field [omega_body]
    bufferOffset = geometry_msgs.msg.Vector3.serialize(obj.omega_body, buffer, bufferOffset);
    // Serialize message field [gps_status]
    bufferOffset = _serializer.uint8(obj.gps_status, buffer, bufferOffset);
    // Serialize message field [initialized]
    bufferOffset = _serializer.bool(obj.initialized, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type NavStatus
    let len;
    let data = new NavStatus(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [position]
    data.position = Position.deserialize(buffer, bufferOffset);
    // Deserialize message field [orientation]
    data.orientation = Euler.deserialize(buffer, bufferOffset);
    // Deserialize message field [quaternion]
    data.quaternion = Quaternion.deserialize(buffer, bufferOffset);
    // Deserialize message field [ned_speed]
    data.ned_speed = geometry_msgs.msg.Vector3.deserialize(buffer, bufferOffset);
    // Deserialize message field [omega_body]
    data.omega_body = geometry_msgs.msg.Vector3.deserialize(buffer, bufferOffset);
    // Deserialize message field [gps_status]
    data.gps_status = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [initialized]
    data.initialized = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 130;
  }

  static datatype() {
    // Returns string type for a message object
    return 'marta_msgs/NavStatus';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '2652576ed189854bff45893603a05bc0';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    marta_msgs/Position position
     
    marta_msgs/Euler orientation
    
    marta_msgs/Quaternion quaternion
    
    geometry_msgs/Vector3 ned_speed
    
    geometry_msgs/Vector3 omega_body
    
    uint8 gps_status
    
    bool initialized
    
    
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
    MSG: marta_msgs/Position
    float64 latitude
    float64 longitude
    float64 depth
    
    ================================================================================
    MSG: marta_msgs/Euler
    float64 roll
    float64 pitch
    float64 yaw
    
    ================================================================================
    MSG: marta_msgs/Quaternion
    float64 w
    float64 x
    float64 y
    float64 z
    
    ================================================================================
    MSG: geometry_msgs/Vector3
    # This represents a vector in free space. 
    # It is only meant to represent a direction. Therefore, it does not
    # make sense to apply a translation to it (e.g., when applying a 
    # generic rigid transformation to a Vector3, tf2 will only apply the
    # rotation). If you want your data to be translatable too, use the
    # geometry_msgs/Point message instead.
    
    float64 x
    float64 y
    float64 z
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new NavStatus(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.position !== undefined) {
      resolved.position = Position.Resolve(msg.position)
    }
    else {
      resolved.position = new Position()
    }

    if (msg.orientation !== undefined) {
      resolved.orientation = Euler.Resolve(msg.orientation)
    }
    else {
      resolved.orientation = new Euler()
    }

    if (msg.quaternion !== undefined) {
      resolved.quaternion = Quaternion.Resolve(msg.quaternion)
    }
    else {
      resolved.quaternion = new Quaternion()
    }

    if (msg.ned_speed !== undefined) {
      resolved.ned_speed = geometry_msgs.msg.Vector3.Resolve(msg.ned_speed)
    }
    else {
      resolved.ned_speed = new geometry_msgs.msg.Vector3()
    }

    if (msg.omega_body !== undefined) {
      resolved.omega_body = geometry_msgs.msg.Vector3.Resolve(msg.omega_body)
    }
    else {
      resolved.omega_body = new geometry_msgs.msg.Vector3()
    }

    if (msg.gps_status !== undefined) {
      resolved.gps_status = msg.gps_status;
    }
    else {
      resolved.gps_status = 0
    }

    if (msg.initialized !== undefined) {
      resolved.initialized = msg.initialized;
    }
    else {
      resolved.initialized = false
    }

    return resolved;
    }
};

module.exports = NavStatus;
