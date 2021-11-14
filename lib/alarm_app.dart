import 'package:clock_test/models/alarm_data.dart';
import 'package:clock_test/ui/alarm_modal.dart';
import 'package:clock_test/ui/clock_scaffold.dart';
import 'package:clock_test/views/alarm_page.dart';
import 'package:clock_test/views/analog_clock_page.dart';
import 'package:clock_test/views/digital_clock_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AlarmApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClockScaffold(
      mainTitle: "Clock App",
      pages: [
        TabContent(
            icon: Icons.access_time_filled_rounded,
            title: "Digital clock",
            page: DigitalClockPage()),
        TabContent(
            icon: Icons.av_timer,
            title: "Analog clock",
            page: AnalogClockPage()),
        TabContent(
            icon: Icons.alarm,
            title: "Alarms",
            page: AlarmPage(),
            action: ActionItem(
              icon: Icons.add,
              onTap: () {
                openAlarmModal(
                    context,
                    "Add alarm",
                    AlarmData(
                      id: "${DateTime.now().millisecondsSinceEpoch}",
                      hours: DateTime.now().hour,
                      minutes: DateTime.now().minute,
                      repeats: false,
                      enabled: true,
                    ));
                //_selectTime(context);
              },
            )),
      ],
    );
  }
}
