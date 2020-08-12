// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ws_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WSGetAllUsersResponse _$WSGetAllUsersResponseFromJson(
    Map<String, dynamic> json) {
  return WSGetAllUsersResponse(
    type: _$enumDecodeNullable(_$WSResponseTypeEnumMap, json['type'],
        unknownValue: WSResponseType.unknowType),
    errors: json['errors'],
    page: json['page'] as int,
    pages: json['pages'] as int,
    results: (json['results'] as List)
        ?.map((e) =>
            e == null ? null : ChatUser.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$WSGetAllUsersResponseToJson(
        WSGetAllUsersResponse instance) =>
    <String, dynamic>{
      'type': _$WSResponseTypeEnumMap[instance.type],
      'errors': instance.errors,
      'page': instance.page,
      'pages': instance.pages,
      'results': instance.results,
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

const _$WSResponseTypeEnumMap = {
  WSResponseType.loadAllUsers: 'all_users',
  WSResponseType.loadChatMessages: 'get_user_messages',
  WSResponseType.getUserNotification: 'user_notification',
  WSResponseType.unknowType: 'unknown_type',
};

WSGetChatMessagesResponse _$WSGetChatMessagesResponseFromJson(
    Map<String, dynamic> json) {
  return WSGetChatMessagesResponse(
    type: _$enumDecodeNullable(_$WSResponseTypeEnumMap, json['type'],
        unknownValue: WSResponseType.unknowType),
    user: json['user'] as String,
    introduction: json['introduction'] as String,
    name: json['name'] as String,
    page: json['page'] as int,
    pages: json['pages'] as int,
    results: (json['results'] as List)
        ?.map((e) =>
            e == null ? null : ChatMessage.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    userData: json['user_data'] == null
        ? null
        : ChatUser.fromJson(json['user_data'] as Map<String, dynamic>),
    additionalInformation: json['additional_information'] as String,
    tagLine: json['tag_line'] as String,
  );
}

Map<String, dynamic> _$WSGetChatMessagesResponseToJson(
        WSGetChatMessagesResponse instance) =>
    <String, dynamic>{
      'type': _$WSResponseTypeEnumMap[instance.type],
      'user': instance.user,
      'introduction': instance.introduction,
      'name': instance.name,
      'page': instance.page,
      'pages': instance.pages,
      'results': instance.results,
      'user_data': instance.userData,
      'additional_information': instance.additionalInformation,
      'tag_line': instance.tagLine,
    };

WSGetUserNotification _$WSGetUserNotificationFromJson(
    Map<String, dynamic> json) {
  return WSGetUserNotification(
    type: _$enumDecodeNullable(_$WSResponseTypeEnumMap, json['type'],
        unknownValue: WSResponseType.unknowType),
    pk: json['pk'] as String,
    created: json['created'] as String,
    name: json['name'] as String,
    photo: json['photo'] as String,
    message: json['message'] as String,
    senderName: json['sender'] as String,
    receiverName: json['receiver'] as String,
    isStarred: json['is_starred'] as bool,
    latestMessage: json['latest_message'] == null
        ? null
        : ChatMessage.fromJson(json['latest_message'] as Map<String, dynamic>),
    messageId: json['message_id'] as int,
    recieverId: json['receiver_id'] as String,
    senderId: json['sender_id'] as String,
    unreadCount: json['unread_count'] as int,
  );
}

Map<String, dynamic> _$WSGetUserNotificationToJson(
        WSGetUserNotification instance) =>
    <String, dynamic>{
      'type': _$WSResponseTypeEnumMap[instance.type],
      'created': instance.created,
      'name': instance.name,
      'photo': instance.photo,
      'message': instance.message,
      'pk': instance.pk,
      'sender': instance.senderName,
      'receiver': instance.receiverName,
      'is_starred': instance.isStarred,
      'latest_message': instance.latestMessage,
      'message_id': instance.messageId,
      'receiver_id': instance.recieverId,
      'sender_id': instance.senderId,
      'unread_count': instance.unreadCount,
    };
