import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:worknetwork/features/chat/data/models/chat_user_model.dart';
import 'package:worknetwork/features/conversations/domain/entity/chat_reaction_entity/chat_reaction_entity.dart';

part 'chat_message_model.g.dart';

@JsonSerializable()
class ChatMessage {
  final String? message;

  final String? file;

  final String? filename;

  final String? fileFormat;

  final String? sender;

  final String? receiver;

  final int? pk;

  final String? photo;

  final dynamic created;

  @JsonKey(name: "is_read")
  final bool? isRead;

  @JsonKey(name: "sender_id")
  final String? senderId;

  @JsonKey(name: "receiver_id")
  final String? receiverId;

  @JsonKey(name: "is_support")
  final bool? isSupport;

  @JsonKey(name: "sender_detail")
  final ChatUser? senderDetail;

  @JsonKey(name: "data")
  final ChatReaction? reaction;

  @JsonKey(name: "display_name")
  final String? displayName;

  String? firebaseId;

  @JsonKey(name: "type")
  int? type;

  @JsonKey(name: "action")
  int? action;

  bool? isFollowing;

  ChatMessage({
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
    this.senderDetail,
    this.reaction,
    this.displayName,
    this.firebaseId,
    this.type,
    this.action,
    this.isFollowing,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);
}
