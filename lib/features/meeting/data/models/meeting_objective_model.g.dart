// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_objective_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingObjectiveModel _$MeetingObjectiveModelFromJson(
    Map<String, dynamic> json) {
  return MeetingObjectiveModel(
    icon: json['icon'] as String?,
    name: json['name'] as String?,
    pk: json['pk'] as int?,
    type: _$enumDecodeNullable(_$ObjectiveTypeEnumMap, json['type']),
  );
}

Map<String, dynamic> _$MeetingObjectiveModelToJson(
        MeetingObjectiveModel instance) =>
    <String, dynamic>{
      'icon': instance.icon,
      'name': instance.name,
      'pk': instance.pk,
      'type': _$ObjectiveTypeEnumMap[instance.type],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$ObjectiveTypeEnumMap = {
  ObjectiveType.lookingFor: 'looking_for',
  ObjectiveType.lookingTo: 'looking_to',
};
