// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetChatUserResponse _$SetChatUserResponseFromJson(Map<String, dynamic> json) {
  return SetChatUserResponse(
    type: _$enumDecode(_$WSResponseTypeEnumMap, json['type'],
        unknownValue: WSResponseType.unknowType),
    user: json['user'] as String?,
    introduction: json['introduction'] as String?,
    name: json['name'] as String?,
    page: json['page'] as int?,
    pages: json['pages'] as int?,
    results: (json['results'] as List<dynamic>?)
        ?.map((e) => ChatMessageModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    userData: json['user_data'] == null
        ? null
        : ChatUserModel.fromJson(json['user_data'] as Map<String, dynamic>),
    additionalInformation: json['additional_information'] as String?,
    tagLine: json['tag_line'] as String?,
  );
}

Map<String, dynamic> _$SetChatUserResponseToJson(
        SetChatUserResponse instance) =>
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

const _$WSResponseTypeEnumMap = {
  WSResponseType.groupMessagesReceived: 'group_messages_received',
  WSResponseType.newGroupMessage: 'new_group_message',
  WSResponseType.loadAllUsers: 'all_users',
  WSResponseType.loadChatMessages: 'get_user_messages',
  WSResponseType.getUserNotification: 'user_notification',
  WSResponseType.getUserMessage: 'user_message',
  WSResponseType.getSearchAllUsers: 'search_all_users',
  WSResponseType.starUser: 'star_user',
  WSResponseType.unstarUser: 'unstar_user',
  WSResponseType.unknowType: 'unknown_type',
};

SetChatWebinarResponse _$SetChatWebinarResponseFromJson(
    Map<String, dynamic> json) {
  return SetChatWebinarResponse(
    type: _$enumDecode(_$WSResponseTypeEnumMap, json['type'],
        unknownValue: WSResponseType.unknowType),
    payload: json['payload'] == null
        ? null
        : SetChatWebinarResponsePayload.fromJson(
            json['payload'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SetChatWebinarResponseToJson(
        SetChatWebinarResponse instance) =>
    <String, dynamic>{
      'type': _$WSResponseTypeEnumMap[instance.type],
      'payload': instance.payload,
    };

SetChatWebinarResponsePayload _$SetChatWebinarResponsePayloadFromJson(
    Map<String, dynamic> json) {
  return SetChatWebinarResponsePayload(
    messages: (json['messages'] as List<dynamic>?)
        ?.map((e) => ChatMessageModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$SetChatWebinarResponsePayloadToJson(
        SetChatWebinarResponsePayload instance) =>
    <String, dynamic>{
      'messages': instance.messages,
    };

SentMessageResponse _$SentMessageResponseFromJson(Map<String, dynamic> json) {
  return SentMessageResponse(
    type: _$enumDecode(_$WSResponseTypeEnumMap, json['type'],
        unknownValue: WSResponseType.unknowType),
    message: json['message'] as String?,
    file: json['file'] as String?,
    filename: json['filename'] as String?,
    fileFormat: json['fileFormat'] as String?,
    sender: json['sender'] as String?,
    receiver: json['receiver'] as String?,
    pk: json['pk'] as int?,
    photo: json['photo'] as String?,
    created: json['created'] as String?,
    isRead: json['is_read'] as bool?,
    senderId: json['sender_id'] as String?,
    receiverId: json['receiver_id'] as String?,
    isSupport: json['is_support'] as bool?,
    senderDetail: json['sender_detail'] == null
        ? null
        : ChatUserModel.fromJson(json['sender_detail'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SentMessageResponseToJson(
        SentMessageResponse instance) =>
    <String, dynamic>{
      'type': _$WSResponseTypeEnumMap[instance.type],
      'message': instance.message,
      'file': instance.file,
      'filename': instance.filename,
      'fileFormat': instance.fileFormat,
      'sender': instance.sender,
      'receiver': instance.receiver,
      'pk': instance.pk,
      'photo': instance.photo,
      'created': instance.created,
      'is_read': instance.isRead,
      'sender_id': instance.senderId,
      'receiver_id': instance.receiverId,
      'is_support': instance.isSupport,
      'sender_detail': instance.senderDetail,
    };

SentWebinarMessageResponse _$SentWebinarMessageResponseFromJson(
    Map<String, dynamic> json) {
  return SentWebinarMessageResponse(
    type: _$enumDecode(_$WSResponseTypeEnumMap, json['type'],
        unknownValue: WSResponseType.unknowType),
    payload: json['payload'] == null
        ? null
        : ChatMessageModel.fromJson(json['payload'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SentWebinarMessageResponseToJson(
        SentWebinarMessageResponse instance) =>
    <String, dynamic>{
      'type': _$WSResponseTypeEnumMap[instance.type],
      'payload': instance.payload,
    };

ChatMessageNotificationResponse _$ChatMessageNotificationResponseFromJson(
    Map<String, dynamic> json) {
  return ChatMessageNotificationResponse(
    type: _$enumDecode(_$WSResponseTypeEnumMap, json['type'],
        unknownValue: WSResponseType.unknowType),
    created: json['created'] as String?,
    name: json['name'] as String?,
    photo: json['photo'] as String?,
    message: json['message'] as String?,
    pk: json['pk'] as String?,
    senderName: json['sender'] as String?,
    receiverName: json['receiver'] as String?,
    isStarred: json['is_starred'] as bool?,
    latestMessage: json['latest_message'] == null
        ? null
        : ChatMessageModel.fromJson(
            json['latest_message'] as Map<String, dynamic>),
    messageId: json['message_id'] as int?,
    recieverId: json['receiver_id'] as String?,
    senderId: json['sender_id'] as String?,
    unreadCount: json['unread_count'] as int?,
  );
}

Map<String, dynamic> _$ChatMessageNotificationResponseToJson(
        ChatMessageNotificationResponse instance) =>
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
