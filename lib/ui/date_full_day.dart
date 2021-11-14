import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

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
