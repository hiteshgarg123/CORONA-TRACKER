import 'package:flutter/material.dart';

import '../widgets/pieChart.dart';

class IndiaStatewise extends StatelessWidget {
  final Map unofficialData;

  IndiaStatewise({Key key, this.unofficialData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                                'ACTIVE : ${unofficialData['data']['statewise'][index]['confirmed']}',
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
                          margin: EdgeInsets.all(5.0),
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
