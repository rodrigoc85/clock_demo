import 'dart:async';

import 'package:clock_test/helpers/helpers.dart';
import 'package:clock_test/models/alarm_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AlarmProvider extends ChangeNotifier {
  MethodChannel methodChannel = MethodChannel('co.moxielabs.dev/alarm');
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<AlarmData> _alarms = [];
  Timer? _nextAlarmTimeOut;
  StreamController<bool> controller = StreamController<bool>();

  @override
  void dispose() {
    super.dispose();
    controller.close();
  }

  List<AlarmData> get alarms {
    _alarms.sort((AlarmData a, AlarmData b) {
      if (a.hours != b.hours) {
        return a.hours.compareTo(b.hours);
      }
      return a.minutes.compareTo(b.minutes);
    });
    return _alarms;
  }

  ///
  /// This function cleans alarms settled in previous installations.
  /// It runs only once per install.
  ///
  cleanAlarmsOnFirstRun(BuildContext context) async {
    final SharedPreferences prefs = await _prefs;
    final bool cleaned = (prefs.getBool('cleaned') ?? false);
    if (!cleaned) {
      prefs.setBool('cleaned', true);
      String data = await methodChannel.invokeMethod("deleteAllAlarms", []);
      print("cleanAlarmsOnFirstRun: $data");
    } else {
      print("cleanAlarmsOnFirstRun: No Execution Needed");
    }
  }

  loadAlarms(BuildContext context, {bool update = false}) async {
    final SharedPreferences prefs = await _prefs;
    List<dynamic> rawAlarms = jsonDecode(prefs.getString("alarms") ?? "[]");
    _alarms = rawAlarms.map((e) => AlarmData.fromJson(e)).toList();
    _scheduleNextAlarmScreen();
    this.notifyListeners();
  }

  deleteAlarm(String id) async {
    for (var i = 0; i < _alarms.length; i++) {
      if (_alarms[i].id == id) {
        await methodChannel.invokeMethod("deleteAlarm", [id]);
        _alarms.removeAt(i);
        break;
      }
    }
    _scheduleNextAlarmScreen();
    this.notifyListeners();
  }

  saveAlarm(AlarmData alarm) async {
    final SharedPreferences prefs = await _prefs;
    AlarmData? prevAlarm = searchAlarmById(_alarms, alarm.id);
    if (prevAlarm != null) {
      prevAlarm.update(alarm);
      _updateAlarm(alarm);
    } else {
      _alarms.add(alarm);
      if (alarm.enabled) _storeAlarm(alarm);
    }
    prefs.setString("alarms", jsonEncode(_alarms));
    _scheduleNextAlarmScreen();
    this.notifyListeners();
  }

  _updateAlarm(AlarmData alarm) async {
    String data = await methodChannel.invokeMethod("deleteAlarm", [alarm.id]);
    if (data == "Ok") {
      if (alarm.enabled) _storeAlarm(alarm);
    }
  }

  _storeAlarm(AlarmData alarm) async {
    DateTime now = DateTime.now().toLocal();
    DateTime alarmTime = DateTime(
        now.year, now.month, now.day, alarm.hours, alarm.minutes, 0, 0, 0);
    return await methodChannel.invokeMethod("startAlarm", [
      alarm.id,
      alarm.hours,
      alarm.minutes,
      alarm.repeats,
      alarmTime.millisecondsSinceEpoch
    ]);
  }

  Stream get stream {
    return controller.stream;
  }

  _scheduleNextAlarmScreen() {
    if (_nextAlarmTimeOut != null) {
      _nextAlarmTimeOut!.cancel();
    }
    AlarmData? nextAlarm = _closestAlarm();
    if (nextAlarm == null) return;
    _nextAlarmTimeOut = Timer(alarmTimeToRun(nextAlarm), () {
      if (alarmTimeToRun(nextAlarm).inSeconds.abs() < 60) {
        _scheduleNextAlarmScreen();
        controller.add(true);
      }
    });
  }

  AlarmData? _closestAlarm() {
    AlarmData? closest;
    DateTime now = DateTime.now();
    for (var alarm in _alarms) {
      if (alarm.enabled && (alarmDateTime(alarm).isAfter(now))) {
        if (closest == null) {
          closest = alarm;
        } else if (alarmTimeToRun(alarm) < alarmTimeToRun(closest)) {
          closest = alarm;
        }
      }
    }
    return closest;
  }
}
