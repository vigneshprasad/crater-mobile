// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_failures.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ConversationFailure _$_$_ConversationFailureFromJson(
    Map<String, dynamic> json) {
  return _$_ConversationFailure(
    message: json['error_message'] as String,
    errorCode: _$enumDecodeNullable(
            _$ConversationFailuresTypeEnumMap, json['error_code']) ??
        ConversationFailuresType.genericError,
  );
}

Map<String, dynamic> _$_$_ConversationFailureToJson(
        _$_ConversationFailure instance) =>
    <String, dynamic>{
      'error_message': instance.message,
      'error_code': _$ConversationFailuresTypeEnumMap[instance.errorCode],
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

const _$ConversationFailuresTypeEnumMap = {
  ConversationFailuresType.genericError: 'genericError',
  ConversationFailuresType.groupMaxSpeakersError: 'groupMaxSpeakersError',
};
