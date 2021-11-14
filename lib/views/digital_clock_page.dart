import 'package:clock_test/ui/date_full_day.dart';
import 'package:clock_test/ui/digital_clock.dart';
import 'package:flutter/material.dart';

///
/// DigitalClockPage:
/// It is the first main view of the App. It contains the digital clock and
/// the date.
///

class DigitalClockPage extends StatelessWidget {
  const DigitalClockPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DigitalClock(),
          DateFullDay(),
        ],
      ),
    );
  }
}
