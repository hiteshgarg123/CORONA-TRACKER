import 'package:covid_19_tracker/data/datasource.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: primaryBlack,
    brightness: Brightness.dark,
    backgroundColor: const Color(0xFF212121),
    accentColor: Colors.white,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black12,
    fontFamily: 'Circular',
  );

  static final lightTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: primaryBlack,
    brightness: Brightness.light,
    backgroundColor: const Color(0xFFE5E5E5),
    accentColor: Colors.black,
    accentIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.white54,
    fontFamily: 'Circular',
  );
}
