import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:covid_19_tracker/models/countriesData.dart';
import 'package:covid_19_tracker/utils/formatter/number_formatter.dart';
import 'package:flutter/material.dart';

class MostAffectedWidget extends StatelessWidget {
  final CountriesData countriesData;

  const MostAffectedWidget({
    Key? key,
    required this.countriesData,
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
                    child: CachedNetworkImage(
                      imageUrl:
                          countriesData.countriesData[index].countryFlagUrl,
                      progressIndicatorBuilder: (context, url, progress) =>
                          Center(
                        child: LinearProgressIndicator(
                          value: progress.progress,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: AutoSizeText(
                    countriesData.countriesData[index].country,
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
                    'No. of cases: ${NumberFormatter.formatString(countriesData.countriesData[index].cases)} ,  Deaths: ${NumberFormatter.formatString(countriesData.countriesData[index].deaths)}',
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
