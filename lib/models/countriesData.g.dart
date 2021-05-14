// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'countriesData.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CountriesDataAdapter extends TypeAdapter<CountriesData> {
  @override
  final int typeId = 4;

  @override
  CountriesData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CountriesData(
      countriesData: (fields[0] as List).cast<CountryData>(),
    );
  }

  @override
  void write(BinaryWriter writer, CountriesData obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.countriesData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountriesDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
