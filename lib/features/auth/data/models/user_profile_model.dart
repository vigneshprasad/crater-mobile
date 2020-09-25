import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../constants/app_hive_boxes.dart';
import '../../domain/entity/user_profile_entity.dart';
import 'user_tag_model.dart';

part 'user_profile_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

@HiveType(typeId: AppHiveTypeIds.userProfile)
@JsonSerializable()
class UserProfileModel extends UserProfile {
  @HiveField(0)
  final int pk;

  @HiveField(1)
  @JsonKey(name: "additional_information")
  final String additionalInformation;

  @HiveField(2)
  final int cover;

  @HiveField(3)
  @JsonKey(name: "cover_file")
  final String coverFile;

  @HiveField(4)
  @JsonKey(name: "cover_thumbnail")
  final String coverThumbnail;

  @HiveField(5)
  @JsonKey(name: "cover_transcoder")
  final String coverTranscoder;

  @HiveField(6)
  final String focus;

  @HiveField(7)
  final String instagram;

  @HiveField(8)
  @JsonKey(name: "instagram_id")
  final String instagramId;

  @HiveField(9)
  @JsonKey(name: "instagram_username")
  final String instagramUsername;

  @HiveField(10)
  final String introduction;

  @HiveField(11)
  @JsonKey(name: "is_cover_video")
  final bool isCoverVideo;

  @HiveField(12)
  @JsonKey(name: "is_instagram_set")
  final bool isInstagramSet;

  @HiveField(13)
  @JsonKey(name: "linkedin_url")
  final String linkedinUrl;

  @HiveField(14)
  final String name;

  @HiveField(15)
  final String photo;

  @HiveField(16)
  final String photoUrl;

  @HiveField(17)
  @JsonKey(name: "public_introduction")
  final String publicIntroduction;

  @HiveField(18)
  @JsonKey(name: "public_profile")
  final bool publicProfile;

  @HiveField(19)
  final String role;

  @HiveField(20)
  @JsonKey(name: "tag_line")
  final String tagLine;

  @HiveField(21)
  @JsonKey(name: "tag_list")
  final List<UserTagModel> tagList;

  @HiveField(22)
  final String uuid;

  UserProfileModel({
    this.pk,
    this.additionalInformation,
    this.cover,
    this.coverFile,
    this.coverThumbnail,
    this.coverTranscoder,
    this.focus,
    this.instagram,
    this.instagramId,
    this.instagramUsername,
    this.introduction,
    this.isCoverVideo,
    this.isInstagramSet,
    this.linkedinUrl,
    this.name,
    this.photo,
    this.photoUrl,
    this.publicIntroduction,
    this.publicProfile,
    this.role,
    this.tagLine,
    this.tagList,
    this.uuid,
  }) : super(
          pk: pk,
          additionalInformation: additionalInformation,
          cover: cover,
          coverFile: coverFile,
          coverThumbnail: coverThumbnail,
          coverTranscoder: coverTranscoder,
          focus: focus,
          instagram: instagram,
          instagramId: instagramId,
          instagramUsername: instagramUsername,
          introduction: introduction,
          isCoverVideo: isCoverVideo,
          isInstagramSet: isInstagramSet,
          linkedinUrl: linkedinUrl,
          name: name,
          photo: photo,
          photoUrl: photoUrl,
          publicIntroduction: publicIntroduction,
          publicProfile: publicProfile,
          role: role,
          tagLine: tagLine,
          tagList: tagList,
          uuid: uuid,
        );

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);
}
