import 'package:clock_test/models/alarm_data.dart';
import 'package:clock_test/providers/alarm_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clock_test/helpers/helpers.dart';
import 'package:provider/provider.dart';

///
/// AlarmTile:
/// Displays an alarm in the alarm list. Shows the summary information and
/// allows to activate/deactivate it.
///
class AlarmTile extends StatefulWidget {
  final AlarmData alarm;

  const AlarmTile({Key? key, required this.alarm}) : super(key: key);

  @override
  _AlarmTileState createState() => _AlarmTileState();
}

class _AlarmTileState extends State<AlarmTile> {
  @override
  Widget build(BuildContext context) {
    final alarmProvider = Provider.of<AlarmProvider>(context, listen: false);
    return Column(
      children: [
        Container(
          padding:
              const EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 10),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${formatTimeDigit(widget.alarm.hours)}:${formatTimeDigit(widget.alarm.minutes)}",
                    style: TextStyle(
                        fontSize: 55,
                        fontWeight: FontWeight.w100,
                        color: widget.alarm.enabled
                            ? Colors.white
                            : Colors.white70),
                  ),
                  Text(widget.alarm.repeats ? "Every day" : "Today",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: widget.alarm.enabled
                              ? Colors.white
                              : Colors.white70)),
                ],
              ),
              CupertinoSwitch(
                  value: widget.alarm.enabled,
                  onChanged: (bool newVal) {
                    setState(() {
                      widget.alarm.enabled = newVal;
                    });
                    alarmProvider.saveAlarm(widget.alarm);
                  })
            ],
          ),
        ),
        Divider(
          color: Colors.grey[400],
          thickness: 0.2,
          height: 1,
        )
      ],
    );
  }
}
