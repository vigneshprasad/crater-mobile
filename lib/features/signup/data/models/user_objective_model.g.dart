// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_objective_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserObjectiveModel _$UserObjectiveModelFromJson(Map<String, dynamic> json) {
  return UserObjectiveModel(
    pk: json['pk'] as int,
    icon: json['icon'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$UserObjectiveModelToJson(UserObjectiveModel instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'icon': instance.icon,
      'name': instance.name,
    };
