// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatMessageAdapter extends TypeAdapter<ChatMessage> {
  @override
  final int typeId = 6;

  @override
  ChatMessage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatMessage(
      message: fields[0] as String,
      file: fields[1] as String,
      filename: fields[2] as String,
      fileFormat: fields[3] as String,
      sender: fields[4] as String,
      receiver: fields[5] as String,
      pk: fields[6] as int,
      photo: fields[7] as String,
      created: fields[8] as String,
      isRead: fields[9] as bool,
      senderId: fields[10] as String,
      receiverId: fields[11] as String,
      isSupport: fields[12] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ChatMessage obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.message)
      ..writeByte(1)
      ..write(obj.file)
      ..writeByte(2)
      ..write(obj.filename)
      ..writeByte(3)
      ..write(obj.fileFormat)
      ..writeByte(4)
      ..write(obj.sender)
      ..writeByte(5)
      ..write(obj.receiver)
      ..writeByte(6)
      ..write(obj.pk)
      ..writeByte(7)
      ..write(obj.photo)
      ..writeByte(8)
      ..write(obj.created)
      ..writeByte(9)
      ..write(obj.isRead)
      ..writeByte(10)
      ..write(obj.senderId)
      ..writeByte(11)
      ..write(obj.receiverId)
      ..writeByte(12)
      ..write(obj.isSupport);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatMessageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ChatUserAdapter extends TypeAdapter<ChatUser> {
  @override
  final int typeId = 9;

  @override
  ChatUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatUser(
      pk: fields[0] as String,
      name: fields[1] as String,
      photo: fields[2] as String,
      isStarred: fields[4] as bool,
      lastSeen: fields[5] as DateTime,
      latestMessage: fields[6] as ChatMessage,
      unreadCount: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ChatUser obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.pk)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.photo)
      ..writeByte(3)
      ..write(obj.unreadCount)
      ..writeByte(4)
      ..write(obj.isStarred)
      ..writeByte(5)
      ..write(obj.lastSeen)
      ..writeByte(6)
      ..write(obj.latestMessage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MessageNotificationAdapter extends TypeAdapter<MessageNotification> {
  @override
  final int typeId = 2;

  @override
  MessageNotification read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MessageNotification(
      created: fields[0] as String,
      name: fields[1] as String,
      photo: fields[2] as String,
      message: fields[3] as String,
      pk: fields[4] as String,
      senderName: fields[5] as String,
      receiverName: fields[6] as String,
      isStarred: fields[7] as bool,
      latestMessage: fields[8] as ChatMessage,
      messageId: fields[9] as int,
      recieverId: fields[10] as String,
      senderId: fields[11] as String,
      unreadCount: fields[12] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MessageNotification obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.created)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.photo)
      ..writeByte(3)
      ..write(obj.message)
      ..writeByte(4)
      ..write(obj.pk)
      ..writeByte(5)
      ..write(obj.senderName)
      ..writeByte(6)
      ..write(obj.receiverName)
      ..writeByte(7)
      ..write(obj.isStarred)
      ..writeByte(8)
      ..write(obj.latestMessage)
      ..writeByte(9)
      ..write(obj.messageId)
      ..writeByte(10)
      ..write(obj.recieverId)
      ..writeByte(11)
      ..write(obj.senderId)
      ..writeByte(12)
      ..write(obj.unreadCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageNotificationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserChatMessagesDataAdapter extends TypeAdapter<UserChatMessagesData> {
  @override
  final int typeId = 8;

  @override
  UserChatMessagesData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserChatMessagesData(
      recieverUser: fields[0] as ChatUser,
      messages: (fields[1] as List)?.cast<ChatMessage>(),
      page: fields[2] as int,
      pages: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, UserChatMessagesData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.recieverUser)
      ..writeByte(1)
      ..write(obj.messages)
      ..writeByte(2)
      ..write(obj.page)
      ..writeByte(3)
      ..write(obj.pages);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserChatMessagesDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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

MessageNotification _$MessageNotificationFromJson(Map<String, dynamic> json) {
  return MessageNotification(
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
        : ChatMessage.fromJson(json['latest_message'] as Map<String, dynamic>),
    messageId: json['message_id'] as int,
    recieverId: json['receiver_id'] as String,
    senderId: json['sender_id'] as String,
    unreadCount: json['unread_count'] as int,
  );
}

Map<String, dynamic> _$MessageNotificationToJson(
        MessageNotification instance) =>
    <String, dynamic>{
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
