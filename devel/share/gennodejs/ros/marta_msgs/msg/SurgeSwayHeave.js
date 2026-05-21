// Auto-generated. Do not edit!

// (in-package marta_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class SurgeSwayHeave {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.surge = null;
      this.sway = null;
      this.heave = null;
    }
    else {
      if (initObj.hasOwnProperty('surge')) {
        this.surge = initObj.surge
      }
      else {
        this.surge = 0.0;
      }
      if (initObj.hasOwnProperty('sway')) {
        this.sway = initObj.sway
      }
      else {
        this.sway = 0.0;
      }
      if (initObj.hasOwnProperty('heave')) {
        this.heave = initObj.heave
      }
      else {
        this.heave = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SurgeSwayHeave
    // Serialize message field [surge]
    bufferOffset = _serializer.float64(obj.surge, buffer, bufferOffset);
    // Serialize message field [sway]
    bufferOffset = _serializer.float64(obj.sway, buffer, bufferOffset);
    // Serialize message field [heave]
    bufferOffset = _serializer.float64(obj.heave, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SurgeSwayHeave
    let len;
    let data = new SurgeSwayHeave(null);
    // Deserialize message field [surge]
    data.surge = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [sway]
    data.sway = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [heave]
    data.heave = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 24;
  }

  static datatype() {
    // Returns string type for a message object
    return 'marta_msgs/SurgeSwayHeave';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '37a93273a4b90846c44a065401ed273f';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float64 surge
    float64 sway
    float64 heave
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SurgeSwayHeave(null);
    if (msg.surge !== undefined) {
      resolved.surge = msg.surge;
    }
    else {
      resolved.surge = 0.0
    }

    if (msg.sway !== undefined) {
      resolved.sway = msg.sway;
    }
    else {
      resolved.sway = 0.0
    }

    if (msg.heave !== undefined) {
      resolved.heave = msg.heave;
    }
    else {
      resolved.heave = 0.0
    }

    return resolved;
    }
};

module.exports = SurgeSwayHeave;
