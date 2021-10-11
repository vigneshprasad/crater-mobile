// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_field_detail.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserProfileFieldDetailModelAdapter
    extends TypeAdapter<UserProfileFieldDetailModel> {
  @override
  final int typeId = 20;

  @override
  UserProfileFieldDetailModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProfileFieldDetailModel(
      name: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserProfileFieldDetailModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileFieldDetailModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileFieldDetailModel _$UserProfileFieldDetailModelFromJson(
    Map<String, dynamic> json) {
  return UserProfileFieldDetailModel(
    name: json['name'] as String?,
  );
}

Map<String, dynamic> _$UserProfileFieldDetailModelToJson(
        UserProfileFieldDetailModel instance) =>
    <String, dynamic>{
      'name': instance.name,
    };
