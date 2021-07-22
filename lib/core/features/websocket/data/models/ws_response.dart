import 'package:json_annotation/json_annotation.dart';

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

  @JsonValue("star_user")
  starUser,

  @JsonValue("unstar_user")
  unstarUser,

  @JsonValue("unknown_type")
  unknowType,
}

@JsonSerializable()
class WSResponse {
  static WSResponseType getEnumFromJson(dynamic value) =>
      _$enumDecode(_$WSResponseTypeEnumMap, value,
          unknownValue: WSResponseType.unknowType);

  @JsonKey(unknownEnumValue: WSResponseType.unknowType)
  final WSResponseType type;

  WSResponse({
    required this.type,
  });
}
