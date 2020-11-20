import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
part 'indiaData.g.dart';

@HiveType(typeId: 0)
class IndiaData {
  @HiveField(0)
  String confirmed;
  @HiveField(1)
  String active;
  @HiveField(2)
  String deaths;
  @HiveField(3)
  String recovered;
  @HiveField(4)
  List statewise;

  IndiaData({
    @required this.confirmed,
    @required this.active,
    @required this.deaths,
    @required this.recovered,
    @required this.statewise,
  });

  factory IndiaData.fromJSON(Map<String, dynamic> indiaData) {
    return IndiaData(
      confirmed: indiaData['data']['total']['confirmed'].toString(),
      active: indiaData['data']['total']['active'].toString(),
      deaths: indiaData['data']['total']['deaths'].toString(),
      recovered: indiaData['data']['total']['recovered'].toString(),
      statewise: indiaData['data']['statewise'],
    );
  }

  @override
  String toString() {
    return 'Confirmed: $confirmed, Active: $active, Deaths: $deaths, Recovered: $recovered, Statewise: $statewise';
  }
}
