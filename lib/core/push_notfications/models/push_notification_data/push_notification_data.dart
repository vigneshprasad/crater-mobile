import 'package:freezed_annotation/freezed_annotation.dart';

part 'push_notification_data.freezed.dart';
part 'push_notification_data.g.dart';

PushType enumFromType(dynamic source) {
  return _$enumDecode(_$PushTypeEnumMap, source);
}

enum PushType {
  @JsonValue("message")
  chatMessage,
  @JsonValue("conversation")
  conversation,
  @JsonValue("upcoming_meeting")
  upcomingMeeting,
  @JsonValue("create_conversation")
  createConversation,
}

abstract class PushNotificationBase {
  PushType get type;
}

@freezed
abstract class ConversationNotificationData
    with _$ConversationNotificationData {
  @Implements(PushNotificationBase)
  factory ConversationNotificationData({
    @JsonKey(name: "obj_type") required PushType type,
    @Default(PushType.conversation) @JsonKey(name: "group_id") groupId,
  }) = _ConversationNotificationData;

  factory ConversationNotificationData.fromJson(Map<String, dynamic> json) =>
      _$ConversationNotificationDataFromJson(json);
}
