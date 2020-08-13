import 'package:json_annotation/json_annotation.dart';

import 'package:worknetwork/models/chat/chat_model.dart';

part 'ws_response.g.dart';

enum WSResponseType {
  @JsonValue("all_users")
  loadAllUsers,

  @JsonValue("get_user_messages")
  loadChatMessages,

  @JsonValue("user_notification")
  getUserNotification,

  @JsonValue("user_message")
  getUserMessage,

  @JsonValue("search_all_users")
  getSearchAllUsers,

  @JsonValue("unknown_type")
  unknowType,
}

abstract class WSResponse {
  static WSResponseType getEnumFromJson(dynamic value) =>
      _$enumDecodeNullable(_$WSResponseTypeEnumMap, value,
          unknownValue: WSResponseType.unknowType);
  @JsonKey(unknownEnumValue: WSResponseType.unknowType)
  final WSResponseType type;

  WSResponse(
    this.type,
  );
}

@JsonSerializable()
class WSGetAllUsersResponse extends WSResponse {
  @JsonKey(nullable: true)
  final dynamic errors;
  final int page;
  final int pages;
  final List<ChatUser> results;

  WSGetAllUsersResponse({
    WSResponseType type = WSResponseType.loadAllUsers,
    this.errors,
    this.page,
    this.pages,
    this.results,
  }) : super(type);

  factory WSGetAllUsersResponse.fromJson(Map<String, dynamic> json) =>
      _$WSGetAllUsersResponseFromJson(json);
  Map<String, dynamic> toJson() => _$WSGetAllUsersResponseToJson(this);
}

@JsonSerializable()
class WSGetChatMessagesResponse extends WSResponse {
  final String user;
  final String introduction;
  final String name;
  final int page;
  final int pages;
  final List<ChatMessage> results;

  @JsonKey(name: "user_data")
  final ChatUser userData;

  @JsonKey(name: "additional_information")
  final String additionalInformation;

  @JsonKey(name: "tag_line")
  final String tagLine;

  WSGetChatMessagesResponse({
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
  }) : super(type);

  factory WSGetChatMessagesResponse.fromJson(Map<String, dynamic> json) =>
      _$WSGetChatMessagesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$WSGetChatMessagesResponseToJson(this);
}

@JsonSerializable()
class WSGetUserNotificatioResponse extends WSResponse {
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
  final ChatMessage latestMessage;

  @JsonKey(name: "message_id")
  final int messageId;

  @JsonKey(name: "receiver_id")
  final String recieverId;

  @JsonKey(name: "sender_id")
  final String senderId;

  @JsonKey(name: "unread_count")
  final int unreadCount;

  WSGetUserNotificatioResponse({
    WSResponseType type = WSResponseType.getUserNotification,
    this.pk,
    this.created,
    this.name,
    this.photo,
    this.message,
    this.senderName,
    this.receiverName,
    this.isStarred,
    this.latestMessage,
    this.messageId,
    this.recieverId,
    this.senderId,
    this.unreadCount,
  }) : super(type);

  factory WSGetUserNotificatioResponse.fromJson(Map<String, dynamic> json) =>
      _$WSGetUserNotificatioResponseFromJson(json);
  Map<String, dynamic> toJson() => _$WSGetUserNotificatioResponseToJson(this);
}

@JsonSerializable()
class WSGetUserMessageResponse extends WSResponse {
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

  WSGetUserMessageResponse({
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
  }) : super(type);

  factory WSGetUserMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$WSGetUserMessageResponseFromJson(json);
  Map<String, dynamic> toJson() => _$WSGetUserMessageResponseToJson(this);
}
