// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatUser _$ChatUserFromJson(Map<String, dynamic> json) => ChatUser(
      pk: json['pk'] as String?,
      name: json['name'] as String? ?? '',
      photo: json['photo'] as String?,
      unreadCount: json['unread_count'] as int?,
      isStarred: json['is_starred'] as bool?,
      lastSeen: json['last_seen'] == null
          ? null
          : DateTime.parse(json['last_seen'] as String),
      displayName: json['display_name'] as String?,
      firstName: json['first_name'] as String?,
    );

Map<String, dynamic> _$ChatUserToJson(ChatUser instance) => <String, dynamic>{
      'pk': instance.pk,
      'name': instance.name,
      'photo': instance.photo,
      'unread_count': instance.unreadCount,
      'is_starred': instance.isStarred,
      'last_seen': instance.lastSeen?.toIso8601String(),
      'display_name': instance.displayName,
      'first_name': instance.firstName,
    };
