import 'package:flutter/material.dart';

class AppTheme {

  // Tema oscuro
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212), // Fondo muy oscuro
    primaryColor: Colors.teal,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Colors.white,
        fontFamily: 'Roboto',
      ),
    ),
  );

  // Tema claro
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.grey[200],  // Fondo gris suave
    primaryColor: Colors.blue,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Colors.black,
        fontFamily: 'Roboto',
      ),
    ),
  );
}