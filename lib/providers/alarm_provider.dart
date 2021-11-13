import 'package:clock_test/helpers/helpers.dart';
import 'package:clock_test/models/alarm_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AlarmProvider extends ChangeNotifier {
  MethodChannel methodChannel = MethodChannel('co.moxielabs.dev/alarm');
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<AlarmData> _alarms = [
    /*AlarmData(id: "1", hours: 5, minutes: 20, repeats: false, enabled: true),
    AlarmData(id: "3", hours: 10, minutes: 45, repeats: true, enabled: false),
    AlarmData(id: "4", hours: 23, minutes: 34, repeats: false, enabled: false),
    AlarmData(id: "2", hours: 8, minutes: 30, repeats: true, enabled: true),
    AlarmData(id: "5", hours: 5, minutes: 10, repeats: false, enabled: true),*/
  ];

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
    this.notifyListeners();
  }

  deleteAlarm(String id) {
    for (var i = 0; i < _alarms.length; i++) {
      if (_alarms[i].id == id) {
        _alarms.removeAt(i);
        break;
      }
    }
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
    this.notifyListeners();
  }

  _updateAlarm(AlarmData alarm) async {
    String data = await methodChannel.invokeMethod("deleteAlarm", [alarm.id]);
    if (data == "Ok") {
      if (alarm.enabled) _storeAlarm(alarm);
    }
  }

  _storeAlarm(AlarmData alarm) async {
    return await methodChannel.invokeMethod(
        "startAlarm", [alarm.id, alarm.hours, alarm.minutes, alarm.repeats]);
  }
}
