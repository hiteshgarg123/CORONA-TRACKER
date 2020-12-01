import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CountryCard extends StatelessWidget {
  final List countryData;
  final double height;
  final int index;

  const CountryCard({
    Key key,
    @required this.countryData,
    @required this.height,
    @required this.index,
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
        margin: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 10.0,
        ),
        height: height * 0.17,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AutoSizeText(
                      '${countryData[index].country}',
                      maxLines: 2,
                      minFontSize: 12.0,
                      maxFontSize: 17.0,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 3.0),
                      child: Image.network(
                        "${countryData[index].countryFlagUrl}",
                        height: 60.0,
                        width: 75.0,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AutoSizeText(
                      'CONFIRMED : ${countryData[index].cases}',
                      maxLines: 1,
                      minFontSize: 12.0,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    AutoSizeText(
                      '[+${countryData[index].todayCases}]',
                      maxLines: 1,
                      minFontSize: 12.0,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    AutoSizeText(
                      'ACTIVE : ${countryData[index].active}',
                      maxLines: 1,
                      minFontSize: 12.0,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    AutoSizeText(
                      'RECOVERED : ${countryData[index].recovered}',
                      maxLines: 1,
                      minFontSize: 12.0,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    AutoSizeText(
                      'DEATHS : ${countryData[index].deaths} [+${countryData[index].todayDeaths}]'
                          .toString(),
                      maxLines: 1,
                      minFontSize: 12.0,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
