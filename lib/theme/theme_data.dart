import 'package:flutter/material.dart';

class AppTheme {
  static const Color appScaffoldBackground = Color(0xFF2B286D);
  static const Color fontColor = Color(0xFFFFFFFE);

  static ThemeData getThemeData(BuildContext context) {
    return ThemeData(
        scaffoldBackgroundColor: appScaffoldBackground,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: fontColor,
              displayColor: fontColor,
            ),
        canvasColor: appScaffoldBackground,
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(color: fontColor, fontSize: 24),
            backgroundColor: appScaffoldBackground,
            elevation: 0));
  }
}
