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
