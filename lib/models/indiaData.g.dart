// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'indiaData.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IndiaDataAdapter extends TypeAdapter<IndiaData> {
  @override
  final int typeId = 0;

  @override
  IndiaData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IndiaData(
      confirmed: fields[0] as String,
      active: fields[1] as String,
      deaths: fields[2] as String,
      recovered: fields[3] as String,
      statewise: (fields[4] as List)?.cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, IndiaData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.confirmed)
      ..writeByte(1)
      ..write(obj.active)
      ..writeByte(2)
      ..write(obj.deaths)
      ..writeByte(3)
      ..write(obj.recovered)
      ..writeByte(4)
      ..write(obj.statewise);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IndiaDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
