import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class PieChartWidget extends StatelessWidget {
  final double total;
  final double active;
  final double recovered;
  final double deaths;

  final Color totalColor;
  final Color activeColor;
  final Color recoveredColor;
  final Color deathsColor;

  final int duration;

  final bool showLegends;

  const PieChartWidget({
    Key key,
    @required this.total,
    @required this.active,
    @required this.recovered,
    @required this.deaths,
    @required this.totalColor,
    @required this.activeColor,
    @required this.recoveredColor,
    @required this.deathsColor,
    this.showLegends: true,
    this.duration = 800,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PieChart(
      dataMap: {
        "TOTAL": total,
        "RECOVERED": recovered,
        "ACTIVE": active,
        "DEATHS": deaths,
      },
      colorList: [
        totalColor,
        recoveredColor,
        activeColor,
        deathsColor,
      ],
      legendStyle: Theme.of(context).textTheme.headline4,
      showLegends: showLegends,
      legendPosition: LegendPosition.right,
      animationDuration: Duration(milliseconds: duration),
    );
  }
}
