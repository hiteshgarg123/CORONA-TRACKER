import 'package:covid_19_tracker/widgets/india_state_card.dart';
import 'package:flutter/material.dart';

class IndiaStatewise extends StatelessWidget {
  final List indiaData;

  IndiaStatewise({
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
                  indiaData.sublist(1),
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
              index: index + 1,
              indiaStatewiseData: indiaData,
              height: height,
              showPieChartAnimation: true,
            );
          },
          itemCount: indiaData.length - 1,
        ),
      ),
    );
  }
}

class Search extends SearchDelegate {
  final List indiaData;
  final double height;
  late List suggestionList;

  Search(this.indiaData, this.height);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          suggestionList = indiaData;
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
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return StateCard(
          index: index,
          indiaStatewiseData: suggestionList,
          height: height,
          showPieChartAnimation: false,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    suggestionList = query.isEmpty
        ? indiaData
        : indiaData
            .where(
              (element) => element.state
                  .toString()
                  .toLowerCase()
                  .startsWith(query.toLowerCase()),
            )
            .toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return StateCard(
          index: index,
          indiaStatewiseData: suggestionList,
          height: height,
          showPieChartAnimation: false,
        );
      },
    );
  }

  @override
  String get searchFieldLabel => 'Enter a State...';

  @override
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
