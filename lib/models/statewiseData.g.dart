// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statewiseData.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StatewiseDataAdapter extends TypeAdapter<StatewiseData> {
  @override
  final int typeId = 3;

  @override
  StatewiseData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StatewiseData(
      active: fields[1] as String,
      confirmed: fields[0] as String,
      deaths: fields[2] as String,
      recovered: fields[3] as String,
      state: fields[5] as String,
      statecode: fields[6] as String,
      lastupdatedtime: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StatewiseData obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.confirmed)
      ..writeByte(1)
      ..write(obj.active)
      ..writeByte(2)
      ..write(obj.deaths)
      ..writeByte(3)
      ..write(obj.recovered)
      ..writeByte(4)
      ..write(obj.lastupdatedtime)
      ..writeByte(5)
      ..write(obj.state)
      ..writeByte(6)
      ..write(obj.statecode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatewiseDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
