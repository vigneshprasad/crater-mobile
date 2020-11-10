// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_objective_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingObjectiveModel _$MeetingObjectiveModelFromJson(
    Map<String, dynamic> json) {
  return MeetingObjectiveModel(
    icon: json['icon'] as String,
    name: json['name'] as String,
    pk: json['pk'] as int,
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

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$ObjectiveTypeEnumMap = {
  ObjectiveType.lookingFor: 'looking_for',
  ObjectiveType.lookingTo: 'looking_to',
};
