import 'package:flutter/material.dart';

import '../widgets/pieChart.dart';

class IndiaStatewise extends StatelessWidget {
  final Map unofficialData;

  IndiaStatewise({Key key, this.unofficialData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              unofficialData == null
                  ? null
                  : showSearch(
                      context: context,
                      delegate: Search(
                        unofficialData,
                      ),
                    );
            },
          ),
        ],
        title: Text(
          'Statewise Stats',
        ),
      ),
      body: SingleChildScrollView(
        child: unofficialData == null
            ? Center(
                child: Container(
                  height: 5.0,
                  width: 120.0,
                  child: LinearProgressIndicator(),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 6.0,
                    ),
                    elevation: 4.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.fromLTRB(
                            20,
                            15,
                            15,
                            15,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 170,
                                margin: const EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  '${unofficialData['data']['statewise'][index]['state']}',
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                'CONFIRMED : ${unofficialData['data']['statewise'][index]['confirmed']}',
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              Text(
                                'ACTIVE : ${unofficialData['data']['statewise'][index]['active']}',
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              Text(
                                'RECOVERED : ${unofficialData['data']['statewise'][index]['recovered']}',
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              Text(
                                'DEATHS : ${unofficialData['data']['statewise'][index]['deaths']}',
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 150,
                          width: 150,
                          padding: const EdgeInsets.all(5.0),
                          margin: const EdgeInsets.only(right: 10.0),
                          child: PieChartWidget(
                            total: unofficialData['data']['statewise'][index]
                                    ['confirmed']
                                .toDouble(),
                            active: unofficialData['data']['statewise'][index]
                                    ['active']
                                .toDouble(),
                            recovered: unofficialData['data']['statewise']
                                    [index]['recovered']
                                .toDouble(),
                            deaths: unofficialData['data']['statewise'][index]
                                    ['deaths']
                                .toDouble(),
                            totalColor: Colors.red[400],
                            activeColor: Colors.blue[400],
                            recoveredColor: Colors.green[300],
                            deathsColor: Colors.grey[400],
                            showLegends: false,
                          ),
                        )
                      ],
                    ),
                  );
                },
                itemCount: unofficialData == null
                    ? 0
                    : unofficialData['data']['statewise'].length,
              ),
      ),
    );
  }
}

class Search extends SearchDelegate {
  final Map unofficialData;

  Search(this.unofficialData);

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
        ? unofficialData['data']['statewise']
        : unofficialData['data']['statewise']
            .where(
              (element) => element['state']
                  .toString()
                  .toLowerCase()
                  .startsWith(query.toLowerCase()),
            )
            .toList();

    return ListView.builder(
      itemCount: unofficialData == null ? 0 : suggestionList.length,
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 6.0,
          ),
          elevation: 4.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  15,
                  15,
                  15,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 170,
                      margin: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        '${suggestionList[index]['state']}',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      'CONFIRMED : ${suggestionList[index]['confirmed']}',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      'ACTIVE : ${suggestionList[index]['active']}',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      'RECOVERED : ${suggestionList[index]['recovered']}',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      'DEATHS : ${suggestionList[index]['deaths']}',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 150,
                width: 150,
                padding: const EdgeInsets.all(5.0),
                margin: const EdgeInsets.only(right: 10.0),
                child: PieChartWidget(
                  total: suggestionList[index]['confirmed'].toDouble(),
                  active: suggestionList[index]['active'].toDouble(),
                  recovered: suggestionList[index]['recovered'].toDouble(),
                  deaths: suggestionList[index]['deaths'].toDouble(),
                  totalColor: Colors.red[400],
                  activeColor: Colors.blue[400],
                  recoveredColor: Colors.green[300],
                  deathsColor: Colors.grey[400],
                  showLegends: false,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
