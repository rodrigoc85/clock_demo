import 'package:clock_test/models/alarm_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlarmRepeatField extends StatefulWidget {
  final AlarmData alarm;
  const AlarmRepeatField({
    Key? key,
    required this.alarm,
  }) : super(key: key);

  @override
  _AlarmRepeatFieldState createState() => _AlarmRepeatFieldState();
}

class _AlarmRepeatFieldState extends State<AlarmRepeatField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Repeats every day"),
          CupertinoSwitch(
              value: widget.alarm.repeats,
              onChanged: (bool newVal) {
                setState(() {
                  widget.alarm.repeats = newVal;
                });
              })
        ],
      ),
    );
  }
}
