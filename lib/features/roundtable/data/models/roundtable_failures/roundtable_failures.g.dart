// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roundtable_failures.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RoundTableFailure _$_$_RoundTableFailureFromJson(Map<String, dynamic> json) {
  return _$_RoundTableFailure(
    message: json['error_message'] as String,
    errorCode: _$enumDecodeNullable(
        _$RoundTableFailureTypeEnumMap, json['error_code']),
  );
}

Map<String, dynamic> _$_$_RoundTableFailureToJson(
        _$_RoundTableFailure instance) =>
    <String, dynamic>{
      'error_message': instance.message,
      'error_code': _$RoundTableFailureTypeEnumMap[instance.errorCode],
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

const _$RoundTableFailureTypeEnumMap = {
  RoundTableFailureType.groupMaxSpeakersError: 'groupMaxSpeakersError',
};
