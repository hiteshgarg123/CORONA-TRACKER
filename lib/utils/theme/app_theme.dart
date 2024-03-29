import 'package:flutter/material.dart';

const primaryBlack = Color(0xff202c3b);

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      primaryColor: primaryBlack,
      colorScheme: ColorScheme.fromSwatch(
        accentColor: primaryBlack,
        brightness: Brightness.light,
        backgroundColor: primaryBlack,
      ),
      fontFamily: 'Circular',
      backgroundColor: const Color(0xffF1F5FB),
      indicatorColor: const Color(0xffCBDCF8),
      //buttonColor: primaryBlack,
      highlightColor: Colors.grey[700],
      disabledColor: Colors.grey,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryBlack,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        selectionColor: Colors.black,
      ),
      cardColor: Colors.white,
      canvasColor: Colors.grey[50],
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: primaryBlack,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: primaryBlack,
        highlightColor: Colors.grey[850],
      ),
      textTheme: const TextTheme(
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
        //Used in `No Country found text (in search)`
        headline5: TextStyle(
          fontSize: 22,
          color: primaryBlack,
          fontWeight: FontWeight.w600,
        ),
        //For search delegate's textfield search text
        headline6: TextStyle(
          fontSize: 20.0,
          color: Colors.white,
        ),
        //For Custom Progress Indicator
        subtitle1: TextStyle(
          fontSize: 22,
          color: primaryBlack,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      primaryColor: primaryBlack,
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.dark,
        accentColor: const Color(0xff4285F4),
        backgroundColor: Colors.orange[100],
      ),
      backgroundColor: const Color(0xff0E1D36),
      fontFamily: 'Circular',
      indicatorColor: const Color(0xff0E1D36),
      //buttonColor: Colors.orange[100],
      highlightColor: Colors.grey[700],
      disabledColor: Colors.grey,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryBlack,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        selectionColor: Colors.white,
      ),
      cardColor: const Color(0xFF151515),
      canvasColor: const Color(0xff0E1D36),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.orange[100],
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.orange[100],
        highlightColor: Colors.orange[200],
      ),
      textTheme: TextTheme(
        //Used in Main Headings like "WorldWide", "Statistics" etc.
        headline1: const TextStyle(
          fontSize: 25,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        //Used in some Bigger texts like "We stand together to fight with this".
        headline2: const TextStyle(
          fontSize: 20,
          color: primaryBlack,
          fontWeight: FontWeight.bold,
        ),
        //Used in Custom Buttons like "Regional" , "India's Stats".
        headline3: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        //Used in `No Country found text (in search)`
        headline5: TextStyle(
          fontSize: 22,
          color: Colors.orange[100],
          fontWeight: FontWeight.w600,
        ),
        //Used in Legend of PieChart Widget.
        headline4: const TextStyle(
          fontSize: 15.0,
          color: primaryBlack,
          fontWeight: FontWeight.bold,
        ),
        //For search delegate's textfield search text
        headline6: const TextStyle(
          fontSize: 20.0,
          color: Colors.white,
        ),
        //For Custom Progress Indicator
        subtitle1: TextStyle(
          fontSize: 22,
          color: Colors.orange[100],
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
