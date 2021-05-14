import 'package:covid_19_tracker/models/indiaData.dart';
import 'package:covid_19_tracker/models/statewiseData.dart';
import 'package:covid_19_tracker/widgets/india_state_card.dart';
import 'package:covid_19_tracker/widgets/notFound.dart';
import 'package:flutter/material.dart';

class IndiaStatewise extends StatelessWidget {
  final IndiaData indiaData;

  const IndiaStatewise({
    Key? key,
    required this.indiaData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: Search(
                  indiaData,
                  height,
                ),
              );
            },
          ),
        ],
        title: const Text(
          'Statewise Stats',
        ),
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return StateCard(
              stateData: indiaData.stateData[index + 1],
              height: height,
              showPieChartAnimation: true,
            );
          },
          itemCount: indiaData.stateData.length - 1,
        ),
      ),
    );
  }
}

class Search extends SearchDelegate {
  final IndiaData indiaData;
  final double height;
  late List<StatewiseData> suggestionList;

  Search(this.indiaData, this.height);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          suggestionList = indiaData.stateData;
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
        title: 'No State Found',
      );
    }
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return StateCard(
          stateData: suggestionList[index],
          height: height,
          showPieChartAnimation: false,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    suggestionList = query.isEmpty
        ? indiaData.stateData.sublist(1)
        : indiaData.stateData
            .sublist(1)
            .where(
              (element) => element.state
                  .toString()
                  .toLowerCase()
                  .startsWith(query.toLowerCase()),
            )
            .toList();
    if (suggestionList.isEmpty) {
      return const NotFound(
        title: 'No State Found',
      );
    }
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return StateCard(
          stateData: suggestionList[index],
          height: height,
          showPieChartAnimation: false,
        );
      },
    );
  }

  @override
  String get searchFieldLabel => 'Enter a State...';

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
