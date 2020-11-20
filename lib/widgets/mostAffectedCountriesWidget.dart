import 'package:flutter/material.dart';

class MostAffectedWidget extends StatelessWidget {
  final List countryData;

  const MostAffectedWidget({
    Key key,
    @required this.countryData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: <Widget>[
                Container(
                  height: 20,
                  width: 40,
                  child: Image.network(
                    countryData[index].countryFlagUrl,
                    height: 25,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  countryData[index].country,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    'No. of cases: ${countryData[index].cases}  ,  Deaths: ${countryData[index].deaths}',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: 5,
      ),
    );
  }
}
