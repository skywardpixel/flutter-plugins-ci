package io.kyleyan.battery

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build

class BatteryLevel(private val applicationContext: Context) {

     val batteryLevel: Int
        get() {
            val batteryLevel: Int
            batteryLevel = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                val batteryManager = applicationContext.getSystemService(Context.BATTERY_SERVICE) as BatteryManager
                batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
            } else {
                val intent = ContextWrapper(applicationContext)
                        .registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
                (intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100
                        / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1))
            }
            return batteryLevel
        }

}