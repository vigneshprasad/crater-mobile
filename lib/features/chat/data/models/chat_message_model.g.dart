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
      created: json['created'],
      isRead: json['is_read'] as bool?,
      senderId: json['sender_id'] as String?,
      receiverId: json['receiver_id'] as String?,
      isSupport: json['is_support'] as bool?,
      senderDetail: json['sender_detail'] == null
          ? null
          : ChatUser.fromJson(json['sender_detail'] as Map<String, dynamic>),
      reaction: json['data'] == null
          ? null
          : ChatReaction.fromJson(json['data'] as Map<String, dynamic>),
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
      'created': instance.created,
      'is_read': instance.isRead,
      'sender_id': instance.senderId,
      'receiver_id': instance.receiverId,
      'is_support': instance.isSupport,
      'sender_detail': instance.senderDetail,
      'data': instance.reaction,
      'display_name': instance.displayName,
      'firebaseId': instance.firebaseId,
      'type': instance.type,
      'action': instance.action,
      'isFollowing': instance.isFollowing,
    };
