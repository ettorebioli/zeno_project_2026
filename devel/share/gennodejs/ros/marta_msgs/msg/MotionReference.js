// Auto-generated. Do not edit!

// (in-package marta_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let LatitudeLongitudeAltitude = require('./LatitudeLongitudeAltitude.js');
let LatitudeLongitudeDepth = require('./LatitudeLongitudeDepth.js');
let Quaternion = require('./Quaternion.js');
let RollPitchYaw = require('./RollPitchYaw.js');
let NorthEastDown = require('./NorthEastDown.js');
let SurgeSwayHeave = require('./SurgeSwayHeave.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class MotionReference {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.lla = null;
      this.lld = null;
      this.quaternion = null;
      this.rpy = null;
      this.rpy_dot = null;
      this.rpy_dot_dot = null;
      this.pn_wrt_home = null;
      this.pn_dot = null;
      this.pn_dot_dot = null;
      this.vb = null;
      this.vb_dot = null;
      this.wb = null;
      this.wb_dot = null;
      this.depth_unconstrained = null;
      this.final_reference = null;
      this.lla_final = null;
      this.rpy_final = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('lla')) {
        this.lla = initObj.lla
      }
      else {
        this.lla = new LatitudeLongitudeAltitude();
      }
      if (initObj.hasOwnProperty('lld')) {
        this.lld = initObj.lld
      }
      else {
        this.lld = new LatitudeLongitudeDepth();
      }
      if (initObj.hasOwnProperty('quaternion')) {
        this.quaternion = initObj.quaternion
      }
      else {
        this.quaternion = new Quaternion();
      }
      if (initObj.hasOwnProperty('rpy')) {
        this.rpy = initObj.rpy
      }
      else {
        this.rpy = new RollPitchYaw();
      }
      if (initObj.hasOwnProperty('rpy_dot')) {
        this.rpy_dot = initObj.rpy_dot
      }
      else {
        this.rpy_dot = new RollPitchYaw();
      }
      if (initObj.hasOwnProperty('rpy_dot_dot')) {
        this.rpy_dot_dot = initObj.rpy_dot_dot
      }
      else {
        this.rpy_dot_dot = new RollPitchYaw();
      }
      if (initObj.hasOwnProperty('pn_wrt_home')) {
        this.pn_wrt_home = initObj.pn_wrt_home
      }
      else {
        this.pn_wrt_home = new NorthEastDown();
      }
      if (initObj.hasOwnProperty('pn_dot')) {
        this.pn_dot = initObj.pn_dot
      }
      else {
        this.pn_dot = new NorthEastDown();
      }
      if (initObj.hasOwnProperty('pn_dot_dot')) {
        this.pn_dot_dot = initObj.pn_dot_dot
      }
      else {
        this.pn_dot_dot = new NorthEastDown();
      }
      if (initObj.hasOwnProperty('vb')) {
        this.vb = initObj.vb
      }
      else {
        this.vb = new SurgeSwayHeave();
      }
      if (initObj.hasOwnProperty('vb_dot')) {
        this.vb_dot = initObj.vb_dot
      }
      else {
        this.vb_dot = new SurgeSwayHeave();
      }
      if (initObj.hasOwnProperty('wb')) {
        this.wb = initObj.wb
      }
      else {
        this.wb = new SurgeSwayHeave();
      }
      if (initObj.hasOwnProperty('wb_dot')) {
        this.wb_dot = initObj.wb_dot
      }
      else {
        this.wb_dot = new SurgeSwayHeave();
      }
      if (initObj.hasOwnProperty('depth_unconstrained')) {
        this.depth_unconstrained = initObj.depth_unconstrained
      }
      else {
        this.depth_unconstrained = 0.0;
      }
      if (initObj.hasOwnProperty('final_reference')) {
        this.final_reference = initObj.final_reference
      }
      else {
        this.final_reference = false;
      }
      if (initObj.hasOwnProperty('lla_final')) {
        this.lla_final = initObj.lla_final
      }
      else {
        this.lla_final = new LatitudeLongitudeAltitude();
      }
      if (initObj.hasOwnProperty('rpy_final')) {
        this.rpy_final = initObj.rpy_final
      }
      else {
        this.rpy_final = new RollPitchYaw();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type MotionReference
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [lla]
    bufferOffset = LatitudeLongitudeAltitude.serialize(obj.lla, buffer, bufferOffset);
    // Serialize message field [lld]
    bufferOffset = LatitudeLongitudeDepth.serialize(obj.lld, buffer, bufferOffset);
    // Serialize message field [quaternion]
    bufferOffset = Quaternion.serialize(obj.quaternion, buffer, bufferOffset);
    // Serialize message field [rpy]
    bufferOffset = RollPitchYaw.serialize(obj.rpy, buffer, bufferOffset);
    // Serialize message field [rpy_dot]
    bufferOffset = RollPitchYaw.serialize(obj.rpy_dot, buffer, bufferOffset);
    // Serialize message field [rpy_dot_dot]
    bufferOffset = RollPitchYaw.serialize(obj.rpy_dot_dot, buffer, bufferOffset);
    // Serialize message field [pn_wrt_home]
    bufferOffset = NorthEastDown.serialize(obj.pn_wrt_home, buffer, bufferOffset);
    // Serialize message field [pn_dot]
    bufferOffset = NorthEastDown.serialize(obj.pn_dot, buffer, bufferOffset);
    // Serialize message field [pn_dot_dot]
    bufferOffset = NorthEastDown.serialize(obj.pn_dot_dot, buffer, bufferOffset);
    // Serialize message field [vb]
    bufferOffset = SurgeSwayHeave.serialize(obj.vb, buffer, bufferOffset);
    // Serialize message field [vb_dot]
    bufferOffset = SurgeSwayHeave.serialize(obj.vb_dot, buffer, bufferOffset);
    // Serialize message field [wb]
    bufferOffset = SurgeSwayHeave.serialize(obj.wb, buffer, bufferOffset);
    // Serialize message field [wb_dot]
    bufferOffset = SurgeSwayHeave.serialize(obj.wb_dot, buffer, bufferOffset);
    // Serialize message field [depth_unconstrained]
    bufferOffset = _serializer.float64(obj.depth_unconstrained, buffer, bufferOffset);
    // Serialize message field [final_reference]
    bufferOffset = _serializer.bool(obj.final_reference, buffer, bufferOffset);
    // Serialize message field [lla_final]
    bufferOffset = LatitudeLongitudeAltitude.serialize(obj.lla_final, buffer, bufferOffset);
    // Serialize message field [rpy_final]
    bufferOffset = RollPitchYaw.serialize(obj.rpy_final, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MotionReference
    let len;
    let data = new MotionReference(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [lla]
    data.lla = LatitudeLongitudeAltitude.deserialize(buffer, bufferOffset);
    // Deserialize message field [lld]
    data.lld = LatitudeLongitudeDepth.deserialize(buffer, bufferOffset);
    // Deserialize message field [quaternion]
    data.quaternion = Quaternion.deserialize(buffer, bufferOffset);
    // Deserialize message field [rpy]
    data.rpy = RollPitchYaw.deserialize(buffer, bufferOffset);
    // Deserialize message field [rpy_dot]
    data.rpy_dot = RollPitchYaw.deserialize(buffer, bufferOffset);
    // Deserialize message field [rpy_dot_dot]
    data.rpy_dot_dot = RollPitchYaw.deserialize(buffer, bufferOffset);
    // Deserialize message field [pn_wrt_home]
    data.pn_wrt_home = NorthEastDown.deserialize(buffer, bufferOffset);
    // Deserialize message field [pn_dot]
    data.pn_dot = NorthEastDown.deserialize(buffer, bufferOffset);
    // Deserialize message field [pn_dot_dot]
    data.pn_dot_dot = NorthEastDown.deserialize(buffer, bufferOffset);
    // Deserialize message field [vb]
    data.vb = SurgeSwayHeave.deserialize(buffer, bufferOffset);
    // Deserialize message field [vb_dot]
    data.vb_dot = SurgeSwayHeave.deserialize(buffer, bufferOffset);
    // Deserialize message field [wb]
    data.wb = SurgeSwayHeave.deserialize(buffer, bufferOffset);
    // Deserialize message field [wb_dot]
    data.wb_dot = SurgeSwayHeave.deserialize(buffer, bufferOffset);
    // Deserialize message field [depth_unconstrained]
    data.depth_unconstrained = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [final_reference]
    data.final_reference = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [lla_final]
    data.lla_final = LatitudeLongitudeAltitude.deserialize(buffer, bufferOffset);
    // Deserialize message field [rpy_final]
    data.rpy_final = RollPitchYaw.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 377;
  }

  static datatype() {
    // Returns string type for a message object
    return 'marta_msgs/MotionReference';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'f6865ee91600578e5e1d5b6edf162a80';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    LatitudeLongitudeAltitude lla
    
    LatitudeLongitudeDepth lld
    
    Quaternion quaternion
    
    RollPitchYaw rpy
    
    RollPitchYaw rpy_dot
    
    RollPitchYaw rpy_dot_dot
    
    NorthEastDown pn_wrt_home
    
    NorthEastDown pn_dot
    
    NorthEastDown pn_dot_dot
    
    SurgeSwayHeave vb
    
    SurgeSwayHeave vb_dot
    
    SurgeSwayHeave wb
    
    SurgeSwayHeave wb_dot
    
    float64 depth_unconstrained
    	
    bool final_reference
    
    LatitudeLongitudeAltitude lla_final
    
    RollPitchYaw rpy_final
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
    MSG: marta_msgs/LatitudeLongitudeAltitude
    float64 latitude
    float64 longitude
    float64 altitude
    
    ================================================================================
    MSG: marta_msgs/LatitudeLongitudeDepth
    float64 latitude
    float64 longitude
    float64 depth
    
    ================================================================================
    MSG: marta_msgs/Quaternion
    float64 w
    float64 x
    float64 y
    float64 z
    
    ================================================================================
    MSG: marta_msgs/RollPitchYaw
    float64 roll
    float64 pitch
    float64 yaw
    
    ================================================================================
    MSG: marta_msgs/NorthEastDown
    float64 north
    float64 east
    float64 down
    
    ================================================================================
    MSG: marta_msgs/SurgeSwayHeave
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
    const resolved = new MotionReference(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.lla !== undefined) {
      resolved.lla = LatitudeLongitudeAltitude.Resolve(msg.lla)
    }
    else {
      resolved.lla = new LatitudeLongitudeAltitude()
    }

    if (msg.lld !== undefined) {
      resolved.lld = LatitudeLongitudeDepth.Resolve(msg.lld)
    }
    else {
      resolved.lld = new LatitudeLongitudeDepth()
    }

    if (msg.quaternion !== undefined) {
      resolved.quaternion = Quaternion.Resolve(msg.quaternion)
    }
    else {
      resolved.quaternion = new Quaternion()
    }

    if (msg.rpy !== undefined) {
      resolved.rpy = RollPitchYaw.Resolve(msg.rpy)
    }
    else {
      resolved.rpy = new RollPitchYaw()
    }

    if (msg.rpy_dot !== undefined) {
      resolved.rpy_dot = RollPitchYaw.Resolve(msg.rpy_dot)
    }
    else {
      resolved.rpy_dot = new RollPitchYaw()
    }

    if (msg.rpy_dot_dot !== undefined) {
      resolved.rpy_dot_dot = RollPitchYaw.Resolve(msg.rpy_dot_dot)
    }
    else {
      resolved.rpy_dot_dot = new RollPitchYaw()
    }

    if (msg.pn_wrt_home !== undefined) {
      resolved.pn_wrt_home = NorthEastDown.Resolve(msg.pn_wrt_home)
    }
    else {
      resolved.pn_wrt_home = new NorthEastDown()
    }

    if (msg.pn_dot !== undefined) {
      resolved.pn_dot = NorthEastDown.Resolve(msg.pn_dot)
    }
    else {
      resolved.pn_dot = new NorthEastDown()
    }

    if (msg.pn_dot_dot !== undefined) {
      resolved.pn_dot_dot = NorthEastDown.Resolve(msg.pn_dot_dot)
    }
    else {
      resolved.pn_dot_dot = new NorthEastDown()
    }

    if (msg.vb !== undefined) {
      resolved.vb = SurgeSwayHeave.Resolve(msg.vb)
    }
    else {
      resolved.vb = new SurgeSwayHeave()
    }

    if (msg.vb_dot !== undefined) {
      resolved.vb_dot = SurgeSwayHeave.Resolve(msg.vb_dot)
    }
    else {
      resolved.vb_dot = new SurgeSwayHeave()
    }

    if (msg.wb !== undefined) {
      resolved.wb = SurgeSwayHeave.Resolve(msg.wb)
    }
    else {
      resolved.wb = new SurgeSwayHeave()
    }

    if (msg.wb_dot !== undefined) {
      resolved.wb_dot = SurgeSwayHeave.Resolve(msg.wb_dot)
    }
    else {
      resolved.wb_dot = new SurgeSwayHeave()
    }

    if (msg.depth_unconstrained !== undefined) {
      resolved.depth_unconstrained = msg.depth_unconstrained;
    }
    else {
      resolved.depth_unconstrained = 0.0
    }

    if (msg.final_reference !== undefined) {
      resolved.final_reference = msg.final_reference;
    }
    else {
      resolved.final_reference = false
    }

    if (msg.lla_final !== undefined) {
      resolved.lla_final = LatitudeLongitudeAltitude.Resolve(msg.lla_final)
    }
    else {
      resolved.lla_final = new LatitudeLongitudeAltitude()
    }

    if (msg.rpy_final !== undefined) {
      resolved.rpy_final = RollPitchYaw.Resolve(msg.rpy_final)
    }
    else {
      resolved.rpy_final = new RollPitchYaw()
    }

    return resolved;
    }
};

module.exports = MotionReference;
