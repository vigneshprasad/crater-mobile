// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationModelAdapter extends TypeAdapter<NotificationModel> {
  @override
  final int typeId = 27;

  @override
  NotificationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationModel();
  }

  @override
  void write(BinaryWriter writer, NotificationModel obj) {
    writer..writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) {
  return NotificationModel(
    pk: json['pk'] as int,
    text: json['text'] as String,
    created: json['created'] == null
        ? null
        : DateTime.parse(json['created'] as String),
    authAvatar: json['author_avatar'] as String,
    authorName: json['author_name'] as String,
    eventDate: json['event_date'] == null
        ? null
        : DateTime.parse(json['event_date'] as String),
    isRead: json['is_read'] as bool,
    objPk: json['obj_pk'] as int,
    objType: json['obj_type'] as String,
  );
}

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'text': instance.text,
      'created': instance.created?.toIso8601String(),
      'author_avatar': instance.authAvatar,
      'author_name': instance.authorName,
      'event_date': instance.eventDate?.toIso8601String(),
      'is_read': instance.isRead,
      'obj_pk': instance.objPk,
      'obj_type': instance.objType,
    };
