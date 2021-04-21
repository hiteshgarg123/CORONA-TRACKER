import 'package:covid_19_tracker/widgets/india_state_card.dart';
import 'package:flutter/material.dart';

class IndiaStatewise extends StatelessWidget {
  final List indiaData;

  IndiaStatewise({
    Key key,
    @required this.indiaData,
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
              if (indiaData != null) {
                showSearch(
                  context: context,
                  delegate: Search(
                    indiaData,
                    height,
                  ),
                );
              }
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

  Search(this.indiaData, this.height);

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
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
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
      itemCount: indiaData == null ? 0 : suggestionList.length,
      itemBuilder: (context, index) {
        return StateCard(
          index: index,
          indiaStatewiseData: suggestionList,
          height: height,
        );
      },
    );
  }

  @override
  String get searchFieldLabel => 'Enter a State...';

  @override
  TextStyle get searchFieldStyle => TextStyle(color: Colors.white);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: Theme.of(context).backgroundColor,
      primaryColor: Theme.of(context).primaryColor,
      textTheme: Theme.of(context).textTheme,
      backgroundColor: Theme.of(context).backgroundColor,
      canvasColor: Theme.of(context).backgroundColor,
    );
  }
}
