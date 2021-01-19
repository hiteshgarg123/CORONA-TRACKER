import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid_19_tracker/models/statewiseData.dart';
import 'package:covid_19_tracker/widgets/pieChart.dart';
import 'package:flutter/material.dart';

class StateCard extends StatelessWidget {
  const StateCard({
    Key key,
    @required this.indiaStatewiseData,
    @required this.index,
    @required this.height,
  }) : super(key: key);
  final List<StatewiseData> indiaStatewiseData;
  final int index;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 4.0,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 10.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
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
                      child: AutoSizeText(
                        '${indiaStatewiseData[index].state}',
                        minFontSize: 15,
                        maxFontSize: 22.0,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    AutoSizeText(
                      'CONFIRMED : ${indiaStatewiseData[index].confirmed}',
                      maxLines: 1,
                      minFontSize: 12.0,
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    AutoSizeText(
                      'ACTIVE : ${indiaStatewiseData[index].active}',
                      maxLines: 1,
                      minFontSize: 12.0,
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    AutoSizeText(
                      'RECOVERED : ${indiaStatewiseData[index].recovered}',
                      maxLines: 1,
                      minFontSize: 12.0,
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    AutoSizeText(
                      'DEATHS : ${indiaStatewiseData[index].deaths}',
                      maxLines: 1,
                      minFontSize: 12.0,
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(5.0),
                margin: const EdgeInsets.only(right: 10.0),
                child: PieChartWidget(
                  total: double.tryParse(indiaStatewiseData[index].confirmed),
                  active: double.tryParse(indiaStatewiseData[index].active),
                  recovered:
                      double.tryParse(indiaStatewiseData[index].recovered),
                  deaths: double.tryParse(indiaStatewiseData[index].deaths),
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
      ),
    );
  }
}
