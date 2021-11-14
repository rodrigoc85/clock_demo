import 'package:clock_test/models/alarm_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:clock_test/helpers/helpers.dart';

class AlarmTimeField extends StatefulWidget {
  final AlarmData alarm;
  const AlarmTimeField({
    Key? key,
    required this.alarm,
  }) : super(key: key);

  @override
  _AlarmTimeFieldState createState() => _AlarmTimeFieldState();
}

class _AlarmTimeFieldState extends State<AlarmTimeField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Time"),
          ElevatedButton(
            onPressed: () {
              _selectTime(context);
            },
            child: Text(
              "${formatTimeDigit(widget.alarm.hours)}:${formatTimeDigit(widget.alarm.minutes)}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0x00000000)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(color: Colors.orangeAccent)))),
          )
        ],
      ),
    );
  }

  void _selectTime(BuildContext context) async {
    DateTime now = DateTime.now().toLocal();
    TimeOfDay _time = TimeOfDay.fromDateTime(DateTime(now.year, now.month,
        now.day, widget.alarm.hours, widget.alarm.minutes, 0, 0, 0));

    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _time,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        widget.alarm.hours = picked.hour;
        widget.alarm.minutes = picked.minute;
      });
    }
  }
}
