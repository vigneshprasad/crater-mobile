// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommentAdapter extends TypeAdapter<Comment> {
  @override
  final int typeId = 3;

  @override
  Comment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Comment(
      pk: fields[0] as int,
      message: fields[1] as String,
      creatorId: fields[2] as String,
      creatorName: fields[3] as String,
      creatorPhoto: fields[4] as String,
      created: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Comment obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.pk)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.creatorId)
      ..writeByte(3)
      ..write(obj.creatorName)
      ..writeByte(4)
      ..write(obj.creatorPhoto)
      ..writeByte(5)
      ..write(obj.created);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(
    pk: json['pk'] as int,
    message: json['message'] as String,
    creatorId: json['creator_id'] as String,
    creatorName: json['creator_name'] as String,
    creatorPhoto: json['creator_photo'] as String,
    created: json['created'] as String,
  );
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'pk': instance.pk,
      'message': instance.message,
      'creator_id': instance.creatorId,
      'creator_name': instance.creatorName,
      'creator_photo': instance.creatorPhoto,
      'created': instance.created,
    };
