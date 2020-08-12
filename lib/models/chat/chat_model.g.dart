// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) {
  return ChatMessage(
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
    };

ChatUser _$ChatUserFromJson(Map<String, dynamic> json) {
  return ChatUser(
    pk: json['pk'] as String,
    name: json['name'] as String,
    photo: json['photo'] as String,
    isStarred: json['is_starred'] as bool,
    lastSeen: json['last_seen'] == null
        ? null
        : DateTime.parse(json['last_seen'] as String),
    latestMessage: json['latest_message'] == null
        ? null
        : ChatMessage.fromJson(json['latest_message'] as Map<String, dynamic>),
    unreadCount: json['unread_count'] as int,
  );
}

Map<String, dynamic> _$ChatUserToJson(ChatUser instance) => <String, dynamic>{
      'pk': instance.pk,
      'name': instance.name,
      'photo': instance.photo,
      'unread_count': instance.unreadCount,
      'is_starred': instance.isStarred,
      'last_seen': instance.lastSeen?.toIso8601String(),
      'latest_message': instance.latestMessage,
    };
