// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ConversationRequest _$_$_ConversationRequestFromJson(
    Map<String, dynamic> json) {
  return _$_ConversationRequest(
    pk: json['pk'] as int?,
    group: json['group'] as int?,
    groupDetail: json['group_detail'] == null
        ? null
        : Conversation.fromJson(json['group_detail'] as Map<String, dynamic>),
    participantType:
        _$enumDecodeNullable(_$ParticpantTypeEnumMap, json['participant_type']),
    status: _$enumDecodeNullable(_$RequestStatusEnumMap, json['status']),
  );
}

Map<String, dynamic> _$_$_ConversationRequestToJson(
        _$_ConversationRequest instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'group': instance.group,
      'group_detail': instance.groupDetail,
      'participant_type': _$ParticpantTypeEnumMap[instance.participantType],
      'status': _$RequestStatusEnumMap[instance.status],
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

const _$ParticpantTypeEnumMap = {
  ParticpantType.speaker: 1,
  ParticpantType.attendee: 2,
};

const _$RequestStatusEnumMap = {
  RequestStatus.pending: 0,
  RequestStatus.accepted: 1,
  RequestStatus.declined: 2,
};
