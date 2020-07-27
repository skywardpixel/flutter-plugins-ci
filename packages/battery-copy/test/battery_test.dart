// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:test/test.dart';
import 'package:battery/battery.dart';
import 'package:mockito/mockito.dart';

void main() {
  MockMethodChannel methodChannel;
  MockEventChannel eventChannel;
  Battery battery;

  setUp(() {
    methodChannel = MockMethodChannel();
    eventChannel = MockEventChannel();
    battery = Battery.private(methodChannel);
  });

  test('batteryLevel', () async {
    when(methodChannel.invokeMethod<int>('getBatteryLevel'))
        .thenAnswer((Invocation invoke) => Future<int>.value(42));
    expect(await battery.batteryLevel, 42);
  });

  group('battery state', () {
    StreamController<String> controller;

    setUp(() {
      controller = StreamController<String>();
      when(eventChannel.receiveBroadcastStream())
          .thenAnswer((Invocation invoke) => controller.stream);
    });

    tearDown(() {
      controller.close();
    });
  });
}

class MockMethodChannel extends Mock implements MethodChannel {}

class MockEventChannel extends Mock implements EventChannel {}
