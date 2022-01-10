import 'package:freezed_annotation/freezed_annotation.dart';

import '../conversation_entity/conversation_entity.dart';

part 'conversation_request_entity.freezed.dart';
part 'conversation_request_entity.g.dart';

enum ParticpantType {
  @JsonValue(1)
  speaker,
  @JsonValue(2)
  attendee,
}

enum RequestStatus {
  @JsonValue(0)
  pending,
  @JsonValue(1)
  accepted,
  @JsonValue(2)
  declined,
}

@freezed
abstract class ConversationRequest with _$ConversationRequest {
  factory ConversationRequest({
    int? pk,
    int? group,
    @JsonKey(name: "group_detail") Conversation? groupDetail,
    @JsonKey(name: "participant_type") ParticpantType? participantType,
    RequestStatus? status,
  }) = _ConversationRequest;

  factory ConversationRequest.fromJson(Map<String, dynamic> json) =>
      _$ConversationRequestFromJson(json);
}
