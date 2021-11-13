import 'package:clock_test/helpers/helpers.dart';
import 'package:clock_test/models/alarm_data.dart';
import 'package:flutter/material.dart';

class AlarmProvider extends ChangeNotifier {
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

  cleanAlarmsOnFirstRun(BuildContext context) async {}

  loadAlarms(BuildContext context, {bool update = false}) async {}

  deleteAlarm(String id) {
    for (var i = 0; i < _alarms.length; i++) {
      if (_alarms[i].id == id) {
        _alarms.removeAt(i);
        break;
      }
    }
    this.notifyListeners();
  }

  saveAlarm(AlarmData alarm) {
    AlarmData? prevAlarm = searchAlarmById(_alarms, alarm.id);
    if (prevAlarm != null) {
      prevAlarm.update(alarm);
    } else {
      _alarms.add(alarm);
    }
    this.notifyListeners();
  }
}
