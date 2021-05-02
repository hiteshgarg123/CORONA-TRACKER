import 'package:hive/hive.dart';
part 'countryData.g.dart';

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
  @HiveField(4)
  String todayCases;
  @HiveField(5)
  String active;
  @HiveField(6)
  String recovered;
  @HiveField(7)
  String todayDeaths;

  CountryData({
    required this.cases,
    required this.deaths,
    required this.countryFlagUrl,
    required this.country,
    required this.todayCases,
    required this.active,
    required this.recovered,
    required this.todayDeaths,
  });

  factory CountryData.fromJSON(Map<String, dynamic> countriesData) {
    return CountryData(
      cases: countriesData['cases'].toString(),
      deaths: countriesData['deaths'].toString(),
      countryFlagUrl: countriesData['countryInfo']['flag'],
      country: countriesData['country'],
      todayCases: countriesData['todayCases'].toString(),
      active: countriesData['active'].toString(),
      recovered: countriesData['recovered'].toString(),
      todayDeaths: countriesData['todayDeaths'].toString(),
    );
  }

  @override
  String toString() {
    return 'Cases: $cases, Deaths: $deaths, CountryFlagUrl: $countryFlagUrl, Country: $country';
  }
}
