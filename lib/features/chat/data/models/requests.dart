import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:worknetwork/core/features/websocket/data/models/ws_request.dart';

part 'requests.g.dart';

@JsonSerializable()
class SetChatRequestParams {
  final String user;
  final int page;

  const SetChatRequestParams({
    @required this.user,
    @required this.page,
  });

  factory SetChatRequestParams.fromJson(Map<String, dynamic> json) =>
      _$SetChatRequestParamsFromJson(json);
  Map<String, dynamic> toJson() => _$SetChatRequestParamsToJson(this);
}

@JsonSerializable()
class SetChatRequest extends WSRequest {
  const SetChatRequest({
    WSRequestType type = WSRequestType.setUserChat,
    @required SetChatRequestParams message,
  }) : super(
          type: type,
          message: message,
        );

  factory SetChatRequest.fromJson(Map<String, dynamic> json) =>
      _$SetChatRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SetChatRequestToJson(this);
}

@JsonSerializable()
class ChatMessageRequest extends WSRequest {
  const ChatMessageRequest({
    WSRequestType type = WSRequestType.sendMessageToUser,
    @required String message,
  }) : super(
          type: type,
          message: message,
        );

  factory ChatMessageRequest.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ChatMessageRequestToJson(this);
}

@JsonSerializable()
class UserTypingRequest extends WSRequest {
  const UserTypingRequest({
    WSRequestType type = WSRequestType.userIsTyping,
  }) : super(type: type);

  factory UserTypingRequest.fromJson(Map<String, dynamic> json) =>
      _$UserTypingRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UserTypingRequestToJson(this);
}

@JsonSerializable()
class ReadUserMessagesRequest extends WSRequest {
  const ReadUserMessagesRequest({
    WSRequestType type = WSRequestType.readUserMessages,
  }) : super(type: type);

  factory ReadUserMessagesRequest.fromJson(Map<String, dynamic> json) =>
      _$ReadUserMessagesRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ReadUserMessagesRequestToJson(this);
}
