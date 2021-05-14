import 'package:covid_19_tracker/models/countryData.dart';
import 'package:hive/hive.dart';
part 'countriesData.g.dart';

@HiveType(typeId: 4)
class CountriesData {
  @HiveField(0)
  List<CountryData> countriesData;

  CountriesData({
    required this.countriesData,
  });

  factory CountriesData.fromJSON(List<dynamic> countriesData) {
    return CountriesData(
      countriesData: countriesData
          .map<CountryData>(
            (countryData) => CountryData.fromJSON(countryData),
          )
          .toList(),
    );
  }

  @override
  String toString() {
    return 'CountriesData: $countriesData';
  }
}
