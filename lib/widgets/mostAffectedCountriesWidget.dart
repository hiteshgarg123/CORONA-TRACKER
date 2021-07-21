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
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: countriesData.countriesData[index].countryFlagUrl,
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
              Expanded(
                flex: 2,
                child: AutoSizeText(
                  countriesData.countriesData[index].country,
                  maxLines: 1,
                  minFontSize: 12.0,
                  maxFontSize: 16.0,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 9,
                child: AutoSizeText(
                  'Total Case: ${NumberFormatter.formatString(countriesData.countriesData[index].cases)} ,  Deaths: ${NumberFormatter.formatString(countriesData.countriesData[index].deaths)}',
                  maxLines: 1,
                  minFontSize: 11.0,
                  maxFontSize: 17.0,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
