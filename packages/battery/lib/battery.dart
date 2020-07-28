// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart' show visibleForTesting;

enum BatteryState { full, charging, discharging }

/// A plugin for reading the current battery level.
class Battery {
  /// Returns a Battery instance.
  factory Battery() {
    if (_instance == null) {
      final MethodChannel methodChannel =
          const MethodChannel('example.kyleyan.io/battery');
      _instance = Battery.private(methodChannel);
    }
    return _instance;
  }

  @visibleForTesting
  Battery.private(this._methodChannel);

  static Battery _instance;

  final MethodChannel _methodChannel;

  /// The current battery level of the device.
  Future<int> get batteryLevel => _methodChannel
      .invokeMethod<int>('getBatteryLevel')
      .then<int>((dynamic result) => result);
}
