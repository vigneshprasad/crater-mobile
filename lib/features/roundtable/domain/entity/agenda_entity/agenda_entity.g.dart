// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agenda_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Agenda _$_$_AgendaFromJson(Map<String, dynamic> json) {
  return _$_Agenda(
    name: json['name'] as String,
    creator: json['creator'] as String,
    category: json['category'] == null
        ? null
        : Category.fromJson(json['category'] as Map<String, dynamic>),
    isApproved: json['is_approved'] as bool,
    isActive: json['is_active'] as bool,
  );
}

Map<String, dynamic> _$_$_AgendaToJson(_$_Agenda instance) => <String, dynamic>{
      'name': instance.name,
      'creator': instance.creator,
      'category': instance.category,
      'is_approved': instance.isApproved,
      'is_active': instance.isActive,
    };
