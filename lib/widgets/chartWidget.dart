import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class ChartWidget extends StatelessWidget {
  final worldWideData;

  const ChartWidget({Key key, this.worldWideData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 10.0,
      ),
      child: PieChart(
        dataMap: {
          'Confirmed':
              worldWideData == null ? 0 : worldWideData['cases'].toDouble(),
          'Active':
              worldWideData == null ? 0 : worldWideData['active'].toDouble(),
          'Recovered':
              worldWideData == null ? 0 : worldWideData['recovered'].toDouble(),
          'Deaths':
              worldWideData == null ? 0 : worldWideData['deaths'].toDouble(),
        },
        colorList: [
          Colors.red[400],
          Colors.blue,
          Colors.green[400],
          Colors.grey[400],
        ],
        showLegends: true,
        legendPosition: LegendPosition.right,
      ),
    );
  }
}
