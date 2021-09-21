// To parse this JSON data, do
//
//     final webinar = webinarFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import '../conversation_entity/conversation_entity.dart';
import '../topic_entity/topic_entity.dart';

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
    DateTime? closedAt,
    Topic? topicDetail,
    ConversationUser? hostDetail,
    int? type,
    bool? isLive,
    int? liveCount,
    bool? rsvp,
  }) = _Webinar;

  factory Webinar.fromJson(Map<String, dynamic> json) =>
      _$WebinarFromJson(json);
}
