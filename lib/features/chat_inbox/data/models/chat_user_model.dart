import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../constants/app_hive_boxes.dart';
import '../../../chat/data/models/chat_message_model.dart';
import '../../domain/entity/chat_user_entity.dart';

part 'chat_user_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

@HiveType(typeId: AppHiveTypeIds.chatUser)
@JsonSerializable()
class ChatUserModel extends ChatUser {
  @HiveField(0)
  final String? pk;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? photo;

  @HiveField(3)
  @JsonKey(name: "unread_count")
  final int? unreadCount;

  @HiveField(4)
  @JsonKey(name: "is_starred")
  final bool? isStarred;

  @HiveField(5)
  @JsonKey(name: "last_seen")
  final DateTime? lastSeen;

  @HiveField(6)
  @JsonKey(name: "latest_message")
  final ChatMessageModel? latestMessage;

  @HiveField(7)
  @JsonKey(name: "display_name")
  final String? displayName;

  ChatUserModel({
    this.pk,
    this.name = '',
    this.photo,
    this.unreadCount,
    this.isStarred,
    this.lastSeen,
    this.latestMessage,
    this.displayName,
  }) : super(
          pk: pk,
          name: name,
          photo: photo,
          unreadCount: unreadCount,
          isStarred: isStarred,
          lastSeen: lastSeen,
          latestMessage: latestMessage,
          displayName: displayName,
        );

  factory ChatUserModel.fromJson(Map<String, dynamic> json) =>
      _$ChatUserModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChatUserModelToJson(this);

  ChatUserModel copyWith({
    String? pk,
    String? name,
    String? photo,
    int? unreadCount,
    bool? isStarred,
    DateTime? lastSeen,
    ChatMessageModel? latestMessage,
    String? displayName,
  }) {
    return ChatUserModel(
      pk: pk ?? this.pk,
      name: name ?? this.name,
      photo: photo ?? this.photo,
      unreadCount: unreadCount ?? this.unreadCount,
      isStarred: isStarred ?? this.isStarred,
      lastSeen: lastSeen ?? this.lastSeen,
      latestMessage: latestMessage ?? this.latestMessage,
      displayName: displayName ?? this.displayName,
    );
  }
}
