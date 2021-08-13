import 'package:freezed_annotation/freezed_annotation.dart';

import '../conversation_entity/conversation_entity.dart';

part 'conversation_request_entity.freezed.dart';
part 'conversation_request_entity.g.dart';

@freezed
abstract class ConversationRequest with _$ConversationRequest {
  factory ConversationRequest({
    int? pk,
    int? group,
    @JsonKey(name: "group_detail") Conversation? groupDetail,
  }) = _ConversationRequest;

  factory ConversationRequest.fromJson(Map<String, dynamic> json) =>
      _$ConversationRequestFromJson(json);
}
