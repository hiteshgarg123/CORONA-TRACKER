import 'package:flutter/material.dart';
import 'package:covid_19_tracker/widgets/india_state_card.dart';

class IndiaStatewise extends StatelessWidget {
  final Map indiaData;

  IndiaStatewise({Key key, this.indiaData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              if (indiaData != null) {
                showSearch(
                  context: context,
                  delegate: Search(
                    indiaData,
                  ),
                );
              }
            },
          ),
        ],
        title: Text(
          'Statewise Stats',
        ),
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return StateCard(
              index: index,
              indiaData: indiaData['data']['statewise'],
            );
          },
          itemCount: indiaData['data']['statewise'].length,
        ),
      ),
    );
  }
}

class Search extends SearchDelegate {
  final Map indiaData;

  Search(this.indiaData);

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
        ? indiaData['data']['statewise']
        : indiaData['data']['statewise']
            .where(
              (element) => element['state']
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
          indiaData: suggestionList,
        );
      },
    );
  }
}
