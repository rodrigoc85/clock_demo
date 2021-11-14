import 'package:clock_test/models/alarm_data.dart';

///
/// Auxiliary functions
///

/// Returns the date and time of an alarm.
DateTime alarmDateTime(AlarmData a) {
  DateTime now = DateTime.now().toLocal();
  return DateTime(now.year, now.month, now.day, a.hours, a.minutes, 0, 0, 0);
}

/// Returns the distance in time between the present time and the alarm date.
Duration alarmTimeToRun(AlarmData a) {
  DateTime aTime = alarmDateTime(a);
  return aTime.difference(DateTime.now().toLocal());
}

/// Implements a simple alarm search by ID
AlarmData? searchAlarmById(List<AlarmData> alarms, String id) {
  for (var alarm in alarms) {
    if (alarm.id == id) return alarm;
  }
}

/// Formats a number to be displayed on the clock or in hour: minute format.
String formatTimeDigit(int val) {
  late String sHour;
  if (val < 10) {
    sHour = "0$val";
  } else {
    sHour = "$val";
  }
  return sHour;
}
