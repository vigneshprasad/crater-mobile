import 'package:json_annotation/json_annotation.dart';

import '../../../../core/features/websocket/data/models/ws_response.dart';
import '../../../chat_inbox/data/models/chat_user_model.dart';
import 'chat_message_model.dart';

part 'responses.g.dart';

@JsonSerializable()
class SetChatUserResponse extends WSResponse {
  final String user;
  final String introduction;
  final String name;
  final int page;
  final int pages;
  final List<ChatMessageModel> results;

  @JsonKey(name: "user_data")
  final ChatUserModel userData;

  @JsonKey(name: "additional_information")
  final String additionalInformation;

  @JsonKey(name: "tag_line")
  final String tagLine;

  SetChatUserResponse({
    WSResponseType type = WSResponseType.loadChatMessages,
    this.user,
    this.introduction,
    this.name,
    this.page,
    this.pages,
    this.results,
    this.userData,
    this.additionalInformation,
    this.tagLine,
  }) : super(type: type);

  factory SetChatUserResponse.fromJson(Map<String, dynamic> json) =>
      _$SetChatUserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SetChatUserResponseToJson(this);
}

@JsonSerializable()
class SentMessageResponse extends WSResponse {
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

  SentMessageResponse({
    WSResponseType type = WSResponseType.getUserMessage,
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
  }) : super(type: type);

  ChatMessageModel toChatMessage() {
    return ChatMessageModel(
      message: message,
      file: file,
      filename: filename,
      fileFormat: fileFormat,
      sender: sender,
      receiver: receiver,
      pk: pk,
      photo: photo,
      created: created,
      isRead: isRead,
      senderId: senderId,
      receiverId: receiverId,
      isSupport: isSupport,
    );
  }

  factory SentMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$SentMessageResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SentMessageResponseToJson(this);
}

@JsonSerializable()
class ChatMessageNotificationResponse extends WSResponse {
  final String created;
  final String name;
  final String photo;
  final String message;

  final String pk;

  @JsonKey(name: "sender")
  final String senderName;

  @JsonKey(name: "receiver")
  final String receiverName;

  @JsonKey(name: "is_starred")
  final bool isStarred;

  @JsonKey(name: "latest_message")
  final ChatMessageModel latestMessage;

  @JsonKey(name: "message_id")
  final int messageId;

  @JsonKey(name: "receiver_id")
  final String recieverId;

  @JsonKey(name: "sender_id")
  final String senderId;

  @JsonKey(name: "unread_count")
  final int unreadCount;

  ChatMessageNotificationResponse({
    WSResponseType type = WSResponseType.getUserNotification,
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
  }) : super(type: type);

  factory ChatMessageNotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageNotificationResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$ChatMessageNotificationResponseToJson(this);
}
