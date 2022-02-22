// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_failures.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ConversationFailure _$_$_ConversationFailureFromJson(
    Map<String, dynamic> json) {
  return _$_ConversationFailure(
    message: json['error_message'] as String?,
    errorCode:
        _$enumDecode(_$ConversationFailuresTypeEnumMap, json['error_code']),
  );
}

Map<String, dynamic> _$_$_ConversationFailureToJson(
        _$_ConversationFailure instance) =>
    <String, dynamic>{
      'error_message': instance.message,
      'error_code': _$ConversationFailuresTypeEnumMap[instance.errorCode],
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

const _$ConversationFailuresTypeEnumMap = {
  ConversationFailuresType.genericError: 'genericError',
  ConversationFailuresType.groupMaxSpeakersError: 'groupMaxSpeakersError',
  ConversationFailuresType.groupNotFound: 'groupNotFound',
  ConversationFailuresType.groupAlreadyJoined: 'groupAlreadyJoined',
  ConversationFailuresType.seriesAlreadyRSVPed: 'seriesAlreadyRSVPed',
};
