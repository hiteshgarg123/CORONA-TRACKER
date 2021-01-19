import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid_19_tracker/utils/number_formatter.dart';
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
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                    ),
                    child: Image.network(
                      countryData[index].countryFlagUrl,
                      height: 25,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: AutoSizeText(
                    countryData[index].country,
                    maxLines: 1,
                    minFontSize: 12.0,
                    maxFontSize: 17.0,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 8,
                  child: AutoSizeText(
                    'No. of cases: ${NumberFormatter.formatString(countryData[index].cases)} ,  Deaths: ${NumberFormatter.formatString(countryData[index].deaths)}',
                    maxLines: 1,
                    minFontSize: 12.0,
                    maxFontSize: 17.0,
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
