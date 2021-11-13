import 'package:clock_test/models/alarm_data.dart';
import 'package:clock_test/providers/alarm_provider.dart';
import 'package:clock_test/ui/alarm_modal.dart';
import 'package:clock_test/views/alarm_page.dart';
import 'package:clock_test/views/analog_clock_page.dart';
import 'package:clock_test/views/digital_clock_page.dart';
import 'package:clock_test/ui/clock_base_app.dart';
import 'package:clock_test/ui/clock_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<AlarmProvider>(create: (_) => AlarmProvider())
      ],
      child: ClockBaseApp(
        child: AlarmApp(),
      )));
}

class AlarmApp extends StatefulWidget {
  @override
  _AlarmAppState createState() => _AlarmAppState();
}

class _AlarmAppState extends State<AlarmApp> {
  /*int _hour = 0;
  int _minute = 0;*/

  var timeInMillies;

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

  /*_setupAlarm(BuildContext context) async {
    String data = await AlarmApp.methodChannel
        .invokeMethod("startAlarm", ["idalarma", _hour, _minute, false]);
    debugPrint(data);
    showToast(context, data);
  }

  _deleteAlarm(BuildContext context) async {
    String data = await AlarmApp.methodChannel.invokeMethod("deleteAlarm");
    debugPrint(data);
    showToast(context, data);
  }

  void showToast(BuildContext context, String data) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(data),
    ));
  }*/
}
