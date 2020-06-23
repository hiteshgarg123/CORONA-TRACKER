import 'package:covid_19_tracker/widgets/pieChart.dart';
import 'package:flutter/material.dart';

class StateCard extends StatelessWidget {
  const StateCard({Key key, this.indiaData, this.index}) : super(key: key);
  final List indiaData;
  final int index;

  @override
  Widget build(BuildContext context) {
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
                    '${indiaData[index]['state']}',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'CONFIRMED : ${indiaData[index]['confirmed']}',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                Text(
                  'ACTIVE : ${indiaData[index]['active']}',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  'RECOVERED : ${indiaData[index]['recovered']}',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                Text(
                  'DEATHS : ${indiaData[index]['deaths']}',
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
              total: indiaData[index]['confirmed'].toDouble(),
              active: indiaData[index]['active'].toDouble(),
              recovered: indiaData[index]['recovered'].toDouble(),
              deaths: indiaData[index]['deaths'].toDouble(),
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
  }
}
