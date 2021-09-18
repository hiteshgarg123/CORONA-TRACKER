import 'dart:convert';
import 'dart:io';

import 'package:covid_19_tracker/models/countriesData.dart';
import 'package:covid_19_tracker/models/worldData.dart';
import 'package:covid_19_tracker/utils/constants/hive_boxes.dart';
import 'package:covid_19_tracker/utils/enums/data_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class WorldDataProvider extends ChangeNotifier {
  final worldDataBox = Hive.box<WorldData>(HiveBoxes.worldData);
  final countriesDataBox = Hive.box<CountriesData>(HiveBoxes.countriesData);
  WorldData? worldData;
  CountriesData? countriesData;
  DataLoadState dataState = DataLoadState.idle;

  void getCachedData() {
    if (countriesDataBox.isNotEmpty) {
      countriesData = countriesDataBox.values.last;
    }
    if (worldDataBox.isNotEmpty) {
      worldData = worldDataBox.values.last;
    }
  }

  Future<void> updateData() async {
    try {
      if (worldData == null || countriesData == null) {
        dataState = DataLoadState.loadingFromServer;
      } else {
        dataState = DataLoadState.updatingFromServer;
        await Fluttertoast.showToast(msg: "Updating data...");
      }
      final worldDataResponse = await http.get(
        Uri.parse('https://corona.lmao.ninja/v3/covid-19/all'),
      );
      final countriesDataResponse = await http.get(
        Uri.parse('https://corona.lmao.ninja/v3/covid-19/countries?sort=cases'),
      );
      if (worldDataResponse.statusCode == HttpStatus.ok &&
          countriesDataResponse.statusCode == HttpStatus.ok) {
        final _worldData =
            json.decode(worldDataResponse.body) as Map<String, dynamic>;
        countriesData = CountriesData.fromJSON(
          json.decode(countriesDataResponse.body) as List,
        );
        worldData = WorldData.fromJSON(_worldData);
        await countriesDataBox.clear();
        await worldDataBox.clear();
        await countriesDataBox.add(countriesData!);
        await worldDataBox.add(worldData!);
        dataState = DataLoadState.success;
      }
      notifyListeners();
    } on SocketException catch (_) {
      dataState = DataLoadState.noInternet;
      await Fluttertoast.showToast(msg: "No Internet");
      notifyListeners();
    } catch (e) {
      if (worldData == null) {
        dataState = DataLoadState.overallFailure;
        notifyListeners();
      } else {
        dataState = DataLoadState.serverError;
        await Fluttertoast.showToast(msg: "Server Error");
        notifyListeners();
      }
    }
  }
}
