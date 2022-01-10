// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VideoModelAdapter extends TypeAdapter<VideoModel> {
  @override
  final int typeId = 5;

  @override
  VideoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VideoModel(
      pk: fields[0] as int?,
      author: fields[1] as String?,
      cover: fields[2] as String?,
      created: fields[3] as String?,
      description: fields[4] as String?,
      position: fields[5] as String?,
      thumbnail: fields[6] as String?,
      tags: (fields[7] as List?)?.cast<VideoTagModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, VideoModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.pk)
      ..writeByte(1)
      ..write(obj.author)
      ..writeByte(2)
      ..write(obj.cover)
      ..writeByte(3)
      ..write(obj.created)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.position)
      ..writeByte(6)
      ..write(obj.thumbnail)
      ..writeByte(7)
      ..write(obj.tags);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoModel _$VideoModelFromJson(Map<String, dynamic> json) {
  return VideoModel(
    pk: json['pk'] as int?,
    author: json['author'] as String?,
    cover: json['cover'] as String?,
    created: json['created'] as String?,
    description: json['description'] as String?,
    position: json['position'] as String?,
    thumbnail: json['thumbnail'] as String?,
    tags: (json['tags'] as List<dynamic>?)
        ?.map((e) => VideoTagModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$VideoModelToJson(VideoModel instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'author': instance.author,
      'cover': instance.cover,
      'created': instance.created,
      'description': instance.description,
      'position': instance.position,
      'thumbnail': instance.thumbnail,
      'tags': instance.tags,
    };
