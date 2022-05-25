// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatMessageModelAdapter extends TypeAdapter<ChatMessageModel> {
  @override
  final int typeId = 3;

  @override
  ChatMessageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatMessageModel(
      message: fields[0] as String?,
      file: fields[1] as String?,
      filename: fields[2] as String?,
      fileFormat: fields[3] as String?,
      sender: fields[4] as String?,
      receiver: fields[5] as String?,
      pk: fields[6] as int?,
      photo: fields[7] as String?,
      created: fields[8] as dynamic,
      isRead: fields[9] as bool?,
      senderId: fields[10] as String?,
      receiverId: fields[11] as String?,
      isSupport: fields[12] as bool?,
      senderDetail: fields[13] as ChatUserModel?,
    );
  }

  @override
  void write(BinaryWriter writer, ChatMessageModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.message)
      ..writeByte(1)
      ..write(obj.file)
      ..writeByte(2)
      ..write(obj.filename)
      ..writeByte(3)
      ..write(obj.fileFormat)
      ..writeByte(4)
      ..write(obj.sender)
      ..writeByte(5)
      ..write(obj.receiver)
      ..writeByte(6)
      ..write(obj.pk)
      ..writeByte(7)
      ..write(obj.photo)
      ..writeByte(8)
      ..write(obj.created)
      ..writeByte(9)
      ..write(obj.isRead)
      ..writeByte(10)
      ..write(obj.senderId)
      ..writeByte(11)
      ..write(obj.receiverId)
      ..writeByte(12)
      ..write(obj.isSupport)
      ..writeByte(13)
      ..write(obj.senderDetail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatMessageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessageModel _$ChatMessageModelFromJson(Map<String, dynamic> json) {
  return ChatMessageModel(
    message: json['message'] as String?,
    file: json['file'] as String?,
    filename: json['filename'] as String?,
    fileFormat: json['fileFormat'] as String?,
    sender: json['sender'] as String?,
    receiver: json['receiver'] as String?,
    pk: json['pk'] as int?,
    photo: json['photo'] as String?,
    created: json['created_at'],
    isRead: json['is_read'] as bool?,
    senderId: json['sender_id'] as String?,
    receiverId: json['receiver_id'] as String?,
    isSupport: json['is_support'] as bool?,
    senderDetail: json['sender_details'] == null
        ? null
        : ChatUserModel.fromJson(
            json['sender_details'] as Map<String, dynamic>),
    reaction: json['data'] == null
        ? null
        : ChatReaction.fromJson(json['data'] as Map<String, dynamic>),
    displayName: json['display_name'] as String?,
    firebaseId: json['firebaseId'] as String?,
    type: json['type'] as int?,
    action: json['action'] as int?,
    isFollowing: json['isFollowing'] as bool?,
  );
}

Map<String, dynamic> _$ChatMessageModelToJson(ChatMessageModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'file': instance.file,
      'filename': instance.filename,
      'fileFormat': instance.fileFormat,
      'sender': instance.sender,
      'receiver': instance.receiver,
      'pk': instance.pk,
      'photo': instance.photo,
      'created_at': instance.created,
      'is_read': instance.isRead,
      'sender_id': instance.senderId,
      'receiver_id': instance.receiverId,
      'is_support': instance.isSupport,
      'sender_details': instance.senderDetail,
      'data': instance.reaction,
      'display_name': instance.displayName,
      'firebaseId': instance.firebaseId,
      'type': instance.type,
      'action': instance.action,
      'isFollowing': instance.isFollowing,
    };
