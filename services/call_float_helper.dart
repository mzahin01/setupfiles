import 'package:flutter/services.dart';

const _channelName = 'call-float-channel';

class CallFloatHelper {
  static const MethodChannel _channel = MethodChannel(_channelName);

  static Future<void> enable() async {
    await _channel.invokeMethod('enable');
  }

  static Future<void> disable() async {
    await _channel.invokeMethod('disable');
  }
}
