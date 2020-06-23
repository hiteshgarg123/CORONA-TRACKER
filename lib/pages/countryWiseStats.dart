import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

import '../widgets/countryCard.dart';
import '../data/datasource.dart';

class CountryWiseStats extends StatefulWidget {
  @override
  _CountryWiseStatsState createState() => _CountryWiseStatsState();
}

class _CountryWiseStatsState extends State<CountryWiseStats> {
  List worldWideData;

  getWorldWideData() async {
    http.Response data =
        await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
    setState(() {
      worldWideData = json.decode(data.body);
    });
  }

  @override
  void initState() {
    getWorldWideData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              if (worldWideData != null) {
                showSearch(
                  context: context,
                  delegate: Search(
                    worldWideData,
                    height,
                  ),
                );
              }
            },
          ),
        ],
        title: Text(
          'COUNTRY-WISE STATS',
        ),
      ),
      body: worldWideData == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Fetching Details , Please wait',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  SpinKitCircle(
                    color: primaryBlack,
                    size: 50.0,
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: worldWideData == null ? 0 : worldWideData.length,
              itemBuilder: (context, index) {
                return CountryCard(
                  worldWideData: worldWideData,
                  height: height,
                  index: index,
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
              (element) => element['country']
                  .toString()
                  .toLowerCase()
                  .startsWith(query.toLowerCase()),
            )
            .toList();

    return ListView.builder(
      itemCount: countryData == null ? 0 : suggestionList.length,
      itemBuilder: (context, index) {
        return CountryCard(
          worldWideData: countryData,
          height: height,
          index: index,
        );
      },
    );
  }
}
