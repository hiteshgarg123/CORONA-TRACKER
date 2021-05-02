import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:covid_19_tracker/models/countryData.dart';
import 'package:covid_19_tracker/models/statewiseData.dart';
import 'package:covid_19_tracker/models/worldData.dart';
import 'package:covid_19_tracker/utils/constants/hive_boxes.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class CommonBloc {
  final _worldDataLoadingController = StreamController<bool>.broadcast();
  final _countriesDataLoadingController = StreamController<bool>.broadcast();
  final _indiaDataLoadingController = StreamController<bool>.broadcast();
  final _combinedDataLoadingController = StreamController<bool>.broadcast();

  WorldData worldData;
  List<CountryData> countriesData;
  List<StatewiseData> indiaData;

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

  void disposeWorldandCountryDataStreams() {
    _worldDataLoadingController.close();
    _countriesDataLoadingController.close();
    _combinedDataLoadingController.close();
  }

  void disposeIndiaDataStream() {
    _indiaDataLoadingController.close();
  }

  Future<bool> onWillPop(BuildContext context) async {
    final currentTime = DateTime.now();

    final backButtonNotPressedTwice = backButtonPressedTime == null ||
        currentTime.difference(backButtonPressedTime) > snackBarDuration;

    if (backButtonNotPressedTwice) {
      backButtonPressedTime = currentTime;
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
    return true;
  }

  Future<void> getWorldWideData() async {
    final response = await http.get(
      Uri.parse('https://corona.lmao.ninja/v3/covid-19/all'),
    );
    if (response.statusCode == HttpStatus.ok) {
      final _worldData = json.decode(response.body);
      worldData = WorldData.fromJSON(_worldData);
      Box worldDataBox = Hive.box(HiveBoxes.worldData);
      await worldDataBox.clear();
      await worldDataBox.add(worldData);
      if (!_worldDataLoadingController.isClosed) {
        setWorldDataLoading(false);
      }
    } else {
      print('Response => $response');
      throw response;
    }
  }

  Future<void> getCountriesData() async {
    http.Response response = await http.get(
      Uri.parse('https://corona.lmao.ninja/v3/covid-19/countries?sort=cases'),
    );
    if (response.statusCode == HttpStatus.ok) {
      countriesData = (json.decode(response.body) as List)
          .map<CountryData>(
              (_countryData) => CountryData.fromJSON(_countryData))
          .toList();
      Box countriesDataBox = Hive.box(HiveBoxes.countriesData);
      await countriesDataBox.clear();
      await countriesDataBox.add(countriesData);
      if (!_countriesDataLoadingController.isClosed) {
        setCountriesDataLoading(false);
      }
    } else {
      throw response;
    }
  }

  Future<void> getIndiaData() async {
    final response = await http.get(
      Uri.parse('https://api.covid19india.org/data.json'),
    );
    if (response.statusCode == HttpStatus.ok) {
      final _indiaData = ((json.decode(response.body))['statewise'] as List);
      indiaData = _indiaData
          .map<StatewiseData>(
            (e) => StatewiseData.fromJson(e),
          )
          .toList();
      Box indiaDataBox = Hive.box(HiveBoxes.stateData);
      await indiaDataBox.clear();
      await indiaDataBox.add(indiaData);
      if (!_indiaDataLoadingController.isClosed) {
        setIndiaDataLoading(false);
      }
    } else {
      throw response;
    }
  }

  Future<void> getCombinedData() async {
    await Future.wait([
      getWorldWideData(),
      getCountriesData(),
    ]);
    if (!_combinedDataLoadingController.isClosed) {
      setDataLoading(false);
    }
  }

  Future<void> loadIndiaDataOnRefresh() async {
    return await getIndiaData();
  }
}
