// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_notification_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ConversationNotificationData _$$_ConversationNotificationDataFromJson(
        Map<String, dynamic> json) =>
    _$_ConversationNotificationData(
      type: $enumDecode(_$PushTypeEnumMap, json['obj_type']),
      groupId: json['group_id'] ?? PushType.conversation,
    );

Map<String, dynamic> _$$_ConversationNotificationDataToJson(
        _$_ConversationNotificationData instance) =>
    <String, dynamic>{
      'obj_type': _$PushTypeEnumMap[instance.type]!,
      'group_id': instance.groupId,
    };

const _$PushTypeEnumMap = {
  PushType.chatMessage: 'message',
  PushType.conversation: 'conversation',
  PushType.upcomingMeeting: 'upcoming_meeting',
  PushType.createConversation: 'create_conversation',
};
