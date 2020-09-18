import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:worknetwork/constants/app_hive_boxes.dart';

import 'package:worknetwork/features/notification/domain/entity/notification_entity.dart';

part 'notification_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

@HiveType(typeId: AppHiveTypeIds.notifications)
@JsonSerializable()
class NotificationModel extends Notification {
  final int pk;
  final String text;
  final DateTime created;

  @JsonKey(name: "author_avatar")
  final String authAvatar;

  @JsonKey(name: "author_name")
  final String authorName;

  @JsonKey(name: "event_date")
  final DateTime eventDate;

  @JsonKey(name: "is_read")
  final bool isRead;

  @JsonKey(name: "obj_pk")
  final int objPk;

  @JsonKey(name: "obj_type")
  final String objType;

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
