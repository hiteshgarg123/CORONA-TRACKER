// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'indiaData.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IndiaDataAdapter extends TypeAdapter<IndiaData> {
  @override
  final int typeId = 5;

  @override
  IndiaData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IndiaData(
      stateData: (fields[0] as List).cast<StatewiseData>(),
    );
  }

  @override
  void write(BinaryWriter writer, IndiaData obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.stateData);
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
