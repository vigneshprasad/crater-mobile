import 'package:json_annotation/json_annotation.dart';

part 'chat_user_model.g.dart';

@JsonSerializable()
class ChatUser {
  final String? pk;

  final String name;

  final String? photo;

  @JsonKey(name: "unread_count")
  final int? unreadCount;

  @JsonKey(name: "is_starred")
  final bool? isStarred;

  @JsonKey(name: "last_seen")
  final DateTime? lastSeen;

  @JsonKey(name: "display_name")
  final String? displayName;

  @JsonKey(name: "first_name")
  final String? firstName;

  ChatUser({
    this.pk,
    this.name = '',
    this.photo,
    this.unreadCount,
    this.isStarred,
    this.lastSeen,
    this.displayName,
    this.firstName,
  });

  factory ChatUser.fromJson(Map<String, dynamic> json) =>
      _$ChatUserFromJson(json);

  Map<String, dynamic> toJson() => _$ChatUserToJson(this);
}
