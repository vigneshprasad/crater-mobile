// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => ChatMessage(
      message: json['message'] as String?,
      file: json['file'] as String?,
      filename: json['filename'] as String?,
      fileFormat: json['fileFormat'] as String?,
      sender: json['sender'] as String?,
      receiver: json['receiver'] as String?,
      pk: json['pk'] as int?,
      photo: json['photo'] as String?,
      created: json['created_at'],
      isRead: json['is_read'] as bool?,
      senderId: json['sender_id'] as String?,
      receiverId: json['receiver_id'] as String?,
      isSupport: json['is_support'] as bool?,
      senderDetails: json['sender_details'] == null
          ? null
          : ChatUser.fromJson(json['sender_details'] as Map<String, dynamic>),
      data: json['data'] == null
          ? null
          : ChatMessageData.fromJson(json['data'] as Map<String, dynamic>),
      displayName: json['display_name'] as String?,
      firebaseId: json['firebaseId'] as String?,
      type: json['type'] as int?,
      action: json['action'] as int?,
      isFollowing: json['isFollowing'] as bool?,
    );

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) =>
    <String, dynamic>{
      'message': instance.message,
      'file': instance.file,
      'filename': instance.filename,
      'fileFormat': instance.fileFormat,
      'sender': instance.sender,
      'receiver': instance.receiver,
      'pk': instance.pk,
      'photo': instance.photo,
      'created_at': instance.created,
      'is_read': instance.isRead,
      'sender_id': instance.senderId,
      'receiver_id': instance.receiverId,
      'is_support': instance.isSupport,
      'sender_details': instance.senderDetails,
      'data': instance.data,
      'display_name': instance.displayName,
      'firebaseId': instance.firebaseId,
      'type': instance.type,
      'action': instance.action,
      'isFollowing': instance.isFollowing,
    };

ChatMessageData _$ChatMessageDataFromJson(Map<String, dynamic> json) =>
    ChatMessageData(
      reaction: json['reaction'] == null
          ? null
          : ChatReaction.fromJson(json['reaction'] as Map<String, dynamic>),
      stream: json['stream'] == null
          ? null
          : Webinar.fromJson(json['stream'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatMessageDataToJson(ChatMessageData instance) =>
    <String, dynamic>{
      'reaction': instance.reaction,
      'stream': instance.stream,
    };
