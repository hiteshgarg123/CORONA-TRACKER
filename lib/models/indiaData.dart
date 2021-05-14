import 'package:covid_19_tracker/models/statewiseData.dart';
import 'package:hive/hive.dart';
part 'indiaData.g.dart';

@HiveType(typeId: 5)
class IndiaData {
  @HiveField(0)
  List<StatewiseData> stateData;

  IndiaData({
    required this.stateData,
  });

  factory IndiaData.fromJson(List<dynamic> json) {
    return IndiaData(
      stateData: json
          .map<StatewiseData>(
            (stateData) => StatewiseData.fromJson(stateData),
          )
          .toList(),
    );
  }

  @override
  String toString() {
    return 'StateData: $stateData';
  }
}
