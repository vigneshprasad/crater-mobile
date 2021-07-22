// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_provider_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PackageProviderModelAdapter extends TypeAdapter<PackageProviderModel> {
  @override
  final int typeId = 17;

  @override
  PackageProviderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PackageProviderModel(
      name: fields[0] as String?,
      description: fields[1] as String?,
      logo: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PackageProviderModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.logo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PackageProviderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageProviderModel _$PackageProviderModelFromJson(Map<String, dynamic> json) {
  return PackageProviderModel(
    name: json['name'] as String?,
    description: json['description'] as String?,
    logo: json['logo'] as String?,
  );
}

Map<String, dynamic> _$PackageProviderModelToJson(
        PackageProviderModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'logo': instance.logo,
    };
