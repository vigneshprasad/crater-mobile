// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_failures.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ConversationFailure _$$_ConversationFailureFromJson(
        Map<String, dynamic> json) =>
    _$_ConversationFailure(
      message: json['error_message'] as String?,
      errorCode: $enumDecodeNullable(
              _$ConversationFailuresTypeEnumMap, json['error_code']) ??
          ConversationFailuresType.genericError,
    );

Map<String, dynamic> _$$_ConversationFailureToJson(
        _$_ConversationFailure instance) =>
    <String, dynamic>{
      'error_message': instance.message,
      'error_code': _$ConversationFailuresTypeEnumMap[instance.errorCode]!,
    };

const _$ConversationFailuresTypeEnumMap = {
  ConversationFailuresType.genericError: 'genericError',
  ConversationFailuresType.groupMaxSpeakersError: 'groupMaxSpeakersError',
  ConversationFailuresType.groupNotFound: 'groupNotFound',
  ConversationFailuresType.groupAlreadyJoined: 'groupAlreadyJoined',
  ConversationFailuresType.seriesAlreadyRSVPed: 'seriesAlreadyRSVPed',
  ConversationFailuresType.groupStartDateTimeNotInFuture:
      'groupStartDateTimeNotInFuture',
  ConversationFailuresType.groupStartLessThan24Hours:
      'groupStartLessThan24Hours',
};
