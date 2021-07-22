// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_notification_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ConversationNotificationData _$_$_ConversationNotificationDataFromJson(
    Map<String, dynamic> json) {
  return _$_ConversationNotificationData(
    type: _$enumDecode(_$PushTypeEnumMap, json['obj_type']),
    groupId: json['group_id'],
  );
}

Map<String, dynamic> _$_$_ConversationNotificationDataToJson(
        _$_ConversationNotificationData instance) =>
    <String, dynamic>{
      'obj_type': _$PushTypeEnumMap[instance.type],
      'group_id': instance.groupId,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$PushTypeEnumMap = {
  PushType.chatMessage: 'message',
  PushType.conversation: 'conversation',
  PushType.upcomingMeeting: 'upcoming_meeting',
  PushType.createConversation: 'create_conversation',
};
