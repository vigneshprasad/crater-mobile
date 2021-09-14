// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingRequestModel _$MeetingRequestModelFromJson(Map<String, dynamic> json) {
  return MeetingRequestModel(
    id: json['id'] as int?,
    expiresAt: json['expires_at'] == null
        ? null
        : DateTime.parse(json['expires_at'] as String),
    status: _$enumDecodeNullable(_$MeetingRequestStatusEnumMap, json['status']),
    timeSlots: (json['time_slots'] as List<dynamic>?)
        ?.map((e) => DateTime.parse(e as String))
        .toList(),
    requestedBy: json['requested_by'] as String?,
    requestedTo: json['requested_to'] as String?,
    isPast: json['is_past'] as bool?,
    participantDetail: json['participant_detail'] == null
        ? null
        : MeetingParticipantModel.fromJson(
            json['participant_detail'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MeetingRequestModelToJson(
        MeetingRequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'expires_at': instance.expiresAt?.toIso8601String(),
      'status': _$MeetingRequestStatusEnumMap[instance.status],
      'time_slots':
          instance.timeSlots?.map((e) => e.toIso8601String()).toList(),
      'requested_by': instance.requestedBy,
      'requested_to': instance.requestedTo,
      'is_past': instance.isPast,
      'participant_detail': instance.participantDetail,
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

const _$MeetingRequestStatusEnumMap = {
  MeetingRequestStatus.confirmed: 'confirmed',
  MeetingRequestStatus.pendingApproval: 'pending_approval',
  MeetingRequestStatus.declined: 'declined',
};
