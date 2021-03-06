import 'dart:io';

import 'package:covid_19_tracker/blocs/common_bloc.dart';
import 'package:covid_19_tracker/data/hive_boxes.dart';
import 'package:covid_19_tracker/widgets/countryCard.dart';
import 'package:covid_19_tracker/widgets/customProgressIndicator.dart';
import 'package:covid_19_tracker/widgets/platform_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class CountryWiseStats extends StatefulWidget {
  @override
  _CountryWiseStatsState createState() => _CountryWiseStatsState();
}

class _CountryWiseStatsState extends State<CountryWiseStats> {
  List countriesData;
  List countriesCachedData;
  Box countryDataBox;
  CommonBloc bloc;

  @override
  void initState() {
    bloc = Provider.of<CommonBloc>(context, listen: false);
    super.initState();
    getCachedData();
    updateData();
  }

  Future<void> getCachedData() async {
    try {
      countryDataBox = Hive.box(HiveBoxes.countriesData);
      countriesCachedData =
          countryDataBox.isNotEmpty ? countryDataBox.values.last : null;
    } catch (_) {
      showAlertDialog(
        context: context,
        titleText: 'Error Reading Data',
        contentText:
            'Can\'t read data from storage, Contact support or try again later',
        defaultActionButtonText: 'Ok',
      );
    }
  }

  Future<void> updateData() async {
    try {
      await bloc.getCountriesData();
    } on SocketException catch (_) {
      Fluttertoast.showToast(
        msg: 'No Internet',
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
      );
    } on Response catch (response) {
      showAlertDialog(
        context: context,
        titleText: response.statusCode.toString(),
        contentText: 'Error Retrieving Data',
        defaultActionButtonText: 'Ok',
      );
    } catch (_) {
      showAlertDialog(
        context: context,
        titleText: 'Unknown Error',
        contentText: 'Please try again later.',
        defaultActionButtonText: 'Ok',
      );
    }
  }

  Widget _buildContent(
    bool isLoading,
    double height,
  ) {
    if (countryDataBox.isEmpty && isLoading) {
      return CustomProgressIndicator();
    }
    countriesData = isLoading ? countriesCachedData : bloc.countriesData;
    return ListView.builder(
      itemCount: countriesData.length,
      itemBuilder: (context, index) {
        return CountryCard(
          countryData: countriesData,
          height: height,
          index: index,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 2.0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              if (countriesData != null) {
                showSearch(
                  context: context,
                  delegate: Search(
                    countriesData,
                    height,
                  ),
                );
              }
            },
          ),
        ],
        title: const Text(
          'COUNTRY-WISE STATS',
        ),
      ),
      body: StreamBuilder<bool>(
        stream: bloc.countriesDataLoadingStream,
        initialData: true,
        builder: (context, snapshot) {
          return _buildContent(
            snapshot.data,
            height,
          );
        },
      ),
    );
  }
}

class Search extends SearchDelegate {
  final List countryData;
  final double height;

  Search(this.countryData, this.height);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? countryData
        : countryData
            .where(
              (element) => element.country
                  .toString()
                  .toLowerCase()
                  .startsWith(query.toLowerCase()),
            )
            .toList();

    return ListView.builder(
      itemCount: countryData == null ? 0 : suggestionList.length,
      itemBuilder: (context, index) {
        return CountryCard(
          countryData: suggestionList,
          height: height,
          index: index,
        );
      },
    );
  }

  @override
  String get searchFieldLabel => 'Enter a Country...';

  @override
  TextStyle get searchFieldStyle => TextStyle(color: Colors.white);

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = ThemeData(
      scaffoldBackgroundColor: Theme.of(context).backgroundColor,
      primaryColor: Theme.of(context).primaryColor,
      textTheme: Theme.of(context).textTheme,
      backgroundColor: Theme.of(context).backgroundColor,
      canvasColor: Theme.of(context).canvasColor,
    );
    return theme;
  }
}
