import 'package:json_annotation/json_annotation.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class ChatMessage {
  final String message;
  final String file;
  final String filename;
  final String fileFormat;
  final String sender;
  final String receiver;
  final int pk;
  final String photo;
  final String created;

  @JsonKey(name: "is_read")
  final bool isRead;

  @JsonKey(name: "sender_id")
  final String senderId;

  @JsonKey(name: "receiver_id")
  final String receiverId;

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

@JsonSerializable()
class ChatUser {
  final String pk;
  final String name;
  final String photo;

  @JsonKey(name: "unread_count")
  final int unreadCount;

  @JsonKey(name: "is_starred")
  final bool isStarred;

  @JsonKey(name: "last_seen")
  final DateTime lastSeen;

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
