import 'package:covid_19_tracker/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChartWidget extends StatelessWidget {
  final int total;
  final int active;
  final int recovered;
  final int deaths;
  final Color activeColor;
  final Color recoveredColor;
  final Color deathsColor;
  final double durationInMil;
  final bool showLegends;
  final bool showDataLabels;
  const PieChartWidget({
    Key? key,
    required this.total,
    required this.active,
    required this.recovered,
    required this.deaths,
    required this.activeColor,
    required this.recoveredColor,
    required this.deathsColor,
    this.showLegends = true,
    this.durationInMil = 1500,
    this.showDataLabels = true,
  }) : super(key: key);

  List<PieSeries<PieChartDataMapper, String>> _getDefaultPieSeries() {
    final List<PieChartDataMapper> pieData = <PieChartDataMapper>[
      PieChartDataMapper(
        xVal: 'ACTIVE',
        yVal: active,
      ),
      PieChartDataMapper(
        xVal: 'RECOVERED',
        yVal: recovered,
      ),
      PieChartDataMapper(
        xVal: 'DEATHS',
        yVal: deaths,
      ),
    ];
    return <PieSeries<PieChartDataMapper, String>>[
      PieSeries<PieChartDataMapper, String>(
        animationDuration: durationInMil,
        dataSource: pieData,
        xValueMapper: (PieChartDataMapper data, _) => data.xVal,
        yValueMapper: (PieChartDataMapper data, _) => data.yVal,
        dataLabelMapper: (PieChartDataMapper data, _) => data.xVal,
        radius: '80%',
        dataLabelSettings: DataLabelSettings(
          isVisible: showDataLabels,
          //To never hide the chart labels
          labelIntersectAction: LabelIntersectAction.none,
          showCumulativeValues: true,
          labelPosition: ChartDataLabelPosition.outside,
          connectorLineSettings: const ConnectorLineSettings(
            type: ConnectorType.curve,
          ),
          textStyle: const TextStyle(
            color: primaryBlack,
            fontSize: 12,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      palette: <Color>[
        activeColor,
        recoveredColor,
        deathsColor,
      ],
      tooltipBehavior: TooltipBehavior(
        enable: true,
        tooltipPosition: TooltipPosition.pointer,
        duration: 1500,
      ),
      legend: Legend(
        isVisible: showLegends,
        isResponsive: true,
        toggleSeriesVisibility: false,
        overflowMode: LegendItemOverflowMode.wrap,
        textStyle: const TextStyle(
          color: primaryBlack,
          fontWeight: FontWeight.w600,
        ),
      ),
      series: _getDefaultPieSeries(),
    );
  }
}

class PieChartDataMapper {
  final String xVal;
  final int yVal;

  const PieChartDataMapper({
    required this.xVal,
    required this.yVal,
  });
}
