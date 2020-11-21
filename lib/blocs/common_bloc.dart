import 'dart:async';
import 'dart:convert';
import 'package:covid_19_tracker/data/hive_boxes.dart';
import 'package:covid_19_tracker/models/countryData.dart';
import 'package:covid_19_tracker/models/indiaData.dart';
import 'package:covid_19_tracker/models/worldData.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class CommonBloc {
  final _worldDataLoadingController = StreamController<bool>.broadcast();
  final _countriesDataLoadingController = StreamController<bool>();
  final _indiaDataLoadingController = StreamController<bool>();
  final _combinedDataLoadingController = StreamController<bool>.broadcast();

  WorldData worldData;
  List<CountryData> countriesData;
  IndiaData indiaData;

  final snackBar = const SnackBar(
    content: const Text('Press back again to exit'),
    duration: snackBarDuration,
  );
  DateTime backButtonPressedTime;
  static const snackBarDuration = Duration(seconds: 3);

  Stream<bool> get worldDataLoadingStream => _worldDataLoadingController.stream;
  Stream<bool> get countriesDataLoadingStream =>
      _countriesDataLoadingController.stream;
  Stream<bool> get indiaDataLoadingStream => _indiaDataLoadingController.stream;
  Stream<bool> get dataLoadingStream => _combinedDataLoadingController.stream;

  void setCountriesDataLoading(bool isLoading) =>
      _countriesDataLoadingController.sink.add(isLoading);
  void setWorldDataLoading(bool isLoading) =>
      _worldDataLoadingController.sink.add(isLoading);
  void setIndiaDataLoading(bool isLoading) =>
      _indiaDataLoadingController.sink.add(isLoading);
  void setDataLoading(bool isLoading) =>
      _combinedDataLoadingController.sink.add(isLoading);

  void dispose() {
    _worldDataLoadingController.close();
    _countriesDataLoadingController.close();
    _indiaDataLoadingController.close();
    _combinedDataLoadingController.close();
  }

  Future<bool> onWillPop(BuildContext context) async {
    final currentTime = DateTime.now();

    final backButtonNotPressedTwice = backButtonPressedTime == null ||
        currentTime.difference(backButtonPressedTime) > snackBarDuration;

    if (backButtonNotPressedTwice) {
      backButtonPressedTime = currentTime;
      Scaffold.of(context).showSnackBar(snackBar);
      return false;
    }
    return true;
  }

  Future<void> getWorldWideData() async {
    final response = await http.get('https://corona.lmao.ninja/v2/all');
    final _worldData = json.decode(response.body);
    worldData = WorldData.fromJSON(_worldData);

    Box<WorldData> worldDataBox = Hive.box<WorldData>(HiveBoxes.worldData);
    await worldDataBox.clear();
    await worldDataBox.add(worldData);
    setWorldDataLoading(false);
  }

  Future<void> getCountriesData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
    countriesData = (json.decode(response.body) as List)
        .map<CountryData>((_countryData) => CountryData.fromJSON(_countryData))
        .toList();

    Box countriesDataBox = Hive.box(HiveBoxes.countriesData);
    await countriesDataBox.clear();
    await countriesDataBox.add(countriesData);
    setCountriesDataLoading(false);
  }

  Future<void> getIndiaData() async {
    final response = await http.get(
        'https://api.rootnet.in/covid19-in/unofficial/covid19india.org/statewise');
    final _indiaData = json.decode(response.body);
    indiaData = IndiaData.fromJSON(_indiaData);

    Box<IndiaData> indiaDataBox = Hive.box<IndiaData>(HiveBoxes.indiaData);
    await indiaDataBox.clear();
    await indiaDataBox.add(indiaData);
    setIndiaDataLoading(false);
  }

  Future<void> getCombinedData() async {
    await Future.wait([
      getWorldWideData(),
      getCountriesData(),
    ]);
    setDataLoading(false);
  }

  Future<void> loadIndiaDataOnRefresh() async {
    return await getIndiaData();
  }
}
