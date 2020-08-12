import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ws_requests.g.dart';

enum WSRequestType {
  @JsonValue("get_all_users")
  getAllUsers,
  @JsonValue("set_user_chat")
  setUserChat,
  @JsonValue("send_user_message_to_user")
  sendMessageToUser,
  @JsonValue("user_is_typing")
  userIsTyping
}

abstract class WSRequest {
  final dynamic message;
  final WSRequestType type;

  WSRequest(
    this.message,
    this.type,
  );
}

@JsonSerializable()
class AllUserRequestOptions {
  final String filter;
  final int page;
  final String search;
  final int allPages;
  final bool strict;

  AllUserRequestOptions({
    this.filter,
    this.page,
    this.search,
    this.allPages,
    this.strict,
  });

  AllUserRequestOptions copyWith({
    String filter,
    int page,
    String search,
    int allPages,
    bool strict,
  }) {
    return AllUserRequestOptions(
      filter: filter ?? this.filter,
      page: page ?? this.page,
      search: search ?? this.search,
      allPages: allPages ?? this.allPages,
      strict: strict ?? this.strict,
    );
  }

  const AllUserRequestOptions.initial({
    this.filter = "all",
    this.page = 1,
    this.search = "",
    this.strict = true,
    this.allPages = 1,
  });

  factory AllUserRequestOptions.fromJson(Map<String, dynamic> json) =>
      _$AllUserRequestOptionsFromJson(json);
  Map<String, dynamic> toJson() => _$AllUserRequestOptionsToJson(this);
}

@JsonSerializable()
class WSAllUsersRequest extends WSRequest {
  WSAllUsersRequest({
    WSRequestType type = WSRequestType.getAllUsers,
    AllUserRequestOptions message,
  }) : super(message, type);

  factory WSAllUsersRequest.fromJson(Map<String, dynamic> json) =>
      _$WSAllUsersRequestFromJson(json);
  Map<String, dynamic> toJson() => _$WSAllUsersRequestToJson(this);
}

@JsonSerializable()
class SetChatRequestOptions {
  final String user;
  final int page;

  SetChatRequestOptions({
    this.user,
    this.page,
  });

  factory SetChatRequestOptions.fromJson(Map<String, dynamic> json) =>
      _$SetChatRequestOptionsFromJson(json);
  Map<String, dynamic> toJson() => _$SetChatRequestOptionsToJson(this);
}

@JsonSerializable()
class WSSetChatUserRequest extends WSRequest {
  WSSetChatUserRequest({
    WSRequestType type = WSRequestType.setUserChat,
    @required SetChatRequestOptions message,
  }) : super(message, type);

  factory WSSetChatUserRequest.fromJson(Map<String, dynamic> json) =>
      _$WSSetChatUserRequestFromJson(json);
  Map<String, dynamic> toJson() => _$WSSetChatUserRequestToJson(this);
}

@JsonSerializable()
class WSSendMessageToUserRequest extends WSRequest {
  WSSendMessageToUserRequest({
    WSRequestType type = WSRequestType.sendMessageToUser,
    @required String message,
  }) : super(message, type);

  factory WSSendMessageToUserRequest.fromJson(Map<String, dynamic> json) =>
      _$WSSendMessageToUserFromJson(json);
  Map<String, dynamic> toJson() => _$WSSendMessageToUserToJson(this);
}
