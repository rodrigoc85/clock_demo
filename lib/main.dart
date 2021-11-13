import 'package:clock_test/views/analog_clock_page.dart';
import 'package:clock_test/views/digital_clock_page.dart';
import 'package:clock_test/ui/clock_base_app.dart';
import 'package:clock_test/ui/clock_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ClockBaseApp(
    child: AlarmApp(),
  ));
}

class AlarmApp extends StatefulWidget {
  static const MethodChannel methodChannel =
      MethodChannel('co.moxielabs.dev/alarm');

  @override
  _AlarmAppState createState() => _AlarmAppState();
}

class _AlarmAppState extends State<AlarmApp> {
  bool _timeSet = false;

  TimeOfDay _time = TimeOfDay.now();
  var _day = DateTime.now().day;
  var _month = DateTime.now().month;
  var _year = DateTime.now().year;
  int _hour = 0;
  int _minute = 0;

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
            page: _alarmPage(context),
            action: ActionItem(
              icon: Icons.add,
              onTap: () {
                _selectTime(context);
              },
            )),
      ],
    );
  }

  Widget _alarmPage(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (_timeSet) Text(_time.toString().substring(10, 15)),
          if (_timeSet)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _timeSet = false;
                });
                _deleteAlarm(context);
              },
              child: Text(
                  "Delete Alarm for ${_time.toString().substring(10, 15)}"),
            ),
        ],
      ),
    );
  }

  void _selectTime(BuildContext context) async {
    TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: _time);

    if (picked != null && picked != _time) {
      print("Time Current: ${_time.toString().substring(10, 15)}");
      setState(() {
        _time = picked;
        _timeSet = true;
        _hour = int.parse(_time.toString().substring(10, 12));
        _minute = int.parse(_time.toString().substring(13, 15));
        timeInMillies = DateTime(_year, _month, _day, _hour, _minute)
            .millisecondsSinceEpoch;
        print(timeInMillies);
        _setupAlarm(context);
      });
    }
  }

  _setupAlarm(BuildContext context) async {
    String data = await AlarmApp.methodChannel
        .invokeMethod("startAlarm", [timeInMillies, _hour, _minute]);
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
  }
}
