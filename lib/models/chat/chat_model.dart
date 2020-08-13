import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../websocket/response/ws_response.dart';

part 'chat_model.g.dart';

@HiveType(typeId: 6)
@JsonSerializable()
class ChatMessage extends HiveObject {
  @HiveField(0)
  final String message;

  @HiveField(1)
  final String file;

  @HiveField(2)
  final String filename;

  @HiveField(3)
  final String fileFormat;

  @HiveField(4)
  final String sender;

  @HiveField(5)
  final String receiver;

  @HiveField(6)
  final int pk;

  @HiveField(7)
  final String photo;

  @HiveField(8)
  final String created;

  @HiveField(9)
  @JsonKey(name: "is_read")
  final bool isRead;

  @HiveField(10)
  @JsonKey(name: "sender_id")
  final String senderId;

  @HiveField(11)
  @JsonKey(name: "receiver_id")
  final String receiverId;

  @HiveField(12)
  @JsonKey(name: "is_support")
  final bool isSupport;

  ChatMessage({
    this.message,
    this.file,
    this.filename,
    this.fileFormat,
    this.sender,
    this.receiver,
    this.pk,
    this.photo,
    this.created,
    this.isRead,
    this.senderId,
    this.receiverId,
    this.isSupport,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);
}

@HiveType(typeId: 9)
@JsonSerializable()
class ChatUser {
  @HiveField(0)
  final String pk;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String photo;

  @HiveField(3)
  @JsonKey(name: "unread_count")
  final int unreadCount;

  @HiveField(4)
  @JsonKey(name: "is_starred")
  final bool isStarred;

  @HiveField(5)
  @JsonKey(name: "last_seen")
  final DateTime lastSeen;

  @HiveField(6)
  @JsonKey(name: "latest_message")
  final ChatMessage latestMessage;

  ChatUser({
    this.pk,
    this.name,
    this.photo,
    this.isStarred,
    this.lastSeen,
    this.latestMessage,
    this.unreadCount,
  });

  factory ChatUser.fromJson(Map<String, dynamic> json) =>
      _$ChatUserFromJson(json);
  Map<String, dynamic> toJson() => _$ChatUserToJson(this);

  ChatUser copyWith({
    String pk,
    String name,
    String photo,
    int unreadCount,
    bool isStarred,
    DateTime lastSeen,
    ChatMessage latestMessage,
  }) {
    return ChatUser(
      pk: pk ?? this.pk,
      name: name ?? this.name,
      photo: photo ?? this.photo,
      unreadCount: unreadCount ?? this.unreadCount,
      isStarred: isStarred ?? this.isStarred,
      lastSeen: lastSeen ?? this.lastSeen,
      latestMessage: latestMessage ?? this.latestMessage,
    );
  }

  @override
  String toString() {
    return 'ChatUser(pk: $pk, name: $name, photo: $photo, unreadCount: $unreadCount, isStarred: $isStarred, lastSeen: $lastSeen, latestMessage: $latestMessage)';
  }
}

@HiveType(typeId: 2)
@JsonSerializable()
class MessageNotification extends HiveObject {
  @HiveField(0)
  final String created;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String photo;

  @HiveField(3)
  final String message;

  @HiveField(4)
  final String pk;

  @HiveField(5)
  @JsonKey(name: "sender")
  final String senderName;

  @HiveField(6)
  @JsonKey(name: "receiver")
  final String receiverName;

  @HiveField(7)
  @JsonKey(name: "is_starred")
  final bool isStarred;

  @HiveField(8)
  @JsonKey(name: "latest_message")
  final ChatMessage latestMessage;

  @HiveField(9)
  @JsonKey(name: "message_id")
  final int messageId;

  @HiveField(10)
  @JsonKey(name: "receiver_id")
  final String recieverId;

  @HiveField(11)
  @JsonKey(name: "sender_id")
  final String senderId;

  @HiveField(12)
  @JsonKey(name: "unread_count")
  final int unreadCount;

  MessageNotification({
    this.created,
    this.name,
    this.photo,
    this.message,
    this.pk,
    this.senderName,
    this.receiverName,
    this.isStarred,
    this.latestMessage,
    this.messageId,
    this.recieverId,
    this.senderId,
    this.unreadCount,
  });

  MessageNotification.fromResponse(WSGetUserNotificatioResponse response)
      : this(
          created: response.created,
          name: response.name,
          photo: response.photo,
          message: response.message,
          pk: response.pk,
          senderName: response.senderName,
          receiverName: response.receiverName,
          isStarred: response.isStarred,
          latestMessage: response.latestMessage,
          messageId: response.messageId,
          recieverId: response.recieverId,
          senderId: response.senderId,
          unreadCount: response.unreadCount,
        );

  factory MessageNotification.fromJson(Map<String, dynamic> json) =>
      _$MessageNotificationFromJson(json);
  Map<String, dynamic> toJson() => _$MessageNotificationToJson(this);
}

@HiveType(typeId: 8)
class UserChatBox extends HiveObject {
  @HiveField(0)
  final ChatUser recieverUser;

  @HiveField(1)
  final List<ChatMessage> messages;

  @HiveField(2)
  final int page;

  @HiveField(3)
  final int pages;

  UserChatBox({
    this.recieverUser,
    this.messages,
    this.page,
    this.pages,
  });

  UserChatBox copyWith({
    ChatUser recieverUser,
    List<ChatMessage> messages,
    int page,
    int pages,
  }) {
    return UserChatBox(
      recieverUser: recieverUser ?? this.recieverUser,
      messages: messages ?? this.messages,
      page: page ?? this.page,
      pages: pages ?? this.pages,
    );
  }
}
