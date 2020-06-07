import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../data/datasource.dart';
import '../widgets/infoWidget.dart';
import '../widgets/pieChart.dart';
import '../widgets/gridBox.dart';
import '../pages/indiaStatewise.dart';

class IndiaStats extends StatefulWidget {
  @override
  _IndiaStatsState createState() => _IndiaStatsState();
}

class _IndiaStatsState extends State<IndiaStats> {
  Map unofficialData;

  getUnofficialData() async {
    http.Response data = await http.get(
        'https://api.rootnet.in/covid19-in/unofficial/covid19india.org/statewise');
    setState(() {
      unofficialData = json.decode(data.body);
    });
  }

  @override
  void initState() {
    getUnofficialData();
    super.initState();
  }

  AppBar appbar = AppBar(
    title: Text('India\'s Stats'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: appbar,
      body: SingleChildScrollView(
        child: unofficialData == null
            ? Container(
                height: MediaQuery.of(context).size.height -
                    (appbar.preferredSize.height +
                        MediaQuery.of(context).padding.top),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Fetching Data , Please wait',
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
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          'Overall Stats...',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return IndiaStatewise(
                                    unofficialData: unofficialData,
                                  );
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
                            child: const Text(
                              'Statewise',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: GridView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2.0,
                      ),
                      children: <Widget>[
                        GridBox(
                          title: 'TOTAL CASES',
                          count: unofficialData['data']['total']['confirmed']
                              .toString(),
                          boxColor: Colors.red[300].withOpacity(0.80),
                          textColor: Colors.red[900],
                        ),
                        GridBox(
                          title: 'ACTIVE',
                          count: unofficialData['data']['total']['active']
                              .toString(),
                          boxColor: Colors.blue[300],
                          textColor: Colors.blue[900],
                        ),
                        GridBox(
                          title: 'DEATHS',
                          count: unofficialData['data']['total']['deaths']
                              .toString(),
                          boxColor: Colors.grey,
                          textColor: Colors.grey[900],
                        ),
                        GridBox(
                          title: 'RECOVERED',
                          count: unofficialData['data']['total']['recovered']
                              .toString(),
                          boxColor: Colors.green[400],
                          textColor: Colors.green[900],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Text(
                      'Visuals',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.orange[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 4.0,
                    margin: EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                      bottom: 10.0,
                    ),
                    child: Container(
                      padding:
                          const EdgeInsets.fromLTRB(10.0, 10.0, 15.0, 10.0),
                      child: PieChartWidget(
                        total: unofficialData['data']['total']['confirmed']
                            .toDouble(),
                        active: unofficialData['data']['total']['active']
                            .toDouble(),
                        recovered: unofficialData['data']['total']['recovered']
                            .toDouble(),
                        deaths: unofficialData['data']['total']['deaths']
                            .toDouble(),
                        totalColor: Colors.red[400],
                        activeColor: Colors.blue[400],
                        recoveredColor: Colors.green[300],
                        deathsColor: Colors.grey[400],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
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
