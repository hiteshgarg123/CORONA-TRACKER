import 'package:covid_19_tracker/blocs/common_bloc.dart';
import 'package:covid_19_tracker/data/hive_boxes.dart';
import 'package:covid_19_tracker/models/countryData.dart';
import 'package:covid_19_tracker/models/statewiseData.dart';
import 'package:covid_19_tracker/models/worldData.dart';
import 'package:covid_19_tracker/notifiers/theme_notifier.dart';
import 'package:covid_19_tracker/pages/homePage.dart';
import 'package:covid_19_tracker/utils/app_theme.dart';
import 'package:covid_19_tracker/utils/dark_theme_preference.dart';
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
  await Hive.openBox(HiveBoxes.worldData);
  await Hive.openBox(HiveBoxes.countriesData);
  await Hive.openBox(HiveBoxes.stateData);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SharedPreferences.getInstance().then((pref) {
    final isDarkMode = pref.getBool(DarkThemePreference.THEME_STATUS) ?? false;
    runApp(
      ChangeNotifierProvider<ThemeNotifier>(
        create: (_) => ThemeNotifier(
          isDarkMode ? AppTheme.darkTheme() : AppTheme.lightTheme(),
        ),
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Provider<CommonBloc>(
      create: (_) => CommonBloc(),
      child: Consumer<ThemeNotifier>(
        builder: (_, notifier, __) {
          return MaterialApp(
            theme: notifier.getTheme(),
            debugShowCheckedModeBanner: false,
            title: 'COVID-19 Tracker',
            home: HomePage(),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
