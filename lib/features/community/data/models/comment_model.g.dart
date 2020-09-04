// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommentModelAdapter extends TypeAdapter<CommentModel> {
  @override
  final int typeId = 29;

  @override
  CommentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CommentModel(
      pk: fields[0] as int,
      message: fields[1] as String,
      creatorId: fields[2] as String,
      creatorName: fields[3] as String,
      creatorPhoto: fields[4] as String,
      created: fields[5] as DateTime,
      postId: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CommentModel obj) {
    writer
      ..writeByte(7)
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
      ..write(obj.created)
      ..writeByte(6)
      ..write(obj.postId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) {
  return CommentModel(
    pk: json['pk'] as int,
    message: json['message'] as String,
    creatorId: json['creator_id'] as String,
    creatorName: json['creator_name'] as String,
    creatorPhoto: json['creator_photo'] as String,
    created: json['created'] == null
        ? null
        : DateTime.parse(json['created'] as String),
    postId: json['postId'] as int,
  );
}

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'message': instance.message,
      'creator_id': instance.creatorId,
      'creator_name': instance.creatorName,
      'creator_photo': instance.creatorPhoto,
      'created': instance.created?.toIso8601String(),
      'postId': instance.postId,
    };
