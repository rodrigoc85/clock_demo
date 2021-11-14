package com.example.clock_test

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.Calendar

import android.content.Context
import android.app.AlarmManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Intent
import android.os.SystemClock

class MainActivity: FlutterActivity() {
    private val CHANNEL = "co.moxielabs.dev/alarm"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->

            if (call.method == "startAlarm") {
                val time = (call.arguments) as List<Any>
                val id = time[0] as String
                val hour = time[1] as Int
                val minute = time[2] as Int
                val repeatAlarm  = time[3] as Boolean
                val miliseconds = time[4] as Long
                setAlarm(id, miliseconds, repeatAlarm)
                result.success("Ok");
            } else if (call.method == "deleteAlarm") {
                val time = (call.arguments) as List<Any>
                val id = time[0] as String
                deleteAlarm(id);
                result.success("Ok");
            } else if (call.method == "deleteAllAlarms") {
                //@TODO: Cancell all alarms
                result.success("Ok");
            } else {
                result.notImplemented()
            }
        }
    }

    private fun setAlarm(id: String, miliseconds: Long, repeatAlarm: Boolean) {
        //@TODO: Repeatable alarms
        val alarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager
        val intent = Intent(this, alarm_service::class.java)
        intent.setAction(id)
        val pendingIntent: PendingIntent = PendingIntent.getBroadcast(this, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT)

        alarmManager.setExact(AlarmManager.RTC_WAKEUP, miliseconds, pendingIntent)
    }

    private fun deleteAlarm(id: String) {
        val alarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager
        val intent = Intent(this, alarm_service::class.java)
        intent.setAction(id)
        val pendingIntent: PendingIntent = PendingIntent.getBroadcast(this, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT)//FLAG_NO_CREATE)
        if (pendingIntent != null) {
            alarmManager.cancel(pendingIntent)
        }
    }
}
                