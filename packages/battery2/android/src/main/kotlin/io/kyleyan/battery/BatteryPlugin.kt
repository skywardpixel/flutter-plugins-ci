// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
package io.kyleyan.battery

import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.PluginRegistry.Registrar

/** BatteryPlugin  */
class BatteryPlugin : MethodCallHandler, FlutterPlugin {

    private var applicationContext: Context? = null
    private var methodChannel: MethodChannel? = null
    var batteryLevel: BatteryLevel? = null

    override fun onAttachedToEngine(binding: FlutterPluginBinding) {
        onAttachedToEngine(binding.applicationContext, binding.binaryMessenger)
    }

    private fun onAttachedToEngine(applicationContext: Context, messenger: BinaryMessenger) {
        this.applicationContext = applicationContext
        batteryLevel = BatteryLevel(applicationContext)
        methodChannel = MethodChannel(messenger, "example.kyleyan.io/battery")
        methodChannel!!.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPluginBinding) {
        applicationContext = null
        methodChannel!!.setMethodCallHandler(null)
        methodChannel = null
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (call.method == "getBatteryLevel") {
            val batteryLevel = batteryLevel!!.batteryLevel
            if (batteryLevel != -1) {
                result.success(batteryLevel)
            } else {
                result.error("UNAVAILABLE", "Battery level not available.", null)
            }
        } else {
            result.notImplemented()
        }
    }

    companion object {
        /** Plugin registration.  */
        fun registerWith(registrar: Registrar) {
            val instance = BatteryPlugin()
            instance.onAttachedToEngine(registrar.context(), registrar.messenger())
        }
    }
}