import 'package:freezed_annotation/freezed_annotation.dart';

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
    int? topic,
    String? description,
    List<int>? interests,
    required DateTime start,
    DateTime? end,
    @JsonKey(name: 'max_speakers') required int maxSpeakers,
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
    @JsonKey(name: 'is_speaker') bool? isSpeaker,
    @JsonKey(name: 'is_past') bool? isPast,
  }) = _Conversation;

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);
}

@freezed
abstract class ConversationUser with _$ConversationUser {
  factory ConversationUser({
    required String pk,
    String? email,
    String? name,
    String? photo,
    String? introduction,
  }) = _ConversationUser;

  factory ConversationUser.fromJson(Map<String, dynamic> json) =>
      _$ConversationUserFromJson(json);
}

@freezed
abstract class ConversationByDate with _$ConversationByDate {
  factory ConversationByDate({
    required DateTime date,
    required List<Conversation> conversations,
  }) = _ConversationByDate;

  factory ConversationByDate.fromJson(Map<String, dynamic> json) =>
      _$ConversationByDateFromJson(json);
}
