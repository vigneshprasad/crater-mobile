// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_tag_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VideoTagModelAdapter extends TypeAdapter<VideoTagModel> {
  @override
  final int typeId = 25;

  @override
  VideoTagModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VideoTagModel(
      pk: fields[0] as int,
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VideoTagModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.pk)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoTagModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoTagModel _$VideoTagModelFromJson(Map<String, dynamic> json) {
  return VideoTagModel(
    pk: json['pk'] as int,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$VideoTagModelToJson(VideoTagModel instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'name': instance.name,
    };
