import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/features/websocket/data/models/ws_request.dart';

part 'requests.g.dart';

@JsonSerializable()
class GetAllUsersRequestParams extends Equatable {
  final String filter;
  final int page;
  final String search;

  @JsonKey(name: "latest_messages")
  final String latestMessages;

  final bool strict;

  const GetAllUsersRequestParams({
    this.filter = "all",
    this.page = 1,
    this.search = "",
    this.strict = true,
    this.latestMessages,
  });

  @override
  List<Object> get props => [
        filter,
        page,
        search,
        strict,
      ];

  factory GetAllUsersRequestParams.fromJson(Map<String, dynamic> json) =>
      _$GetAllUsersRequestParamsFromJson(json);
  Map<String, dynamic> toJson() => _$GetAllUsersRequestParamsToJson(this);
}

@JsonSerializable()
class GetAllChatUsersRequest extends WSRequest {
  const GetAllChatUsersRequest({
    WSRequestType type = WSRequestType.getAllUsers,
    @required GetAllUsersRequestParams message,
  }) : super(
          type: type,
          message: message,
        );

  factory GetAllChatUsersRequest.fromJson(Map<String, dynamic> json) =>
      _$GetAllChatUsersRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetAllChatUsersRequestToJson(this);
}

@JsonSerializable()
class StarChatUserRequestParams extends Equatable {
  final String user;

  const StarChatUserRequestParams({
    this.user,
  });

  @override
  List<Object> get props => [user];

  factory StarChatUserRequestParams.fromJson(Map<String, dynamic> json) =>
      _$StarChatUserRequestParamsFromJson(json);
  Map<String, dynamic> toJson() => _$StarChatUserRequestParamsToJson(this);
}

@JsonSerializable()
class StarChatUserRequest extends WSRequest {
  const StarChatUserRequest({
    WSRequestType type = WSRequestType.starChatUser,
    @required StarChatUserRequestParams message,
  }) : super(
          type: type,
          message: message,
        );

  factory StarChatUserRequest.fromJson(Map<String, dynamic> json) =>
      _$StarChatUserRequestFromJson(json);
  Map<String, dynamic> toJson() => _$StarChatUserRequestToJson(this);
}

@JsonSerializable()
class UnStarChatUserRequest extends WSRequest {
  const UnStarChatUserRequest({
    WSRequestType type = WSRequestType.unStarChatUser,
    @required StarChatUserRequestParams message,
  }) : super(
          type: type,
          message: message,
        );

  factory UnStarChatUserRequest.fromJson(Map<String, dynamic> json) =>
      _$UnStarChatUserRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UnStarChatUserRequestToJson(this);
}
