import 'package:covid_19_tracker/widgets/pieChart.dart';
import 'package:flutter/material.dart';

class StateCard extends StatelessWidget {
  const StateCard({
    Key key,
    this.indiaStatewiseData,
    this.index,
  }) : super(key: key);
  final List indiaStatewiseData;
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    '${indiaStatewiseData[index]['state']}',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'CONFIRMED : ${indiaStatewiseData[index]['confirmed']}',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                Text(
                  'ACTIVE : ${indiaStatewiseData[index]['active']}',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  'RECOVERED : ${indiaStatewiseData[index]['recovered']}',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                Text(
                  'DEATHS : ${indiaStatewiseData[index]['deaths']}',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(5.0),
              margin: const EdgeInsets.only(right: 10.0),
              child: PieChartWidget(
                total: indiaStatewiseData[index]['confirmed'].toDouble(),
                active: indiaStatewiseData[index]['active'].toDouble(),
                recovered: indiaStatewiseData[index]['recovered'].toDouble(),
                deaths: indiaStatewiseData[index]['deaths'].toDouble(),
                totalColor: Colors.red[400],
                activeColor: Colors.blue[400],
                recoveredColor: Colors.green[300],
                deathsColor: Colors.grey[400],
                showLegends: false,
              ),
            ),
          )
        ],
      ),
    );
  }
}
