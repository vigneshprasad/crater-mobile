// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationHiveAdapter extends TypeAdapter<NotificationHive> {
  @override
  final int typeId = 7;

  @override
  NotificationHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationHive();
  }

  @override
  void write(BinaryWriter writer, NotificationHive obj) {
    writer..writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationHive _$NotificationHiveFromJson(Map<String, dynamic> json) {
  return NotificationHive(
    messageNotifications: (json['messageNotifications'] as List)
        ?.map((e) => e == null
            ? null
            : MessageNotification.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$NotificationHiveToJson(NotificationHive instance) =>
    <String, dynamic>{
      'messageNotifications': instance.messageNotifications,
    };
