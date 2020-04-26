import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './data/datasource.dart';
import './widgets/worldwidewidget.dart';
import './widgets/infoWidget.dart';
import './widgets/mostAffectedCountriesWidget.dart';
import './widgets/pieChart.dart';
import './pages/countryWiseStats.dart';
import './pages/indiaStats.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map worldData;
  List countryData;

  getWorldWideData() async {
    http.Response data = await http.get('https://corona.lmao.ninja/v2/all');
    setState(() {
      worldData = json.decode(data.body);
    });
  }

  getCountriesData() async {
    http.Response data =
        await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
    setState(() {
      countryData = json.decode(data.body);
    });
  }

  @override
  void initState() {
    getWorldWideData();
    getCountriesData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('COVID-19 TRACKER'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: height * 0.10,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              color: Colors.orange[100],
              child: Text(
                DataSource.quote,
                style: TextStyle(
                  color: Colors.orange[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Worldwide',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return CountryWiseStats();
                              },
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(7.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: primaryBlack,
                          ),
                          child: Text(
                            'Regional',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return IndiaStats();
                              },
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(7.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: primaryBlack,
                          ),
                          child: Text(
                            'India\'s Stats ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            worldData == null
                ? Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : WorldWideWidget(worldData: worldData),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Text(
                'Most Affected Countries',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            countryData == null
                ? Container(
                    height: 100.0,
                  )
                : MostAffectedWidget(
                    countryData: countryData,
                  ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Text(
                'Statistics...',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            countryData == null
                ? Container(
                    height: 100.0,
                    child: Center(
                      child: Container(
                        height: 5.0,
                        width: 100.0,
                        child: LinearProgressIndicator(),
                      ),
                    ),
                  )
                : PieChartWidget(
                    total:
                        worldData == null ? 0 : worldData['cases'].toDouble(),
                    active:
                        worldData == null ? 0 : worldData['active'].toDouble(),
                    recovered: worldData == null
                        ? 0
                        : worldData['recovered'].toDouble(),
                    deaths:
                        worldData == null ? 0 : worldData['deaths'].toDouble(),
                    totalColor: Colors.red[400],
                    activeColor: Colors.blue,
                    recoveredColor: Colors.green[400],
                    deathsColor: Colors.grey[400],
                  ),
            SizedBox(
              height: 10.0,
            ),
            InfoWidget(),
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: Text(
                'WE STAND TOGETHER TO FIGHT WITH THIS',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
