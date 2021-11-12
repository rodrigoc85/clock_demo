import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Alarm Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: AlarmApp(),
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Alarm App"),
      ),
      body: Center(
        child: Column(
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_timeSet) Text(_time.toString().substring(10, 15)),
            ElevatedButton(
              onPressed: () {
                _selectTime(context);
              },
              child: Text("Select Time"),
            ),
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
