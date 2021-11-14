import 'package:clock_test/models/alarm_data.dart';
import 'package:clock_test/providers/alarm_provider.dart';
import 'package:clock_test/ui/alarm_modal.dart';
import 'package:clock_test/ui/alarm_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

///
/// AlarmPage:
/// It is the third main view of the App. Contains the alarm page structure.
/// It lists them and allows the user to manage them.
///
class AlarmPage extends StatefulWidget {
  AlarmPage({Key? key}) : super(key: key);

  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final alarmProvider = Provider.of<AlarmProvider>(context, listen: true);

    return Material(
      color: Colors.black,
      child: (alarmProvider.alarms.length == 0)
          ? _emptyListContent()
          : _listAlarms(alarmProvider),
    );
  }

  Widget _emptyListContent() {
    return const Center(
      child: Text(
        "There are no alarms configured",
        style: TextStyle(fontWeight: FontWeight.w300, color: Colors.white70),
      ),
    );
  }

  Widget _listAlarms(alarmProvider) {
    return ListView.builder(
      itemCount: alarmProvider.alarms.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Swipe right for more options",
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        fontWeight: FontWeight.w300)),
              ),
              Divider(
                color: Colors.grey[400],
                thickness: 0.2,
                height: 1,
              )
            ],
          );
        }
        return _slidableItem(index, alarmProvider);
      },
    );
  }

  Widget _slidableItem(int index, alarmProvider) {
    List<AlarmData> alarms = alarmProvider.alarms;
    return Slidable(
        key: ValueKey(index),
        startActionPane: ActionPane(
          motion: const BehindMotion(),
          children: [
            SlidableAction(
              onPressed: (BuildContext context) {
                alarmProvider.deleteAlarm(alarms[index - 1].id);
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: (BuildContext context) {
                openAlarmModal(context, "New alarm", alarms[index - 1].copy());
              },
              backgroundColor: Colors.orangeAccent,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
        child: AlarmTile(
          alarm: alarms[index - 1],
        ));
  }
}
