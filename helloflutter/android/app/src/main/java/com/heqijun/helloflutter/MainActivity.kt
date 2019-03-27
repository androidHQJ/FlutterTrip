// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
package com.heqijun.helloflutter
import android.content.BroadcastReceiver
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.EventChannel.StreamHandler
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {

    private val batteryLevel: Int
        get() {
            return if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
                val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
                batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
            } else {
                val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
                intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
            }
        }

    public override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        //Flutter App调用Native APIs
        MethodChannel(flutterView, BATTERY_CHANNEL).setMethodCallHandler { call, result ->
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

        //Native调用Flutter App
        EventChannel(flutterView, CHARGING_CHANNEL).setStreamHandler(
                object : StreamHandler {
                    private var chargingStateChangeReceiver: BroadcastReceiver? = null

                    override fun onListen(arguments: Any?, events: EventSink) {
                        chargingStateChangeReceiver = createChargingStateChangeReceiver(events)
                        registerReceiver(
                                chargingStateChangeReceiver, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
                    }
                    override fun onCancel(arguments: Any) {
                        unregisterReceiver(chargingStateChangeReceiver)
                        chargingStateChangeReceiver = null
                    }
                }
        )

        //Plugin 注册
        GeneratedPluginRegistrant.registerWith(this)


    }

    private fun createChargingStateChangeReceiver(events: EventSink): BroadcastReceiver {
        return object : BroadcastReceiver() {
            override fun onReceive(context: Context, intent: Intent) {
                val status = intent.getIntExtra(BatteryManager.EXTRA_STATUS, -1)

                if (status == BatteryManager.BATTERY_STATUS_UNKNOWN) {
                    events.error("UNAVAILABLE", "Charging status unavailable", null)
                } else {
                    val isCharging = status == BatteryManager.BATTERY_STATUS_CHARGING || status == BatteryManager.BATTERY_STATUS_FULL
                    events.success(if (isCharging) "charging" else "discharging")
                }
            }
        }
    }

    companion object {
        private val BATTERY_CHANNEL = "samples.flutter.io/battery"
        private val CHARGING_CHANNEL = "samples.flutter.io/charging"
    }
}
