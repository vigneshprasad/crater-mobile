// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_tag_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTagModel _$UserTagModelFromJson(Map<String, dynamic> json) {
  return UserTagModel(
    name: json['name'] as String,
    pk: json['pk'] as int,
  );
}

Map<String, dynamic> _$UserTagModelToJson(UserTagModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'pk': instance.pk,
    };
