import 'package:covid_19_tracker/models/worldData.dart';
import 'package:covid_19_tracker/utils/formatter/number_formatter.dart';
import 'package:covid_19_tracker/widgets/gridBox.dart';
import 'package:flutter/material.dart';

class WorldWideWidget extends StatelessWidget {
  final WorldData worldData;

  const WorldWideWidget({
    Key? key,
    required this.worldData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 6.0,
        right: 6.0,
      ),
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2,
        ),
        children: <Widget>[
          GridBox(
            title: 'CONFIRMED',
            boxColor: Colors.red[200]!,
            textColor: Colors.red[900]!,
            count: NumberFormatter.formatString(worldData.cases),
          ),
          GridBox(
            title: 'ACTIVE',
            boxColor: Colors.blue[100]!,
            textColor: Colors.blue[900]!,
            count: NumberFormatter.formatString(worldData.active),
          ),
          GridBox(
            title: 'RECOVERED',
            boxColor: Colors.green[200]!,
            textColor: Colors.lightGreen[900]!,
            count: NumberFormatter.formatString(worldData.recovered),
          ),
          GridBox(
            title: 'DEATHS',
            boxColor: Colors.grey[400]!,
            textColor: Colors.grey[900]!,
            count: NumberFormatter.formatString(worldData.deaths),
          ),
          GridBox(
            title: 'CASES TODAY',
            boxColor: Colors.purple[200]!,
            textColor: Colors.purple[900]!,
            count: NumberFormatter.formatString(worldData.todayCases),
          ),
          GridBox(
            title: ' AFFECTED\nCOUNTRIES',
            boxColor: Colors.deepOrange[200]!,
            textColor: Colors.deepOrange[900]!,
            count: NumberFormatter.formatString(worldData.affetctedCountries),
          ),
        ],
      ),
    );
  }
}
