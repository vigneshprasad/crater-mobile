// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostModelAdapter extends TypeAdapter<PostModel> {
  @override
  final int typeId = 9;

  @override
  PostModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostModel(
      pk: fields[0] as int,
      message: fields[1] as String?,
      group: fields[2] as int?,
      groupName: fields[3] as String?,
      filesUrls: (fields[4] as List?)?.cast<String>(),
      filesData: (fields[5] as List?)?.cast<FileDataModel>(),
      creator: fields[6] as String?,
      creatorName: fields[7] as String?,
      isCreatorApproved: fields[8] as bool?,
      creatorPhoto: fields[9] as String?,
      created: fields[10] as String?,
      likes: fields[11] as int?,
      myLike: fields[12] as bool?,
      isFollowed: fields[13] as bool?,
      isReported: fields[14] as bool?,
      comments: fields[15] as int?,
      latestComments: (fields[16] as List?)?.cast<CommentModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, PostModel obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.pk)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.group)
      ..writeByte(3)
      ..write(obj.groupName)
      ..writeByte(4)
      ..write(obj.filesUrls)
      ..writeByte(5)
      ..write(obj.filesData)
      ..writeByte(6)
      ..write(obj.creator)
      ..writeByte(7)
      ..write(obj.creatorName)
      ..writeByte(8)
      ..write(obj.isCreatorApproved)
      ..writeByte(9)
      ..write(obj.creatorPhoto)
      ..writeByte(10)
      ..write(obj.created)
      ..writeByte(11)
      ..write(obj.likes)
      ..writeByte(12)
      ..write(obj.myLike)
      ..writeByte(13)
      ..write(obj.isFollowed)
      ..writeByte(14)
      ..write(obj.isReported)
      ..writeByte(15)
      ..write(obj.comments)
      ..writeByte(16)
      ..write(obj.latestComments);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FileDataModelAdapter extends TypeAdapter<FileDataModel> {
  @override
  final int typeId = 12;

  @override
  FileDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FileDataModel(
      file: fields[0] as String,
      isVideo: fields[1] as bool,
      thumbnail: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FileDataModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.file)
      ..writeByte(1)
      ..write(obj.isVideo)
      ..writeByte(2)
      ..write(obj.thumbnail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FileDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) {
  return PostModel(
    pk: json['pk'] as int,
    message: json['message'] as String?,
    group: json['group'] as int?,
    groupName: json['group_name'] as String?,
    filesUrls: (json['files_urls'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    filesData: (json['files_data'] as List<dynamic>?)
        ?.map((e) => FileDataModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    creator: json['creator'] as String?,
    creatorName: json['creator_name'] as String?,
    isCreatorApproved: json['is_creator_approved'] as bool?,
    creatorPhoto: json['creator_photo'] as String?,
    created: json['created'] as String?,
    likes: json['likes'] as int?,
    myLike: json['my_like'] as bool?,
    isFollowed: json['is_followed'] as bool?,
    isReported: json['is_reported'] as bool?,
    comments: json['comments'] as int?,
    latestComments: (json['latest_comments'] as List<dynamic>?)
        ?.map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'pk': instance.pk,
      'message': instance.message,
      'group': instance.group,
      'group_name': instance.groupName,
      'files_urls': instance.filesUrls,
      'files_data': instance.filesData,
      'creator': instance.creator,
      'creator_name': instance.creatorName,
      'is_creator_approved': instance.isCreatorApproved,
      'creator_photo': instance.creatorPhoto,
      'created': instance.created,
      'likes': instance.likes,
      'my_like': instance.myLike,
      'is_followed': instance.isFollowed,
      'is_reported': instance.isReported,
      'comments': instance.comments,
      'latest_comments': instance.latestComments,
    };

FileDataModel _$FileDataModelFromJson(Map<String, dynamic> json) {
  return FileDataModel(
    file: json['file'] as String,
    isVideo: json['is_video'] as bool,
    thumbnail: json['thumbnail'] as String,
  );
}

Map<String, dynamic> _$FileDataModelToJson(FileDataModel instance) =>
    <String, dynamic>{
      'file': instance.file,
      'is_video': instance.isVideo,
      'thumbnail': instance.thumbnail,
    };
