import 'dart:async';

import 'package:clock_test/alarm_app.dart';
import 'package:clock_test/providers/alarm_provider.dart';
import 'package:clock_test/ui/clock_base_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<AlarmProvider>(create: (_) => AlarmProvider())
      ],
      child: ClockBaseApp(
        child: AlarmApp(),
      )));
}
