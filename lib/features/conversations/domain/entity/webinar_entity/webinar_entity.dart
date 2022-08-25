// To parse this JSON data, do
//
//     final webinar = webinarFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:worknetwork/features/conversations/domain/entity/conversation_entity/conversation_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/topic_entity/topic_entity.dart';

part 'webinar_entity.freezed.dart';
part 'webinar_entity.g.dart';

@freezed
abstract class Webinar with _$Webinar {
  const factory Webinar({
    int? id,
    String? host,
    String? description,
    DateTime? start,
    int? privacy,
    int? medium,
    bool? closed,
    @JsonKey(name: 'closed_at') DateTime? closedAt,
    @JsonKey(name: 'topic_detail') Topic? topicDetail,
    @JsonKey(name: 'host_detail') ConversationUser? hostDetail,
    int? type,
    @JsonKey(name: 'is_live') bool? isLive,
    @JsonKey(name: 'is_past') bool? isPast,
    @JsonKey(name: 'recording_details') RecordingDetails? recordingDetails,
    @JsonKey(name: 'speakers_detail_list')
        List<ConversationUser>? speakersDetailList,
    int? liveCount,
    bool? rsvp,
  }) = _Webinar;

  factory Webinar.fromJson(Map<String, dynamic> json) =>
      _$WebinarFromJson(json);
}
