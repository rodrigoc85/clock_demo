import 'package:clock_test/models/alarm_data.dart';

DateTime alarmDateTime(AlarmData a) {
  DateTime now = DateTime.now().toLocal();
  return DateTime(now.year, now.month, now.day, a.hours, a.minutes, 0, 0, 0);
}

Duration alarmTimeToRun(AlarmData a) {
  DateTime aTime = alarmDateTime(a);
  return aTime.difference(DateTime.now().toLocal());
}

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
