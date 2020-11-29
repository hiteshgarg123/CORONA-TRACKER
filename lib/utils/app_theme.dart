import 'package:covid_19_tracker/data/data.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      primaryColor: primaryBlack,
      accentColor: primaryBlack,
      fontFamily: 'Circular',
      backgroundColor: Color(0xffF1F5FB),
      indicatorColor: Color(0xffCBDCF8),
      buttonColor: primaryBlack,
      highlightColor: Color(0xffFCE192),
      disabledColor: Colors.grey,
      textSelectionColor: Colors.black,
      cardColor: Colors.white,
      canvasColor: Colors.grey[50],
      brightness: Brightness.light,
      textTheme: TextTheme(
        //Used in Main Headings like "WorldWide", "Statistics" etc.
        headline1: TextStyle(
          fontSize: 25,
          color: primaryBlack,
          fontWeight: FontWeight.bold,
        ),
        //Used in some Bigger texts like "We stand together to fight with this".
        headline2: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        //Used in Custom Buttons like "Regional" , "India's Stats".
        headline3: TextStyle(
          fontSize: 16,
          color: primaryBlack,
          fontWeight: FontWeight.bold,
        ),
        //Used in Legend of PieChart Widget.
        headline4: TextStyle(
          fontSize: 15.0,
          color: primaryBlack,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      primaryColor: primaryBlack,
      accentColor: Color(0xff4285F4),
      backgroundColor: Color(0xff0E1D36),
      fontFamily: 'Circular',
      indicatorColor: Color(0xff0E1D36),
      buttonColor: Colors.orange[100],
      highlightColor: Color(0xff372901),
      disabledColor: Colors.grey,
      textSelectionColor: Colors.white,
      cardColor: Color(0xFF151515),
      canvasColor: Colors.black,
      brightness: Brightness.dark,
      textTheme: TextTheme(
        //Used in Main Headings like "WorldWide", "Statistics" etc.
        headline1: TextStyle(
          fontSize: 25,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        //Used in some Bigger texts like "We stand together to fight with this".
        headline2: TextStyle(
          fontSize: 20,
          color: primaryBlack,
          fontWeight: FontWeight.bold,
        ),
        //Used in Custom Buttons like "Regional" , "India's Stats".
        headline3: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        //Used in Legend of PieChart Widget.
        headline4: TextStyle(
          fontSize: 15.0,
          color: primaryBlack,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
