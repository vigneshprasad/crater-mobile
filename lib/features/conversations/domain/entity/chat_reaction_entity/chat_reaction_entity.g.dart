// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_reaction_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChatReaction _$_$_ChatReactionFromJson(Map<String, dynamic> json) {
  return _$_ChatReaction(
    id: json['id'] as int?,
    name: json['name'] as String?,
    image: json['image'] as String?,
    file: json['file'] as String?,
    isActive: json['isActive'] as bool? ?? true,
  );
}

Map<String, dynamic> _$_$_ChatReactionToJson(_$_ChatReaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'file': instance.file,
      'isActive': instance.isActive,
    };
