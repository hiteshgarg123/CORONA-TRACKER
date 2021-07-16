import 'dart:convert';
import 'dart:io';

import 'package:covid_19_tracker/models/indiaData.dart';
import 'package:covid_19_tracker/utils/constants/hive_boxes.dart';
import 'package:covid_19_tracker/utils/enums/data_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class IndiaDataProvider extends ChangeNotifier {
  final indiaDataBox = Hive.box<IndiaData>(HiveBoxes.indiaData);
  IndiaData? indiaData;

  DataLoadState dataState = DataLoadState.idle;

  void getCachedData() {
    if (indiaDataBox.isNotEmpty) {
      indiaData = indiaDataBox.values.last;
    }
  }

  Future<void> updateData() async {
    try {
      if (indiaData == null) {
        dataState = DataLoadState.loadingFromServer;
      } else {
        dataState = DataLoadState.updatingFromServer;
        await Fluttertoast.cancel();
        await Fluttertoast.showToast(msg: "Updating data...");
      }
      final response = await http.get(
        Uri.parse('https://api.covid19india.org/data.json'),
      );

      if (response.statusCode == HttpStatus.ok) {
        final _indiaData = (json.decode(response.body))['statewise'] as List;
        indiaData = IndiaData.fromJson(_indiaData);
        await indiaDataBox.clear();
        await indiaDataBox.add(indiaData!);
        dataState = DataLoadState.success;
      }
      notifyListeners();
    } on SocketException catch (_) {
      dataState = DataLoadState.noInternet;
      await Fluttertoast.cancel();
      await Fluttertoast.showToast(msg: "No Internet");
      notifyListeners();
    } catch (e) {
      if (indiaData == null) {
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
