// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_notification_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ConversationNotificationData _$_$_ConversationNotificationDataFromJson(
    Map<String, dynamic> json) {
  return _$_ConversationNotificationData(
    type: _$enumDecodeNullable(_$PushTypeEnumMap, json['obj_type']),
    groupId: json['group_id'],
  );
}

Map<String, dynamic> _$_$_ConversationNotificationDataToJson(
        _$_ConversationNotificationData instance) =>
    <String, dynamic>{
      'obj_type': _$PushTypeEnumMap[instance.type],
      'group_id': instance.groupId,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$PushTypeEnumMap = {
  PushType.chatMessage: 'message',
  PushType.conversation: 'conversation',
  PushType.upcomingMeeting: 'upcoming_meeting',
  PushType.createConversation: 'create_conversation',
};
