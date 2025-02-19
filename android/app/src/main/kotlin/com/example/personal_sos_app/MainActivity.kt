package com.example.personal_sos_app

import android.os.Bundle
import android.content.Intent
import android.telephony.SmsManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    companion object {
        private const val CHANNEL_SMS = "sendSms"
        private const val CHANNEL_BG = "background_service"
    }

    private lateinit var callResult: MethodChannel.Result

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(flutterEngine!!)

        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL_SMS).setMethodCallHandler { call, result ->
            when (call.method) {
                "send" -> {
                    val phoneNumber: String? = call.argument("phone")
                    val message: String? = call.argument("msg")
                    if (phoneNumber != null && message != null) {
                        sendSMS(phoneNumber, message, result)
                    } else {
                        result.error("INVALID_ARGUMENTS", "Phone number or message is null", null)
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }

         MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL_BG).setMethodCallHandler { call, result ->
            if (call.method == "launchApp") {
                val intent = Intent(applicationContext, MainActivity::class.java)
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                applicationContext.startActivity(intent)
                result.success("App Launched")
            } else {
                result.notImplemented()
            }
        }
    }

    private fun sendSMS(phoneNo: String, msg: String, result: MethodChannel.Result) {
        try {
            val smsManager = SmsManager.getDefault()
            smsManager.sendTextMessage(phoneNo, null, msg, null, null)
            result.success("📩 SOS SMS sent successfully")
        } catch (ex: Exception) {
            ex.printStackTrace()
            result.error("ERROR", "SMS Not Sent", ex.localizedMessage)
        }
    }
}