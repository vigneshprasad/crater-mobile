// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingModel _$MeetingModelFromJson(Map<String, dynamic> json) {
  return MeetingModel(
    config: json['config'] as int,
    end: json['end'] == null ? null : DateTime.parse(json['end'] as String),
    isCanceled: json['is_canceled'] as bool,
    isPast: json['is_past'] as bool,
    link: json['link'] as String,
    participants: (json['participants'] as List)
        ?.map((e) => e == null
            ? null
            : MeetingParticipantModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    pk: json['pk'] as int,
    start:
        json['start'] == null ? null : DateTime.parse(json['start'] as String),
    timeSlot: json['time_slot'] as int,
    status: _$enumDecodeNullable(_$MeetingStatusEnumMap, json['status']),
    participantDetail: json['participant_detail'] == null
        ? null
        : MeetingParticipantModel.fromJson(
            json['participant_detail'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MeetingModelToJson(MeetingModel instance) =>
    <String, dynamic>{
      'config': instance.config,
      'end': instance.end?.toIso8601String(),
      'is_canceled': instance.isCanceled,
      'is_past': instance.isPast,
      'link': instance.link,
      'participants': instance.participants,
      'pk': instance.pk,
      'start': instance.start?.toIso8601String(),
      'status': _$MeetingStatusEnumMap[instance.status],
      'time_slot': instance.timeSlot,
      'participant_detail': instance.participantDetail,
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

const _$MeetingStatusEnumMap = {
  MeetingStatus.confirmed: 'confirmed',
  MeetingStatus.cancelled: 'cancelled',
  MeetingStatus.pending: 'pending',
  MeetingStatus.rescheduled: 'rescheduled',
};
