// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_tag_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserTagModelAdapter extends TypeAdapter<UserTagModel> {
  @override
  final int typeId = 14;

  @override
  UserTagModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserTagModel(
      name: fields[0] as String?,
      pk: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, UserTagModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.pk);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserTagModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTagModel _$UserTagModelFromJson(Map<String, dynamic> json) {
  return UserTagModel(
    name: json['name'] as String?,
    pk: json['pk'] as int?,
  );
}

Map<String, dynamic> _$UserTagModelToJson(UserTagModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'pk': instance.pk,
    };
