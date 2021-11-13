import 'package:clock_test/models/alarm_data.dart';
import 'package:clock_test/providers/alarm_provider.dart';
import 'package:clock_test/ui/alarm_repeat_field.dart';
import 'package:clock_test/ui/alarm_time_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

void openAlarmModal(BuildContext context, String title, AlarmData alarm) {
  /*AlarmData(
      id: "${DateTime.now().millisecondsSinceEpoch}",
      hours: DateTime.now().hour.toString(),
      minutes: DateTime.now().minute.toString(),
      repeats: false,
      enabled: true,
    ); */
  final alarmProvider = Provider.of<AlarmProvider>(context, listen: false);
  showCupertinoModalBottomSheet(
    barrierColor: Colors.black.withOpacity(0.5),
    context: context,
    builder: (context) => Material(
        child: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 14.0),
            child: Text(
              "Cancel",
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.orangeAccent,
                  fontSize: 15),
            ),
          ),
        ),
        middle: Text(
          title,
        ),
        trailing: GestureDetector(
          onTap: () {
            alarmProvider.saveAlarm(alarm);
            Navigator.pop(context);
          },
          child: Text(
            "Save",
            style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Colors.orangeAccent,
                fontSize: 15),
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 45),
          child: Container(
              height: MediaQuery.of(context).copyWith().size.height / 3,
              color: Colors.grey[800],
              child: Column(
                children: [
                  AlarmTimeField(alarm: alarm),
                  AlarmRepeatField(alarm: alarm),
                ],
              )),
        ),
      ),
    )),
  );
}