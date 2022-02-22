import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:worknetwork/features/chat_inbox/domain/entity/chat_user_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/chat_reaction_entity/chat_reaction_entity.dart';

class ChatMessage extends HiveObject {
  final String? message;

  final String? file;

  final String? filename;

  final String? fileFormat;

  final String? sender;

  final String? receiver;

  final int? pk;

  final String? photo;

  final String? created;

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
  });
}
