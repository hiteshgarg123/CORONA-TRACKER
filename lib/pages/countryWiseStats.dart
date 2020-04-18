import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CountryWiseStats extends StatefulWidget {
  @override
  _CountryWiseStatsState createState() => _CountryWiseStatsState();
}

class _CountryWiseStatsState extends State<CountryWiseStats> {
  List _worldWideData;

  getWorldWideData() async {
    http.Response data =
        await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
    setState(() {
      _worldWideData = json.decode(data.body);
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
        title: Text(
          'COUNTRY-WISE STATS',
        ),
      ),
      body: _worldWideData == null
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
                  CircularProgressIndicator(),
                ],
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4.0,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    height: height * 0.17,
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '${_worldWideData[index]["country"]}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 3.0),
                                child: Image.network(
                                  "${_worldWideData[index]["countryInfo"]["flag"]}",
                                  height: 60.0,
                                  width: 75.0,
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'CONFIRMED : ${_worldWideData[index]["cases"]}'
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                                Text(
                                  '[+${_worldWideData[index]["todayCases"]}]'
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                                Text(
                                  'ACTIVE : ${_worldWideData[index]["active"]}'
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                Text(
                                  'RECOVERED : ${_worldWideData[index]["recovered"]}'
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                                Text(
                                  'DEATHS : ${_worldWideData[index]["deaths"]} [+${_worldWideData[index]["todayDeaths"]}]'
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: _worldWideData == null ? 0 : _worldWideData.length,
            ),
    );
  }
}
