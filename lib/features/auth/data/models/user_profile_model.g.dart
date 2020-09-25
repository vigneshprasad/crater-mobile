// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserProfileModelAdapter extends TypeAdapter<UserProfileModel> {
  @override
  final int typeId = 13;

  @override
  UserProfileModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProfileModel(
      pk: fields[0] as int,
      additionalInformation: fields[1] as String,
      cover: fields[2] as int,
      coverFile: fields[3] as String,
      coverThumbnail: fields[4] as String,
      coverTranscoder: fields[5] as String,
      focus: fields[6] as String,
      instagram: fields[7] as String,
      instagramId: fields[8] as String,
      instagramUsername: fields[9] as String,
      introduction: fields[10] as String,
      isCoverVideo: fields[11] as bool,
      isInstagramSet: fields[12] as bool,
      linkedinUrl: fields[13] as String,
      name: fields[14] as String,
      photo: fields[15] as String,
      photoUrl: fields[16] as String,
      publicIntroduction: fields[17] as String,
      publicProfile: fields[18] as bool,
      role: fields[19] as String,
      tagLine: fields[20] as String,
      tagList: (fields[21] as List)?.cast<UserTagModel>(),
      uuid: fields[22] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserProfileModel obj) {
    writer
      ..writeByte(23)
      ..writeByte(0)
      ..write(obj.pk)
      ..writeByte(1)
      ..write(obj.additionalInformation)
      ..writeByte(2)
      ..write(obj.cover)
      ..writeByte(3)
      ..write(obj.coverFile)
      ..writeByte(4)
      ..write(obj.coverThumbnail)
      ..writeByte(5)
      ..write(obj.coverTranscoder)
      ..writeByte(6)
      ..write(obj.focus)
      ..writeByte(7)
      ..write(obj.instagram)
      ..writeByte(8)
      ..write(obj.instagramId)
      ..writeByte(9)
      ..write(obj.instagramUsername)
      ..writeByte(10)
      ..write(obj.introduction)
      ..writeByte(11)
      ..write(obj.isCoverVideo)
      ..writeByte(12)
      ..write(obj.isInstagramSet)
      ..writeByte(13)
      ..write(obj.linkedinUrl)
      ..writeByte(14)
      ..write(obj.name)
      ..writeByte(15)
      ..write(obj.photo)
      ..writeByte(16)
      ..write(obj.photoUrl)
      ..writeByte(17)
      ..write(obj.publicIntroduction)
      ..writeByte(18)
      ..write(obj.publicProfile)
      ..writeByte(19)
      ..write(obj.role)
      ..writeByte(20)
      ..write(obj.tagLine)
      ..writeByte(21)
      ..write(obj.tagList)
      ..writeByte(22)
      ..write(obj.uuid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) {
  return UserProfileModel(
    pk: json['pk'] as int,
    additionalInformation: json['additional_information'] as String,
    cover: json['cover'] as int,
    coverFile: json['cover_file'] as String,
    coverThumbnail: json['cover_thumbnail'] as String,
    coverTranscoder: json['cover_transcoder'] as String,
    focus: json['focus'] as String,
    instagram: json['instagram'] as String,
    instagramId: json['instagram_id'] as String,
    instagramUsername: json['instagram_username'] as String,
    introduction: json['introduction'] as String,
    isCoverVideo: json['is_cover_video'] as bool,
    isInstagramSet: json['is_instagram_set'] as bool,
    linkedinUrl: json['linkedin_url'] as String,
    name: json['name'] as String,
    photo: json['photo'] as String,
    photoUrl: json['photoUrl'] as String,
    publicIntroduction: json['public_introduction'] as String,
    publicProfile: json['public_profile'] as bool,
    role: json['role'] as String,
    tagLine: json['tag_line'] as String,
    tagList: (json['tag_list'] as List)
        ?.map((e) =>
            e == null ? null : UserTagModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    uuid: json['uuid'] as String,
  );
}

Map<String, dynamic> _$UserProfileModelToJson(UserProfileModel instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'additional_information': instance.additionalInformation,
      'cover': instance.cover,
      'cover_file': instance.coverFile,
      'cover_thumbnail': instance.coverThumbnail,
      'cover_transcoder': instance.coverTranscoder,
      'focus': instance.focus,
      'instagram': instance.instagram,
      'instagram_id': instance.instagramId,
      'instagram_username': instance.instagramUsername,
      'introduction': instance.introduction,
      'is_cover_video': instance.isCoverVideo,
      'is_instagram_set': instance.isInstagramSet,
      'linkedin_url': instance.linkedinUrl,
      'name': instance.name,
      'photo': instance.photo,
      'photoUrl': instance.photoUrl,
      'public_introduction': instance.publicIntroduction,
      'public_profile': instance.publicProfile,
      'role': instance.role,
      'tag_line': instance.tagLine,
      'tag_list': instance.tagList,
      'uuid': instance.uuid,
    };
