import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid_19_tracker/models/statewiseData.dart';
import 'package:covid_19_tracker/utils/formatter/number_formatter.dart';
import 'package:covid_19_tracker/widgets/pieChart.dart';
import 'package:flutter/material.dart';

class StateCard extends StatelessWidget {
  final StatewiseData stateData;
  final bool showPieChartAnimation;
  const StateCard({
    Key? key,
    required this.stateData,
    this.showPieChartAnimation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 4.0,
      child: Container(
        height: MediaQuery.of(context).size.width * 0.45,
        margin: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 8.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 6,
              child: Container(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 15,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AutoSizeText(
                      '${stateData.state}',
                      minFontSize: 17,
                      maxFontSize: 22.0,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    AutoSizeText(
                      'CONFIRMED : ${NumberFormatter.formatString(stateData.confirmed)}',
                      maxLines: 1,
                      minFontSize: 16.0,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                    AutoSizeText(
                      'ACTIVE : ${NumberFormatter.formatString(stateData.active)}',
                      maxLines: 1,
                      minFontSize: 16.0,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                    ),
                    AutoSizeText(
                      'RECOVERED : ${NumberFormatter.formatString(stateData.recovered)}',
                      maxLines: 1,
                      minFontSize: 16.0,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.green,
                      ),
                    ),
                    AutoSizeText(
                      'DEATHS : ${NumberFormatter.formatString(stateData.deaths)}',
                      maxLines: 1,
                      minFontSize: 16.0,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: PieChartWidget(
                total: int.tryParse(stateData.confirmed)!,
                active: int.tryParse(stateData.active)!,
                recovered: int.tryParse(stateData.recovered)!,
                deaths: int.tryParse(stateData.deaths)!,
                activeColor: Colors.blue.shade800,
                recoveredColor: Colors.green.shade500,
                deathsColor: Colors.grey.shade400,
                showLegends: false,
                showDataLabels: false,
                durationInMil: showPieChartAnimation ? 2000 : 0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
