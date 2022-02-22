import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:worknetwork/features/chat_inbox/data/models/chat_user_model.dart';
import 'package:worknetwork/features/chat_inbox/domain/entity/chat_user_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/chat_reaction_entity/chat_reaction_entity.dart';

import '../../../../constants/app_hive_boxes.dart';
import '../../domain/entity/chat_message_entity.dart';

part 'chat_message_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

@HiveType(typeId: AppHiveTypeIds.chatMessage)
@JsonSerializable()
class ChatMessageModel extends ChatMessage {
  @HiveField(0)
  final String? message;

  @HiveField(1)
  final String? file;

  @HiveField(2)
  final String? filename;

  @HiveField(3)
  final String? fileFormat;

  @HiveField(4)
  final String? sender;

  @HiveField(5)
  final String? receiver;

  @HiveField(6)
  final int? pk;

  @HiveField(7)
  final String? photo;

  @HiveField(8)
  final String? created;

  @HiveField(9)
  @JsonKey(name: "is_read")
  final bool? isRead;

  @HiveField(10)
  @JsonKey(name: "sender_id")
  final String? senderId;

  @HiveField(11)
  @JsonKey(name: "receiver_id")
  final String? receiverId;

  @HiveField(12)
  @JsonKey(name: "is_support")
  final bool? isSupport;

  @HiveField(13)
  @JsonKey(name: "sender_detail")
  final ChatUserModel? senderDetail;

  @JsonKey(name: "data")
  final ChatReaction? reaction;

  @JsonKey(name: "display_name")
  final String? displayName;

  ChatMessageModel({
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
  }) : super(
          message: message,
          file: file,
          filename: filename,
          fileFormat: fileFormat,
          sender: sender,
          receiver: receiver,
          pk: pk,
          photo: photo,
          created: created,
          isRead: isRead,
          senderId: senderId,
          receiverId: receiverId,
          isSupport: isSupport,
          senderDetail: senderDetail,
          reaction: reaction,
          displayName: displayName,
        );

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChatMessageModelToJson(this);
}
