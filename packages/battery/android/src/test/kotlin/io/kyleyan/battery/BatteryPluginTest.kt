package io.kyleyan.battery

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.Result
import org.junit.Test
import org.mockito.Mockito.*

class BatteryPluginTest {
    @Test
    fun onMethodCall_successOnGetBatteryLevel() {
        val batteryPlugin = BatteryPlugin()
        val batteryLevel = mock(BatteryLevel::class.java)
        `when`(batteryLevel.batteryLevel).thenReturn(42)
        val args: Map<String, Any> = HashMap()
        val result: Result = mock(Result::class.java)
        batteryPlugin.batteryLevel = batteryLevel
        batteryPlugin.onMethodCall(MethodCall("getBatteryLevel", args), result)
        verify(result).success(43)
    }
}