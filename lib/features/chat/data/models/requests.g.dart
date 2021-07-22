// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requests.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetChatRequestParams _$SetChatRequestParamsFromJson(Map<String, dynamic> json) {
  return SetChatRequestParams(
    user: json['user'] as String,
    page: json['page'] as int,
  );
}

Map<String, dynamic> _$SetChatRequestParamsToJson(
        SetChatRequestParams instance) =>
    <String, dynamic>{
      'user': instance.user,
      'page': instance.page,
    };

SetChatRequest _$SetChatRequestFromJson(Map<String, dynamic> json) {
  return SetChatRequest(
    type: _$enumDecode(_$WSRequestTypeEnumMap, json['type'],
        unknownValue: WSRequestType.unknownValue),
    message:
        SetChatRequestParams.fromJson(json['message'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SetChatRequestToJson(SetChatRequest instance) =>
    <String, dynamic>{
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

ChatMessageRequest _$ChatMessageRequestFromJson(Map<String, dynamic> json) {
  return ChatMessageRequest(
    type: _$enumDecode(_$WSRequestTypeEnumMap, json['type'],
        unknownValue: WSRequestType.unknownValue),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$ChatMessageRequestToJson(ChatMessageRequest instance) =>
    <String, dynamic>{
      'type': _$WSRequestTypeEnumMap[instance.type],
      'message': instance.message,
    };

UserTypingRequest _$UserTypingRequestFromJson(Map<String, dynamic> json) {
  return UserTypingRequest(
    type: _$enumDecode(_$WSRequestTypeEnumMap, json['type'],
        unknownValue: WSRequestType.unknownValue),
  );
}

Map<String, dynamic> _$UserTypingRequestToJson(UserTypingRequest instance) =>
    <String, dynamic>{
      'type': _$WSRequestTypeEnumMap[instance.type],
    };

ReadUserMessagesRequest _$ReadUserMessagesRequestFromJson(
    Map<String, dynamic> json) {
  return ReadUserMessagesRequest(
    type: _$enumDecode(_$WSRequestTypeEnumMap, json['type'],
        unknownValue: WSRequestType.unknownValue),
  );
}

Map<String, dynamic> _$ReadUserMessagesRequestToJson(
        ReadUserMessagesRequest instance) =>
    <String, dynamic>{
      'type': _$WSRequestTypeEnumMap[instance.type],
    };
