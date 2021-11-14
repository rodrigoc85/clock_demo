import 'package:clock_test/ui/analog_clock/analog_clock.dart';
import 'package:clock_test/ui/date_full_day.dart';
import 'package:flutter/material.dart';

///
/// AnalogClockPage:
/// It is the second main view of the App. It contains the analog clock and
/// the date.
///
class AnalogClockPage extends StatelessWidget {
  const AnalogClockPage({
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
          Container(
            height: MediaQuery.of(context).size.height * 0.55,
            width: MediaQuery.of(context).size.width * 0.8,
            child: AnalogClock(),
          ),
          DateFullDay(),
        ],
      ),
    );
  }
}
