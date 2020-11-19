import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
part 'countryData.g.dart';

//TODO! Regenerate the Hive Generated file ( Fields Changed ) , Level : Severe-Crash

@HiveType(typeId: 2)
class CountryData {
  @HiveField(0)
  String cases;
  @HiveField(1)
  String deaths;
  @HiveField(2)
  String countryFlagUrl;
  @HiveField(3)
  String country;

  CountryData({
    @required this.cases,
    @required this.deaths,
    @required this.countryFlagUrl,
    @required this.country,
  });

  factory CountryData.fromJSON(Map<String, dynamic> countriesData) {
    return CountryData(
      cases: countriesData['cases'].toString(),
      deaths: countriesData['deaths'].toString(),
      countryFlagUrl: countriesData['countryInfo']['flag'],
      country: countriesData['country'],
    );
  }

  @override
  String toString() {
    return 'Cases: $cases, Deaths: $deaths, CountryFlagUrl: $countryFlagUrl, Country: $country';
  }
}
