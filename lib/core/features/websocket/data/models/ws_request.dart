import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ws_request.g.dart';

enum WSRequestType {
  @JsonValue("set_user_chat")
  setUserChat,

  @JsonValue("send_user_message_to_user")
  sendMessageToUser,

  @JsonValue("user_is_typing")
  userIsTyping,

  @JsonValue("user_read_user_messages")
  readUserMessages,

  @JsonValue("get_all_users")
  getAllUsers,

  @JsonValue("star_user")
  starChatUser,

  @JsonValue("unstar_user")
  unStarChatUser,

  @JsonValue("unknownValue")
  unknownValue
}

@JsonSerializable()
class WSRequest extends Equatable {
  @JsonKey(unknownEnumValue: WSRequestType.unknownValue)
  final WSRequestType? type;
  final Object? message;

  const WSRequest({
    this.type,
    this.message,
  });

  @override
  List<Object> get props {
    final List<Object> temp = [];
    if (type != null) temp.add(type!);
    if (message != null) temp.add(message!);
    return temp;
  }
}


enum WSGroupRequestType {

  @JsonValue("send_group_message")
  sendGroupMessage,

  @JsonValue("send_group_reaction")
  sendGroupReaction,

  @JsonValue("unknownValue")
  unknownValue
}


@JsonSerializable()
class WSGroupRequest extends Equatable {
  @JsonKey(unknownEnumValue: WSGroupRequestType.unknownValue)
  final WSGroupRequestType? type;
  final Object? payload;

  const WSGroupRequest({
    this.type,
    this.payload,
  });

  @override
  List<Object> get props {
    final List<Object> temp = [];
    if (type != null) temp.add(type!);
    if (payload != null) temp.add(payload!);
    return temp;
  }
}
