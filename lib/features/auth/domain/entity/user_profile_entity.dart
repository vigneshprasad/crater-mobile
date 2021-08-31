import 'package:hive/hive.dart';

import 'user_tag_entity.dart';

class UserProfile extends HiveObject {
  final int? pk;
  final String? additionalInformation;
  final int? cover;
  final String? coverFile;
  final String? coverThumbnail;
  final String? coverTranscoder;
  final String? focus;
  final String? instagram;
  final String? instagramId;
  final String? instagramUsername;
  final String? introduction;
  final bool? isCoverVideo;
  final bool? isInstagramSet;
  final String? linkedinUrl;
  final String? name;
  final String? photo;
  final String? photoUrl;
  final String? publicIntroduction;
  final bool? publicProfile;
  final String? role;
  final String? tagLine;
  final List<int>? tags;
  final List<UserTag>? tagList;
  final String? uuid;
  final int? educationLevel;
  final int? yearsOfExperience;
  final int? companyType;
  final int? sector;
  final int? numberOfEmployees;
  final int? projectType;
  final int? stageOfCompany;
  final int? aspiration;
  final bool? profileIntroUpdated;
  final String? companyName;
  final bool? allowMeetingRequest;

  UserProfile({
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
    this.tags,
    this.tagLine,
    this.tagList,
    this.uuid,
    this.educationLevel,
    this.yearsOfExperience,
    this.companyType,
    this.sector,
    this.numberOfEmployees,
    this.projectType,
    this.stageOfCompany,
    this.aspiration,
    this.profileIntroUpdated,
    this.companyName,
    this.allowMeetingRequest,
  });
}
