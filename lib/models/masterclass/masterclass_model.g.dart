// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'masterclass_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MasterClassAdapter extends TypeAdapter<MasterClass> {
  @override
  final int typeId = 5;

  @override
  MasterClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MasterClass(
      pk: fields[0] as int,
      author: fields[1] as String,
      cover: fields[2] as String,
      created: fields[3] as String,
      description: fields[4] as String,
      position: fields[5] as String,
      thumbnail: fields[6] as String,
      tags: (fields[7] as List)?.cast<VideoTag>(),
    );
  }

  @override
  void write(BinaryWriter writer, MasterClass obj) {
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
      other is MasterClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MasterClass _$MasterClassFromJson(Map<String, dynamic> json) {
  return MasterClass(
    pk: json['pk'] as int,
    author: json['author'] as String,
    cover: json['cover'] as String,
    created: json['created'] as String,
    description: json['description'] as String,
    position: json['position'] as String,
    thumbnail: json['thumbnail'] as String,
    tags: (json['tags'] as List)
        ?.map((e) =>
            e == null ? null : VideoTag.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MasterClassToJson(MasterClass instance) =>
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

VideoTag _$VideoTagFromJson(Map<String, dynamic> json) {
  return VideoTag(
    pk: json['pk'] as int,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$VideoTagToJson(VideoTag instance) => <String, dynamic>{
      'pk': instance.pk,
      'name': instance.name,
    };
