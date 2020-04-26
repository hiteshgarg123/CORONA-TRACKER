import 'package:flutter/material.dart';

import 'gridBox.dart';

class WorldWideWidget extends StatelessWidget {
  final worldData;

  const WorldWideWidget({Key key, @required this.worldData}) : super(key: key);

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
            boxColor: Colors.red[200].withOpacity(0.70),
            textColor: Colors.red[900],
            count: worldData["cases"].toString(),
          ),
          GridBox(
            title: 'ACTIVE',
            boxColor: Colors.blue[100],
            textColor: Colors.blue[900],
            count: worldData["active"].toString(),
          ),
          GridBox(
            title: 'RECOVERED',
            boxColor: Colors.green[200],
            textColor: Colors.lightGreen[900],
            count: worldData["recovered"].toString(),
          ),
          GridBox(
            title: 'DEATHS',
            boxColor: Colors.grey[400],
            textColor: Colors.grey[900],
            count: worldData["deaths"].toString(),
          ),
          GridBox(
            title: 'CASES TODAY',
            boxColor: Colors.purple[300].withOpacity(0.8),
            textColor: Colors.purple[900],
            count: worldData["todayCases"].toString(),
          ),
          GridBox(
            title: ' AFFECTED\nCOUNTRIES',
            boxColor: Colors.deepOrange[300].withOpacity(0.8),
            textColor: Colors.deepOrange[900],
            count: worldData["affectedCountries"].toString(),
          ),
        ],
      ),
    );
  }
}
