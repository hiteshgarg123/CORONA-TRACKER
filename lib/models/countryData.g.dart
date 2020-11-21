// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'countryData.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CountryDataAdapter extends TypeAdapter<CountryData> {
  @override
  final int typeId = 2;

  @override
  CountryData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CountryData(
      cases: fields[0] as String,
      deaths: fields[1] as String,
      countryFlagUrl: fields[2] as String,
      country: fields[3] as String,
      todayCases: fields[4] as String,
      active: fields[5] as String,
      recovered: fields[6] as String,
      todayDeaths: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CountryData obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.cases)
      ..writeByte(1)
      ..write(obj.deaths)
      ..writeByte(2)
      ..write(obj.countryFlagUrl)
      ..writeByte(3)
      ..write(obj.country)
      ..writeByte(4)
      ..write(obj.todayCases)
      ..writeByte(5)
      ..write(obj.active)
      ..writeByte(6)
      ..write(obj.recovered)
      ..writeByte(7)
      ..write(obj.todayDeaths);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
