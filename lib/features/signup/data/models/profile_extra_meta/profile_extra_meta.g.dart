// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_extra_meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Option _$_$_OptionFromJson(Map<String, dynamic> json) {
  return _$_Option(
    name: json['name'] as String,
    value: json['value'] as int,
  );
}

Map<String, dynamic> _$_$_OptionToJson(_$_Option instance) => <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
    };

_$_FormFieldData _$_$_FormFieldDataFromJson(Map<String, dynamic> json) {
  return _$_FormFieldData(
    type: _$enumDecode(_$FieldTypeEnumMap, json['type']),
    options: (json['options'] as List<dynamic>?)
        ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
        .toList(),
    label: json['label'] as String,
    blank: json['blank'] as bool,
  );
}

Map<String, dynamic> _$_$_FormFieldDataToJson(_$_FormFieldData instance) =>
    <String, dynamic>{
      'type': _$FieldTypeEnumMap[instance.type],
      'options': instance.options,
      'label': instance.label,
      'blank': instance.blank,
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

const _$FieldTypeEnumMap = {
  FieldType.textField: 'text-field',
  FieldType.multiSelect: 'multi-select',
  FieldType.dropDown: 'drop-down',
};

_$_ProfileExtraMeta _$_$_ProfileExtraMetaFromJson(Map<String, dynamic> json) {
  return _$_ProfileExtraMeta(
    question: json['question'] as String,
    meta: (json['meta'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, FormFieldData.fromJson(e as Map<String, dynamic>)),
    ),
  );
}

Map<String, dynamic> _$_$_ProfileExtraMetaToJson(
        _$_ProfileExtraMeta instance) =>
    <String, dynamic>{
      'question': instance.question,
      'meta': instance.meta,
    };
