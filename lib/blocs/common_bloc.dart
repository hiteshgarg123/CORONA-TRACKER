import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class CommonBloc {
  final _worldDataLoadingController = StreamController<bool>.broadcast();
  final _countriesDataLoadingController = StreamController<bool>();
  final _indiaDataLoadingController = StreamController<bool>();
  final _combinedDataLoadingController = StreamController<bool>.broadcast();

  Map worldData;
  List countryData;
  Map indiaData;

  final snackBar = const SnackBar(
    content: Text('Press back again to exit'),
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
      _countriesDataLoadingController.add(isLoading);
  void setWorldDataLoading(bool isLoading) =>
      _worldDataLoadingController.add(isLoading);
  void setIndiaDataLoading(bool isLoading) =>
      _indiaDataLoadingController.add(isLoading);
  void setDataLoading(bool isLoading) =>
      _combinedDataLoadingController.add(isLoading);

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
    final data = await http.get('https://corona.lmao.ninja/v2/all');
    worldData = json.decode(data.body);
    setWorldDataLoading(false);
  }

  Future<void> getCountriesData() async {
    http.Response data =
        await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
    countryData = json.decode(data.body);
    setCountriesDataLoading(false);
  }

  Future<void> getIndiaData() async {
    final data = await http.get(
        'https://api.rootnet.in/covid19-in/unofficial/covid19india.org/statewise');
    indiaData = json.decode(data.body);
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
