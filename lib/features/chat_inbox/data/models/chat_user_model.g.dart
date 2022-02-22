// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatUserModelAdapter extends TypeAdapter<ChatUserModel> {
  @override
  final int typeId = 4;

  @override
  ChatUserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatUserModel(
      pk: fields[0] as String?,
      name: fields[1] as String,
      photo: fields[2] as String?,
      unreadCount: fields[3] as int?,
      isStarred: fields[4] as bool?,
      lastSeen: fields[5] as DateTime?,
      latestMessage: fields[6] as ChatMessageModel?,
      displayName: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ChatUserModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.pk)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.photo)
      ..writeByte(3)
      ..write(obj.unreadCount)
      ..writeByte(4)
      ..write(obj.isStarred)
      ..writeByte(5)
      ..write(obj.lastSeen)
      ..writeByte(6)
      ..write(obj.latestMessage)
      ..writeByte(7)
      ..write(obj.displayName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatUserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatUserModel _$ChatUserModelFromJson(Map<String, dynamic> json) {
  return ChatUserModel(
    pk: json['pk'] as String?,
    name: json['name'] as String,
    photo: json['photo'] as String?,
    unreadCount: json['unread_count'] as int?,
    isStarred: json['is_starred'] as bool?,
    lastSeen: json['last_seen'] == null
        ? null
        : DateTime.parse(json['last_seen'] as String),
    latestMessage: json['latest_message'] == null
        ? null
        : ChatMessageModel.fromJson(
            json['latest_message'] as Map<String, dynamic>),
    displayName: json['display_name'] as String?,
  );
}

Map<String, dynamic> _$ChatUserModelToJson(ChatUserModel instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'name': instance.name,
      'photo': instance.photo,
      'unread_count': instance.unreadCount,
      'is_starred': instance.isStarred,
      'last_seen': instance.lastSeen?.toIso8601String(),
      'latest_message': instance.latestMessage,
      'display_name': instance.displayName,
    };
