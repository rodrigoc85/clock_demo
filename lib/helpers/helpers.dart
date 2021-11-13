import 'package:clock_test/models/alarm_data.dart';

AlarmData? searchAlarmById(List<AlarmData> alarms, String id) {
  for (var alarm in alarms) {
    if (alarm.id == id) return alarm;
  }
}

String formatTimeDigit(int val) {
  late String sHour;
  if (val < 10) {
    sHour = "0$val";
  } else {
    sHour = "$val";
  }
  return sHour;
}
