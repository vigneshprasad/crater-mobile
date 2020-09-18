// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetChatUserResponse _$SetChatUserResponseFromJson(Map<String, dynamic> json) {
  return SetChatUserResponse(
    type: _$enumDecodeNullable(_$WSResponseTypeEnumMap, json['type'],
        unknownValue: WSResponseType.unknowType),
    user: json['user'] as String,
    introduction: json['introduction'] as String,
    name: json['name'] as String,
    page: json['page'] as int,
    pages: json['pages'] as int,
    results: (json['results'] as List)
        ?.map((e) => e == null
            ? null
            : ChatMessageModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    userData: json['user_data'] == null
        ? null
        : ChatUserModel.fromJson(json['user_data'] as Map<String, dynamic>),
    additionalInformation: json['additional_information'] as String,
    tagLine: json['tag_line'] as String,
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
  WSResponseType.getUserMessage: 'user_message',
  WSResponseType.getSearchAllUsers: 'search_all_users',
  WSResponseType.starUser: 'star_user',
  WSResponseType.unstarUser: 'unstar_user',
  WSResponseType.unknowType: 'unknown_type',
};

SentMessageResponse _$SentMessageResponseFromJson(Map<String, dynamic> json) {
  return SentMessageResponse(
    type: _$enumDecodeNullable(_$WSResponseTypeEnumMap, json['type'],
        unknownValue: WSResponseType.unknowType),
    message: json['message'] as String,
    file: json['file'] as String,
    filename: json['filename'] as String,
    fileFormat: json['fileFormat'] as String,
    sender: json['sender'] as String,
    receiver: json['receiver'] as String,
    pk: json['pk'] as int,
    photo: json['photo'] as String,
    created: json['created'] as String,
    isRead: json['is_read'] as bool,
    senderId: json['sender_id'] as String,
    receiverId: json['receiver_id'] as String,
    isSupport: json['is_support'] as bool,
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
    };

ChatMessageNotificationResponse _$ChatMessageNotificationResponseFromJson(
    Map<String, dynamic> json) {
  return ChatMessageNotificationResponse(
    type: _$enumDecodeNullable(_$WSResponseTypeEnumMap, json['type'],
        unknownValue: WSResponseType.unknowType),
    created: json['created'] as String,
    name: json['name'] as String,
    photo: json['photo'] as String,
    message: json['message'] as String,
    pk: json['pk'] as String,
    senderName: json['sender'] as String,
    receiverName: json['receiver'] as String,
    isStarred: json['is_starred'] as bool,
    latestMessage: json['latest_message'] == null
        ? null
        : ChatMessageModel.fromJson(
            json['latest_message'] as Map<String, dynamic>),
    messageId: json['message_id'] as int,
    recieverId: json['receiver_id'] as String,
    senderId: json['sender_id'] as String,
    unreadCount: json['unread_count'] as int,
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
