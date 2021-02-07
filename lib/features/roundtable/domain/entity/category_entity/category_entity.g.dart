// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Category _$_$_CategoryFromJson(Map<String, dynamic> json) {
  return _$_Category(
    name: json['name'] as String,
    image: json['image'] as String,
    isActive: json['is_active'] as bool,
  );
}

Map<String, dynamic> _$_$_CategoryToJson(_$_Category instance) =>
    <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'is_active': instance.isActive,
    };
