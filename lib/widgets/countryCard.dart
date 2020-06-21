import 'package:flutter/material.dart';

class CountryCard extends StatelessWidget {
  final List worldWideData;
  final double height;
  final int index;

  const CountryCard({
    Key key,
    @required this.worldWideData,
    @required this.height,
    @required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 10.0,
        ),
        height: height * 0.17,
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${worldWideData[index]["country"]}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 3.0),
                    child: Image.network(
                      "${worldWideData[index]["countryInfo"]["flag"]}",
                      height: 60.0,
                      width: 75.0,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'CONFIRMED : ${worldWideData[index]["cases"]}'.toString(),
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      '[+${worldWideData[index]["todayCases"]}]'.toString(),
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      'ACTIVE : ${worldWideData[index]["active"]}'.toString(),
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      'RECOVERED : ${worldWideData[index]["recovered"]}'
                          .toString(),
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      'DEATHS : ${worldWideData[index]["deaths"]} [+${worldWideData[index]["todayDeaths"]}]'
                          .toString(),
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
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
