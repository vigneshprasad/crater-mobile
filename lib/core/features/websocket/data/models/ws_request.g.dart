// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ws_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WSRequest _$WSRequestFromJson(Map<String, dynamic> json) {
  return WSRequest(
    type: _$enumDecodeNullable(_$WSRequestTypeEnumMap, json['type'],
        unknownValue: WSRequestType.unknownValue),
    message: json['message'],
  );
}

Map<String, dynamic> _$WSRequestToJson(WSRequest instance) => <String, dynamic>{
      'type': _$WSRequestTypeEnumMap[instance.type],
      'message': instance.message,
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

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$WSRequestTypeEnumMap = {
  WSRequestType.setUserChat: 'set_user_chat',
  WSRequestType.sendMessageToUser: 'send_user_message_to_user',
  WSRequestType.userIsTyping: 'user_is_typing',
  WSRequestType.readUserMessages: 'user_read_user_messages',
  WSRequestType.getAllUsers: 'get_all_users',
  WSRequestType.starChatUser: 'star_user',
  WSRequestType.unStarChatUser: 'unstar_user',
  WSRequestType.unknownValue: 'unknownValue',
};

WSGroupRequest _$WSGroupRequestFromJson(Map<String, dynamic> json) {
  return WSGroupRequest(
    type: _$enumDecodeNullable(_$WSGroupRequestTypeEnumMap, json['type'],
        unknownValue: WSGroupRequestType.unknownValue),
    payload: json['payload'],
  );
}

Map<String, dynamic> _$WSGroupRequestToJson(WSGroupRequest instance) =>
    <String, dynamic>{
      'type': _$WSGroupRequestTypeEnumMap[instance.type],
      'payload': instance.payload,
    };

const _$WSGroupRequestTypeEnumMap = {
  WSGroupRequestType.sendGroupMessage: 'send_group_message',
  WSGroupRequestType.unknownValue: 'unknownValue',
};
