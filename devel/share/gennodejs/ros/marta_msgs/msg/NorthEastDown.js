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

class NorthEastDown {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.north = null;
      this.east = null;
      this.down = null;
    }
    else {
      if (initObj.hasOwnProperty('north')) {
        this.north = initObj.north
      }
      else {
        this.north = 0.0;
      }
      if (initObj.hasOwnProperty('east')) {
        this.east = initObj.east
      }
      else {
        this.east = 0.0;
      }
      if (initObj.hasOwnProperty('down')) {
        this.down = initObj.down
      }
      else {
        this.down = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type NorthEastDown
    // Serialize message field [north]
    bufferOffset = _serializer.float64(obj.north, buffer, bufferOffset);
    // Serialize message field [east]
    bufferOffset = _serializer.float64(obj.east, buffer, bufferOffset);
    // Serialize message field [down]
    bufferOffset = _serializer.float64(obj.down, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type NorthEastDown
    let len;
    let data = new NorthEastDown(null);
    // Deserialize message field [north]
    data.north = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [east]
    data.east = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [down]
    data.down = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 24;
  }

  static datatype() {
    // Returns string type for a message object
    return 'marta_msgs/NorthEastDown';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '81fca827a727a73c11e9d24a75a9174f';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float64 north
    float64 east
    float64 down
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new NorthEastDown(null);
    if (msg.north !== undefined) {
      resolved.north = msg.north;
    }
    else {
      resolved.north = 0.0
    }

    if (msg.east !== undefined) {
      resolved.east = msg.east;
    }
    else {
      resolved.east = 0.0
    }

    if (msg.down !== undefined) {
      resolved.down = msg.down;
    }
    else {
      resolved.down = 0.0
    }

    return resolved;
    }
};

module.exports = NorthEastDown;
