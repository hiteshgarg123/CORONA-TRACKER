import 'package:covid_19_tracker/data/data.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData themeData(bool isDarkTheme) {
    return isDarkTheme ? darkTheme() : lightTheme();
  }

  static ThemeData lightTheme() {
    return ThemeData(
      primaryColor: primaryBlack,
      fontFamily: 'Circular',
      backgroundColor: Color(0xffF1F5FB),
      indicatorColor: Color(0xffCBDCF8),
      buttonColor: primaryBlack,
      highlightColor: Color(0xffFCE192),
      hoverColor: Color(0xff4285F4),
      disabledColor: Colors.grey,
      textSelectionColor: Colors.black,
      cardColor: Colors.white,
      canvasColor: Colors.grey[50],
      brightness: Brightness.light,
      textTheme: TextTheme(
        headline1: TextStyle(
          fontSize: 25,
          color: primaryBlack,
          fontWeight: FontWeight.bold,
        ),
        headline2: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        headline3: TextStyle(
          fontSize: 16,
          color: primaryBlack,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      primaryColor: primaryBlack,
      backgroundColor: primaryBlack,
      fontFamily: 'Circular',
      indicatorColor: Color(0xff0E1D36),
      buttonColor: Colors.white70,
      highlightColor: Color(0xff372901),
      hoverColor: Color(0xff3A3A3B),
      disabledColor: Colors.grey,
      textSelectionColor: Colors.white,
      cardColor: Color(0xFF151515),
      canvasColor: Colors.black,
      brightness: Brightness.dark,
      textTheme: TextTheme(
        headline1: TextStyle(
          fontSize: 25,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        headline2: TextStyle(
          fontSize: 20,
          color: primaryBlack,
          fontWeight: FontWeight.bold,
        ),
        headline3: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
