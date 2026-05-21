// Auto-generated. Do not edit!

// (in-package joystick_command.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class Rel_error_joystick {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.error_roll = null;
      this.error_pitch = null;
      this.error_yaw = null;
      this.error_distance = null;
      this.error_depth = null;
      this.error_surge_speed = null;
      this.error_sway_speed = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('error_roll')) {
        this.error_roll = initObj.error_roll
      }
      else {
        this.error_roll = 0.0;
      }
      if (initObj.hasOwnProperty('error_pitch')) {
        this.error_pitch = initObj.error_pitch
      }
      else {
        this.error_pitch = 0.0;
      }
      if (initObj.hasOwnProperty('error_yaw')) {
        this.error_yaw = initObj.error_yaw
      }
      else {
        this.error_yaw = 0.0;
      }
      if (initObj.hasOwnProperty('error_distance')) {
        this.error_distance = initObj.error_distance
      }
      else {
        this.error_distance = 0.0;
      }
      if (initObj.hasOwnProperty('error_depth')) {
        this.error_depth = initObj.error_depth
      }
      else {
        this.error_depth = 0.0;
      }
      if (initObj.hasOwnProperty('error_surge_speed')) {
        this.error_surge_speed = initObj.error_surge_speed
      }
      else {
        this.error_surge_speed = 0.0;
      }
      if (initObj.hasOwnProperty('error_sway_speed')) {
        this.error_sway_speed = initObj.error_sway_speed
      }
      else {
        this.error_sway_speed = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Rel_error_joystick
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [error_roll]
    bufferOffset = _serializer.float64(obj.error_roll, buffer, bufferOffset);
    // Serialize message field [error_pitch]
    bufferOffset = _serializer.float64(obj.error_pitch, buffer, bufferOffset);
    // Serialize message field [error_yaw]
    bufferOffset = _serializer.float64(obj.error_yaw, buffer, bufferOffset);
    // Serialize message field [error_distance]
    bufferOffset = _serializer.float64(obj.error_distance, buffer, bufferOffset);
    // Serialize message field [error_depth]
    bufferOffset = _serializer.float64(obj.error_depth, buffer, bufferOffset);
    // Serialize message field [error_surge_speed]
    bufferOffset = _serializer.float64(obj.error_surge_speed, buffer, bufferOffset);
    // Serialize message field [error_sway_speed]
    bufferOffset = _serializer.float64(obj.error_sway_speed, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Rel_error_joystick
    let len;
    let data = new Rel_error_joystick(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [error_roll]
    data.error_roll = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [error_pitch]
    data.error_pitch = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [error_yaw]
    data.error_yaw = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [error_distance]
    data.error_distance = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [error_depth]
    data.error_depth = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [error_surge_speed]
    data.error_surge_speed = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [error_sway_speed]
    data.error_sway_speed = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 56;
  }

  static datatype() {
    // Returns string type for a message object
    return 'joystick_command/Rel_error_joystick';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'eb21a06c4e8dda99b50b5307a898900c';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float64 error_roll          # Roll relative error   [deg]
    float64 error_pitch         # Pitch relative error  [deg]
    float64 error_yaw           # Yaw relative error    [deg]
    
    float64 error_distance      # Frontal distance relative error   [m]
    float64 error_depth         # Depth relative error              [m]
    
    float64 error_surge_speed   # Desired absolute surge speed (x axis) [m/s]
    float64 error_sway_speed    # Desired absolute sway speed (y axis)  [m/s]
    
    #                #     SURGE SPEED    #     SWAY SPEED    #     YAW RATE     #    DEPTH RATE    #     PITCH RATE     #
    # ------------------------------------------------------------------------------------------------------------------ #
    #    MAX VALUES  #      0.25 m/s      #      0.25 m/s     #     10 deg/s     #    0.125 m/s     #      5.0 deg/s     #
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Rel_error_joystick(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.error_roll !== undefined) {
      resolved.error_roll = msg.error_roll;
    }
    else {
      resolved.error_roll = 0.0
    }

    if (msg.error_pitch !== undefined) {
      resolved.error_pitch = msg.error_pitch;
    }
    else {
      resolved.error_pitch = 0.0
    }

    if (msg.error_yaw !== undefined) {
      resolved.error_yaw = msg.error_yaw;
    }
    else {
      resolved.error_yaw = 0.0
    }

    if (msg.error_distance !== undefined) {
      resolved.error_distance = msg.error_distance;
    }
    else {
      resolved.error_distance = 0.0
    }

    if (msg.error_depth !== undefined) {
      resolved.error_depth = msg.error_depth;
    }
    else {
      resolved.error_depth = 0.0
    }

    if (msg.error_surge_speed !== undefined) {
      resolved.error_surge_speed = msg.error_surge_speed;
    }
    else {
      resolved.error_surge_speed = 0.0
    }

    if (msg.error_sway_speed !== undefined) {
      resolved.error_sway_speed = msg.error_sway_speed;
    }
    else {
      resolved.error_sway_speed = 0.0
    }

    return resolved;
    }
};

module.exports = Rel_error_joystick;
