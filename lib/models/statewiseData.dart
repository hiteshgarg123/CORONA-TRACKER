import 'package:hive/hive.dart';
part 'statewiseData.g.dart';

@HiveType(typeId: 3)
class StatewiseData {
  @HiveField(0)
  final String confirmed;
  @HiveField(1)
  final String active;
  @HiveField(2)
  final String deaths;
  @HiveField(3)
  final String recovered;
  @HiveField(4)
  final String lastupdatedtime;
  @HiveField(5)
  final String state;
  @HiveField(6)
  final String statecode;

  StatewiseData({
    required this.active,
    required this.confirmed,
    required this.deaths,
    required this.recovered,
    required this.state,
    required this.statecode,
    required this.lastupdatedtime,
  });

  factory StatewiseData.fromJson(Map<String, dynamic> json) {
    return StatewiseData(
      active: json['active'],
      confirmed: json['confirmed'],
      deaths: json['deaths'],
      lastupdatedtime: json['lastupdatedtime'],
      recovered: json['recovered'],
      state: json['state'],
      statecode: json['statecode'],
    );
  }

  @override
  String toString() {
    return 'Confirmed: $confirmed, Active: $active, Deaths: $deaths, Recovered: $recovered';
  }
}
