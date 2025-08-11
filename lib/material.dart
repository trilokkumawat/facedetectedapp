import 'package:flutter/material.dart';

const MaterialColor blackSwatch = MaterialColor(0xFF000000, <int, Color>{
  50: Color(0xFF000000),
  100: Color(0xFF000000),
  200: Color(0xFF000000),
  300: Color(0xFF000000),
  400: Color(0xFF000000),
  500: Color(0xFF000000),
  600: Color(0xFF000000),
  700: Color(0xFF000000),
  800: Color(0xFF000000),
  900: Color(0xFF000000),
});
const TextTheme appTextTheme = TextTheme(
  displayLarge: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
  displayMedium: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  ),
  headlineSmall: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  ),
  bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
  bodyMedium: TextStyle(fontSize: 14, color: Colors.white),
  labelSmall: TextStyle(fontSize: 12, color: Colors.grey),
);
