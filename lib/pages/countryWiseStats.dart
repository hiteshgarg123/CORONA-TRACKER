import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid_19_tracker/models/countriesData.dart';
import 'package:covid_19_tracker/models/countryData.dart';
import 'package:covid_19_tracker/widgets/countryCard.dart';
import 'package:covid_19_tracker/widgets/notFound.dart';
import 'package:flutter/material.dart';

class CountryWiseStats extends StatelessWidget {
  final CountriesData countriesData;
  const CountryWiseStats({
    required this.countriesData,
  });

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
                  countriesData,
                  height,
                ),
              );
            },
          ),
        ],
        title: const AutoSizeText(
          'COUNTRY-WISE STATS',
          maxLines: 1,
          textAlign: TextAlign.left,
          minFontSize: 12,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: ListView.builder(
        itemCount: countriesData.countriesData.length,
        itemBuilder: (context, index) {
          return CountryCard(
            countryData: countriesData.countriesData[index],
            height: height,
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
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
      ),
    );
  }
}
