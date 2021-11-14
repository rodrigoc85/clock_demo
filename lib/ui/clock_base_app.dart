import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClockBaseApp extends StatelessWidget {
  final Widget? child;

  const ClockBaseApp({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Alarm Demo',
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.dark,
        home: Platform.isIOS
            ? CupertinoApp(
                // Remove the debug banner
                theme: CupertinoThemeData(
                  brightness: Brightness.dark,
                ),
                localizationsDelegates: [
                  DefaultMaterialLocalizations.delegate,
                ],
                debugShowCheckedModeBanner: false,
                home: child,
              )
            : child);
  }
}
