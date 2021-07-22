import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

class ChatMessage extends HiveObject {
  final String? message;

  final String? file;

  final String? filename;

  final String? fileFormat;

  final String? sender;

  final String? receiver;

  final int pk;

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

  ChatMessage({
    this.message,
    this.file,
    this.filename,
    this.fileFormat,
    this.sender,
    this.receiver,
    required this.pk,
    this.photo,
    this.created,
    this.isRead,
    this.senderId,
    this.receiverId,
    this.isSupport,
  });
}
