import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePreference {
  static const themeStatus = "CURRENT_THEME_STATUS";

  Future<void> setDarkTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(themeStatus, value);
  }
}
