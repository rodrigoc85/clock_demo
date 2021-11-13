import 'package:clock_test/ui/digital_clock.dart';
import 'package:flutter/material.dart';

class DigitalClockPage extends StatelessWidget {
  const DigitalClockPage({
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
          DigitalClock(),
        ],
      ),
    );
  }
}
