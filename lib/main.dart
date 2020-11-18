import 'package:covid_19_tracker/data/data.dart';
import 'package:covid_19_tracker/data/hive_boxes.dart';
import 'package:covid_19_tracker/models/countriesData.dart';
import 'package:covid_19_tracker/models/indiaData.dart';
import 'package:covid_19_tracker/models/worldData.dart';
import 'package:covid_19_tracker/pages/homePage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(WorldDataAdapter());
  Hive.registerAdapter(CountriesDataAdapter());
  Hive.registerAdapter(IndiaDataAdapter());
  await Hive.openBox<WorldData>(HiveBoxes.worldData);
  await Hive.openBox<CountriesData>(HiveBoxes.countriesData);
  await Hive.openBox<IndiaData>(HiveBoxes.indiaData);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    Hive.box<WorldData>(HiveBoxes.worldData).compact();
    Hive.box<CountriesData>(HiveBoxes.countriesData).compact();
    Hive.box<IndiaData>(HiveBoxes.indiaData).compact();
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //TODO! REMOVE AFTER TEST

    Box worldDataBox = Hive.box<WorldData>(HiveBoxes.worldData);
    print('No. of Items in ${HiveBoxes.worldData} is ${worldDataBox.length}');
    Box countriesDataBox = Hive.box<CountriesData>(HiveBoxes.countriesData);
    print(
        'No. of Items in ${HiveBoxes.countriesData} is ${countriesDataBox.length}');
    Box indiaDataBox = Hive.box<IndiaData>(HiveBoxes.indiaData);
    print('No. of Items in ${HiveBoxes.indiaData} is ${indiaDataBox.length}');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'COVID-19 Tracker',
      theme: ThemeData(
        fontFamily: 'Circular',
        primaryColor: primaryBlack,
      ),
      home: HomePage.create(context),
    );
  }
}
