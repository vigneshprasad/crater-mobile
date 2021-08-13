import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../constants/app_hive_boxes.dart';
import '../../domain/entity/notification_entity.dart';

part 'notification_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

@HiveType(typeId: AppHiveTypeIds.notifications)
@JsonSerializable()
class NotificationModel extends Notification {
  @HiveField(0)
  final int? pk;

  @HiveField(1)
  final String? text;

  @HiveField(2)
  final DateTime? created;

  @HiveField(3)
  @JsonKey(name: "author_avatar")
  final String? authAvatar;

  @HiveField(4)
  @JsonKey(name: "author_name")
  final String? authorName;

  @HiveField(5)
  @JsonKey(name: "event_date")
  final DateTime? eventDate;

  @HiveField(6)
  @JsonKey(name: "is_read")
  final bool? isRead;

  @HiveField(7)
  @JsonKey(name: "obj_pk")
  final int? objPk;

  @HiveField(8)
  @JsonKey(name: "obj_type")
  final String? objType;

  NotificationModel({
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

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
