// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_chat_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserChatModelAdapter extends TypeAdapter<UserChatModel> {
  @override
  final int typeId = 2;

  @override
  UserChatModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserChatModel(
      recieverId: fields[0] as String?,
      receiverUser: fields[1] as ChatUserModel?,
      page: fields[2] as int?,
      pages: fields[3] as int?,
      messages: (fields[4] as HiveList?)?.castHiveList(),
      unreadCount: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, UserChatModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.recieverId)
      ..writeByte(1)
      ..write(obj.receiverUser)
      ..writeByte(2)
      ..write(obj.page)
      ..writeByte(3)
      ..write(obj.pages)
      ..writeByte(4)
      ..write(obj.messages)
      ..writeByte(5)
      ..write(obj.unreadCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserChatModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
