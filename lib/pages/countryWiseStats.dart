import 'dart:io';

import 'package:covid_19_tracker/blocs/common_bloc.dart';
import 'package:covid_19_tracker/models/countriesData.dart';
import 'package:covid_19_tracker/models/countryData.dart';
import 'package:covid_19_tracker/utils/constants/hive_boxes.dart';
import 'package:covid_19_tracker/widgets/countryCard.dart';
import 'package:covid_19_tracker/widgets/customProgressIndicator.dart';
import 'package:covid_19_tracker/widgets/notFound.dart';
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
  late final Box<CountriesData> countryDataBox;
  late final CommonBloc bloc;

  CountriesData? countriesCachedData;
  CountriesData? countriesData;

  @override
  void initState() {
    super.initState();
    bloc = Provider.of<CommonBloc>(context, listen: false);
    countryDataBox = Hive.box<CountriesData>(HiveBoxes.countriesData);
    getCachedData();
    updateData();
  }

  Future<void> getCachedData() async {
    try {
      if (countryDataBox.isNotEmpty)
        countriesCachedData = countryDataBox.values.last;
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
    } on Response catch (_) {
      showAlertDialog(
        context: context,
        titleText: 'Oops! Error...',
        contentText: 'Something went wrong :(\nPlease try again later',
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
    bool? isLoading,
    double height,
  ) {
    if (countryDataBox.isEmpty && isLoading!) {
      return CustomProgressIndicator();
    }
    countriesData = isLoading! ? countriesCachedData : bloc.countriesData;
    return ListView.builder(
      itemCount: countriesData!.countriesData.length,
      itemBuilder: (context, index) {
        return CountryCard(
          countryData: countriesData!.countriesData[index],
          height: height,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: Search(
                  countriesData!,
                  height,
                ),
              );
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
  final CountriesData countriesData;
  final double height;
  late List<CountryData> suggestionList;

  Search(this.countriesData, this.height);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          suggestionList = countriesData.countriesData;
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (suggestionList.isEmpty) {
      return const NotFound(
        title: 'No Country Found',
      );
    }
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return CountryCard(
          countryData: suggestionList[index],
          height: height,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    suggestionList = query.isEmpty
        ? countriesData.countriesData
        : countriesData.countriesData
            .where(
              (element) => element.country
                  .toString()
                  .toLowerCase()
                  .startsWith(query.toLowerCase()),
            )
            .toList();
    if (suggestionList.isEmpty) {
      return const NotFound(
        title: 'No Country Found',
      );
    }
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return CountryCard(
          countryData: suggestionList[index],
          height: height,
        );
      },
    );
  }

  @override
  String get searchFieldLabel => 'Enter a Country...';

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      hintColor: Colors.white70,
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
      ),
    );
  }
}
