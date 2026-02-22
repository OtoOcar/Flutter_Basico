import 'package:flutter/material.dart';

class AppTheme {

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212),
    primaryColor: Colors.teal,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Colors.white,
        fontFamily: 'Roboto',
      ),
    ),
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.grey[200],
    primaryColor: Colors.blue,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Colors.black,
        fontFamily: 'Roboto',
      ),
    ),
  );
}