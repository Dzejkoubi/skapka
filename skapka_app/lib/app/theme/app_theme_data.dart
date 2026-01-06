import 'package:flutter/material.dart';

class AppThemeData {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    // Add other light theme properties here if needed
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    // Add other dark theme properties here if needed
  );
}
