// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
package io.kyleyan.battery

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
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

    override fun onAttachedToEngine(binding: FlutterPluginBinding) {
        onAttachedToEngine(binding.applicationContext, binding.binaryMessenger)
    }

    private fun onAttachedToEngine(applicationContext: Context, messenger: BinaryMessenger) {
        this.applicationContext = applicationContext
        methodChannel = MethodChannel(messenger, "io.kyleyan.example/battery")
        methodChannel!!.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPluginBinding) {
        applicationContext = null
        methodChannel!!.setMethodCallHandler(null)
        methodChannel = null
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (call.method == "getBatteryLevel") {
            val batteryLevel = batteryLevel
            if (batteryLevel != -1) {
                result.success(batteryLevel)
            } else {
                result.error("UNAVAILABLE", "Battery level not available.", null)
            }
        } else {
            result.notImplemented()
        }
    }

    private val batteryLevel: Int
        get() {
            var batteryLevel = -1
            batteryLevel = if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
                val batteryManager = applicationContext!!.getSystemService(Context.BATTERY_SERVICE) as BatteryManager
                batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
            } else {
                val intent = ContextWrapper(applicationContext)
                        .registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
                (intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100
                        / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1))
            }
            return batteryLevel
        }

    companion object {
        /** Plugin registration.  */
        fun registerWith(registrar: Registrar) {
            val instance = BatteryPlugin()
            instance.onAttachedToEngine(registrar.context(), registrar.messenger())
        }
    }
}