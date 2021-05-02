import 'package:hive/hive.dart';
part 'worldData.g.dart';

@HiveType(typeId: 1)
class WorldData {
  @HiveField(0)
  String cases;
  @HiveField(1)
  String active;
  @HiveField(2)
  String recovered;
  @HiveField(3)
  String deaths;
  @HiveField(4)
  String todayCases;
  @HiveField(5)
  String affetctedCountries;

  WorldData({
    required this.cases,
    required this.active,
    required this.recovered,
    required this.deaths,
    required this.todayCases,
    required this.affetctedCountries,
  });

  factory WorldData.fromJSON(Map<String, dynamic> worldData) {
    return WorldData(
      cases: worldData['cases'].toString(),
      active: worldData['active'].toString(),
      recovered: worldData['recovered'].toString(),
      deaths: worldData['deaths'].toString(),
      todayCases: worldData['todayCases'].toString(),
      affetctedCountries: worldData['affectedCountries'].toString(),
    );
  }

  @override
  String toString() {
    return 'Cases: $cases, Active: $active, Recovered: $recovered, Deaths: $deaths, TodatCases: $todayCases, AffectedCountries: $affetctedCountries';
  }
}
