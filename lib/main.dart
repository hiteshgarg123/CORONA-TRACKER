import 'package:covid_19_tracker/models/countriesData.dart';
import 'package:covid_19_tracker/models/countryData.dart';
import 'package:covid_19_tracker/models/indiaData.dart';
import 'package:covid_19_tracker/models/statewiseData.dart';
import 'package:covid_19_tracker/models/worldData.dart';
import 'package:covid_19_tracker/pages/homePage.dart';
import 'package:covid_19_tracker/providers/theme_provider.dart';
import 'package:covid_19_tracker/utils/constants/hive_boxes.dart';
import 'package:covid_19_tracker/utils/theme/app_theme.dart';
import 'package:covid_19_tracker/utils/theme/dark_theme_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(WorldDataAdapter());
  Hive.registerAdapter(CountryDataAdapter());
  Hive.registerAdapter(StatewiseDataAdapter());
  Hive.registerAdapter(CountriesDataAdapter());
  Hive.registerAdapter(IndiaDataAdapter());
  await Hive.openBox<WorldData>(HiveBoxes.worldData);
  await Hive.openBox<CountriesData>(HiveBoxes.countriesData);
  await Hive.openBox<IndiaData>(HiveBoxes.indiaData);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final _prefs = await SharedPreferences.getInstance();
  final _isDarkMode = _prefs.getBool(DarkThemePreference.themeStatus) ?? false;
  runApp(CoronaTracker(_isDarkMode));
}

class CoronaTracker extends StatelessWidget {
  final bool _isDarkMode;
  const CoronaTracker(this._isDarkMode);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider(
        _isDarkMode ? AppTheme.darkTheme() : AppTheme.lightTheme(),
      ),
      child: Consumer<ThemeProvider>(
        builder: (_, themeProvider, __) {
          return MaterialApp(
            theme: themeProvider.getTheme(),
            debugShowCheckedModeBanner: false,
            title: 'COVID-19 Tracker',
            home: HomePage.create(),
          );
        },
      ),
    );
  }
}
