import 'package:flutter/services.dart';

class ZoomService {
  static const MethodChannel _channel = MethodChannel('zoom_sdk_channel');

  Future<void> initializeZoomSDK() async {
    try {
      await _channel.invokeMethod('initializeZoomSDK');
      print("Zoom SDK initialized");
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> joinMeeting(String meetingID, String meetingPasscode) async {
    try {
      await _channel.invokeMethod('joinMeeting', {
        "meetingID": meetingID,
        "meetingPasscode": meetingPasscode,
      });
      print("Joining meeting");
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> startMeeting(String meetingNumber) async {
    try {
      await _channel.invokeMethod('startMeeting', {
        "meetingNumber": meetingNumber,
      });
      print("Starting meeting");
    } catch (e) {
      print("Error: $e");
    }
  }
}
