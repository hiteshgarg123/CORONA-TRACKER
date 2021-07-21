import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid_19_tracker/models/statewiseData.dart';
import 'package:covid_19_tracker/utils/formatter/number_formatter.dart';
import 'package:covid_19_tracker/widgets/pieChart.dart';
import 'package:flutter/material.dart';

class StateCard extends StatelessWidget {
  const StateCard({
    Key? key,
    required this.stateData,
    required this.height,
    this.showPieChartAnimation = true,
  }) : super(key: key);

  final StatewiseData stateData;
  final double height;
  final bool showPieChartAnimation;

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
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 15,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AutoSizeText(
                      '${stateData.state}',
                      minFontSize: 16,
                      maxFontSize: 22.0,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        // fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AutoSizeText(
                      'CONFIRMED : ${NumberFormatter.formatString(stateData.confirmed)}',
                      maxLines: 1,
                      minFontSize: 15.0,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    AutoSizeText(
                      'ACTIVE : ${NumberFormatter.formatString(stateData.active)}',
                      maxLines: 1,
                      minFontSize: 15.0,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    AutoSizeText(
                      'RECOVERED : ${NumberFormatter.formatString(stateData.recovered)}',
                      maxLines: 1,
                      minFontSize: 15.0,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    AutoSizeText(
                      'DEATHS : ${NumberFormatter.formatString(stateData.deaths)}',
                      maxLines: 1,
                      minFontSize: 15.0,
                      style: const TextStyle(
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
                  total: double.tryParse(stateData.confirmed)!,
                  active: double.tryParse(stateData.active)!,
                  recovered: double.tryParse(stateData.recovered)!,
                  deaths: double.tryParse(stateData.deaths)!,
                  totalColor: Colors.red[400]!,
                  activeColor: Colors.blue[400]!,
                  recoveredColor: Colors.green[300]!,
                  deathsColor: Colors.grey[400]!,
                  showLegends: false,
                  duration: showPieChartAnimation ? 800 : 0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
