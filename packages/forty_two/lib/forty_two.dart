import 'dart:async';

import 'package:flutter/services.dart';

class FortyTwo {
  static const MethodChannel _channel =
      const MethodChannel('forty_two');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
