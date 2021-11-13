import 'dart:async';
import 'package:flutter/material.dart';
import 'package:clock_test/helpers/helpers.dart';

class DigitalClock extends StatefulWidget {
  DigitalClock({Key? key}) : super(key: key);

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  late Timer _timer;
  late int _hour;
  late int _minute;

  @override
  void initState() {
    super.initState();
    DateTime dateTime = DateTime.now();
    _hour = dateTime.hour;
    _minute = dateTime.minute;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      DateTime dateTime = DateTime.now();
      _hour = dateTime.hour;
      _minute = dateTime.minute;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            "${formatTimeDigit(_hour)}:${formatTimeDigit(_minute)}",
            style: TextStyle(fontSize: 150, fontFamily: 'Digital-7'),
          ),
        ],
      ),
    );
  }
}
