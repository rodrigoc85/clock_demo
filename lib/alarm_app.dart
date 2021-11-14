import 'dart:async';

import 'package:clock_test/models/alarm_data.dart';
import 'package:clock_test/providers/alarm_provider.dart';
import 'package:clock_test/ui/alarm_modal.dart';
import 'package:clock_test/ui/clock_scaffold.dart';
import 'package:clock_test/views/alarm_page.dart';
import 'package:clock_test/views/analog_clock_page.dart';
import 'package:clock_test/views/digital_clock_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

///
/// AlarmApp:
/// Defines the base structure of the App and the content and behavior of each tab.
/// It also listens to the stream of alarms and raises a dialogue when the time
/// for any of them arrives.
///
class AlarmApp extends StatefulWidget {
  @override
  _AlarmAppState createState() => _AlarmAppState();
}

class _AlarmAppState extends State<AlarmApp> {
  late StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
    final alarmProvider = Provider.of<AlarmProvider>(context, listen: false);
    alarmProvider.cleanAlarmsOnFirstRun(context);
    alarmProvider.loadAlarms(context);
    subscription = alarmProvider.stream.listen((event) async {
      FlutterRingtonePlayer.play(
        android: AndroidSounds.notification,
        ios: const IosSound(1023),
        looping: true,
        volume: 0.1,
      );
      await showDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text('Alarm'),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Close')),
              ],
            );
          });
      FlutterRingtonePlayer.stop();
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

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
