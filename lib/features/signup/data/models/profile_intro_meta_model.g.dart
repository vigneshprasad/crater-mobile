// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_intro_meta_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileIntroMetaModelAdapter extends TypeAdapter<ProfileIntroMetaModel> {
  @override
  final int typeId = 14;

  @override
  ProfileIntroMetaModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProfileIntroMetaModel();
  }

  @override
  void write(BinaryWriter writer, ProfileIntroMetaModel obj) {
    writer..writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileIntroMetaModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileIntroMetaModel _$ProfileIntroMetaModelFromJson(
    Map<String, dynamic> json) {
  return ProfileIntroMetaModel(
    value: json['value'] as int,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$ProfileIntroMetaModelToJson(
        ProfileIntroMetaModel instance) =>
    <String, dynamic>{
      'value': instance.value,
      'name': instance.name,
    };
