import 'package:json_annotation/json_annotation.dart';

import '../../../../core/features/websocket/data/models/ws_response.dart';
import 'chat_user_model.dart';

part 'responses.g.dart';

@JsonSerializable()
class GetAllUsersResponse extends WSResponse {
  final dynamic errors;
  final int page;
  final int pages;
  final List<ChatUserModel> results;

  GetAllUsersResponse({
    WSResponseType type = WSResponseType.loadAllUsers,
    this.errors,
    this.page,
    this.pages,
    this.results,
  }) : super(type: type);

  factory GetAllUsersResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllUsersResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetAllUsersResponseToJson(this);
}

@JsonSerializable()
class GetSearchAllUsersResponse extends WSResponse {
  final dynamic errors;
  final int page;
  final int pages;
  final List<ChatUserModel> results;

  GetSearchAllUsersResponse({
    WSResponseType type = WSResponseType.getSearchAllUsers,
    this.errors,
    this.page,
    this.pages,
    this.results,
  }) : super(type: type);

  factory GetSearchAllUsersResponse.fromJson(Map<String, dynamic> json) =>
      _$GetSearchAllUsersResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetSearchAllUsersResponseToJson(this);
}
