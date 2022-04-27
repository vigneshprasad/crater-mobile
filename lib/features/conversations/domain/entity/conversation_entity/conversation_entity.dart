import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:worknetwork/features/connection/data/models/creator_response.dart';

import '../../../../meeting/data/models/meeting_interest_model.dart';
import '../topic_entity/topic_entity.dart';

part 'conversation_entity.freezed.dart';
part 'conversation_entity.g.dart';

enum ConversationPrivacy {
  @JsonValue(0)
  public,
  @JsonValue(1)
  private,
}

enum ConversationMedium {
  @JsonValue(0)
  audio,
  @JsonValue(1)
  audioVideo,
}

@freezed
abstract class Conversation with _$Conversation {
  factory Conversation({
    int? id,
    String? host,
    List<String>? speakers,
    List<String>? attendees,
    int? topic,
    String? description,
    List<int>? interests,
    DateTime? start,
    DateTime? end,
    @JsonKey(name: 'max_speakers') int? maxSpeakers,
    ConversationPrivacy? privacy,
    ConversationMedium? medium,
    bool? closed,
    int? relevancy,
    @JsonKey(name: 'closed_at') DateTime? closedAt,
    @JsonKey(name: 'topic_detail') Topic? topicDetail,
    @JsonKey(name: 'host_detail') ConversationUser? hostDetail,
    @JsonKey(name: 'interests_detail_list')
        List<MeetingInterestModel>? interestsDetailList,
    @JsonKey(name: 'speakers_detail_list')
        List<ConversationUser>? speakersDetailList,
    @JsonKey(name: 'attendees_detail_list')
        List<ConversationUser>? attendeesDetailList,
    @JsonKey(name: 'is_speaker') bool? isSpeaker,
    @JsonKey(name: 'is_past') bool? isPast,
    @JsonKey(name: 'recording_details') RecordingDetails? recordingDetails,
  }) = _Conversation;

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);
}

@freezed
abstract class RecordingDetails with _$RecordingDetails {
  factory RecordingDetails({
    String? recording,
  }) = _RecordingDetails;

  factory RecordingDetails.fromJson(Map<String, dynamic> json) =>
      _$RecordingDetailsFromJson(json);
}

@freezed
abstract class ConversationUser with _$ConversationUser {
  factory ConversationUser({
    String? pk,
    String? email,
    String? name,
    String? photo,
    String? introduction,
    @JsonKey(name: 'creator_detail') Creator? creatorDetail,
  }) = _ConversationUser;

  factory ConversationUser.fromJson(Map<String, dynamic> json) =>
      _$ConversationUserFromJson(json);
}

@freezed
abstract class ConversationByDate with _$ConversationByDate {
  factory ConversationByDate({
    DateTime? date,
    List<Conversation>? conversations,
  }) = _ConversationByDate;

  factory ConversationByDate.fromJson(Map<String, dynamic> json) =>
      _$ConversationByDateFromJson(json);
}

@freezed
abstract class UserPermission with _$UserPermission {
  factory UserPermission({
    @JsonKey(name: 'allow_create_stream') bool? allowCreateStream,
    @JsonKey(name: 'allow_chat') bool? allowChat,
  }) = _UserPermission;

  factory UserPermission.fromJson(Map<String, dynamic> json) =>
      _$UserPermissionFromJson(json);
}