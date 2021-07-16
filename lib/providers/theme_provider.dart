import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData;

  ThemeProvider(this._themeData);

  ThemeData getTheme() => _themeData;

  Future<void> setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }
}
