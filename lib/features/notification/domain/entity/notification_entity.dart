import 'package:hive/hive.dart';

class Notification extends HiveObject {
  final int? pk;
  final String? text;
  final DateTime? created;
  final String? authAvatar;
  final String? authorName;
  final DateTime? eventDate;
  final bool? isRead;
  final int? objPk;
  final String? objType;

  Notification({
    this.pk,
    this.text,
    this.created,
    this.authAvatar,
    this.authorName,
    this.eventDate,
    this.isRead,
    this.objPk,
    this.objType,
  });
}
