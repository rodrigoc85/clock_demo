import 'dart:async';

import 'package:clock_test/ui/analog_clock/analog_clock_painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Based on package https://pub.dev/packages/analog_clock
///
class AnalogClock extends StatefulWidget {
  final Color handsColor;
  final Color secondHandColor;
  final Color tickColor;
  final double width;
  final double height;

  AnalogClock({
    Key? key,
    this.handsColor = Colors.orangeAccent, //Colors.white,
    this.tickColor = Colors.white60,
    this.secondHandColor = Colors.redAccent,
    this.width = double.infinity,
    this.height = double.infinity,
  }) : super(key: key);

  @override
  _AnalogClockState createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
  DateTime datetime = DateTime.now();

  @override
  initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), update);
  }

  update(Timer timer) {
    if (mounted) {
      datetime = DateTime.now();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
          border: Border.all(width: 2.0, color: Colors.white),
          color: Colors.transparent,
          shape: BoxShape.circle),
      child: Center(
          child: AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                  constraints:
                      const BoxConstraints(minWidth: 48.0, minHeight: 48.0),
                  width: double.infinity,
                  child: CustomPaint(
                    painter: AnalogClockPainter(
                        datetime: datetime,
                        hourHandColor: widget.handsColor,
                        minuteHandColor: widget.handsColor,
                        secondHandColor: widget.secondHandColor,
                        tickColor: widget.tickColor,
                        showDigitalClock: false,
                        numberColor: widget.handsColor),
                  )))),
    );
  }
}
