import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

///
/// DateFullDay:
/// Simple widget that displays the date in a unified format.
///
class DateFullDay extends StatelessWidget {
  const DateFullDay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormat('yyyy / MMM / dd').format(DateTime.now()),
      style: const TextStyle(fontSize: 20),
    );
  }
}
