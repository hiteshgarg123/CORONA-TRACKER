// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worldData.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorldDataAdapter extends TypeAdapter<WorldData> {
  @override
  final int typeId = 1;

  @override
  WorldData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorldData(
      cases: fields[0] as String,
      active: fields[1] as String,
      recovered: fields[2] as String,
      deaths: fields[3] as String,
      todayCases: fields[4] as String,
      affetctedCountries: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WorldData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.cases)
      ..writeByte(1)
      ..write(obj.active)
      ..writeByte(2)
      ..write(obj.recovered)
      ..writeByte(3)
      ..write(obj.deaths)
      ..writeByte(4)
      ..write(obj.todayCases)
      ..writeByte(5)
      ..write(obj.affetctedCountries);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorldDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
