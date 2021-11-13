import 'package:clock_test/ui/analog_clock/analog_clock.dart';
import 'package:flutter/material.dart';

class AnalogClockPage extends StatelessWidget {
  const AnalogClockPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.8,
            child: AnalogClock(),
          )
        ],
      ),
    );
  }
}
