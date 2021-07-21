import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:covid_19_tracker/models/countryData.dart';
import 'package:covid_19_tracker/utils/formatter/number_formatter.dart';
import 'package:flutter/material.dart';

class CountryCard extends StatelessWidget {
  final CountryData countryData;
  final double height;

  const CountryCard({
    Key? key,
    required this.countryData,
    required this.height,
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
                      '${countryData.country}',
                      maxLines: 2,
                      minFontSize: 12.0,
                      maxFontSize: 17.0,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 3.0),
                      child: CachedNetworkImage(
                        imageUrl: "${countryData.countryFlagUrl}",
                        height: height * 0.08,
                        width: height * 0.09,
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
                      'CONFIRMED : ${NumberFormatter.formatString(countryData.cases)}',
                      maxLines: 1,
                      minFontSize: 14.0,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    AutoSizeText(
                      '[+${NumberFormatter.formatString(countryData.todayCases)}]',
                      maxLines: 1,
                      minFontSize: 14.0,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    AutoSizeText(
                      'ACTIVE : ${NumberFormatter.formatString(countryData.active)}',
                      maxLines: 1,
                      minFontSize: 14.0,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    AutoSizeText(
                      'RECOVERED : ${NumberFormatter.formatString(countryData.recovered)}',
                      maxLines: 1,
                      minFontSize: 14.0,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    AutoSizeText(
                      'DEATHS : ${NumberFormatter.formatString(countryData.deaths)} [+${NumberFormatter.formatString(countryData.todayDeaths)}]',
                      maxLines: 1,
                      minFontSize: 14.0,
                      style: const TextStyle(
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
