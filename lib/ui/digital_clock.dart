import 'dart:async';
import 'package:flutter/material.dart';
import 'package:clock_test/helpers/helpers.dart';

///
/// DigitalClock:
/// Implements the digital clock Widget.
///
class DigitalClock extends StatefulWidget {
  DigitalClock({Key? key}) : super(key: key);

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  late Timer _timer;
  late int _hour;
  late int _minute;
  int tickIndex = 0;

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
    tickIndex++;
    return Container(
      height: 130,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            formatTimeDigit(_hour),
            style: const TextStyle(
                fontSize: 150,
                fontFamily: 'Digital-7',
                color: Colors.orangeAccent),
          ),
          SizedBox(
              width: 25,
              child: (tickIndex % 2 == 0)
                  ? null
                  : const Text(
                      ":",
                      style: TextStyle(
                          fontSize: 150,
                          fontFamily: 'Digital-7',
                          color: Colors.orangeAccent),
                    )),
          Text(
            formatTimeDigit(_minute),
            style: const TextStyle(
                fontSize: 150,
                fontFamily: 'Digital-7',
                color: Colors.orangeAccent),
          ),
        ],
      ),
    );
  }
}
