// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_rsvp_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingRsvpModel _$MeetingRsvpModelFromJson(Map<String, dynamic> json) {
  return MeetingRsvpModel(
    pk: json['pk'] as int,
    status: _$enumDecodeNullable(_$MeetingRsvpStatusEnumMap, json['status']),
  );
}

Map<String, dynamic> _$MeetingRsvpModelToJson(MeetingRsvpModel instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'status': _$MeetingRsvpStatusEnumMap[instance.status],
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

const _$MeetingRsvpStatusEnumMap = {
  MeetingRsvpStatus.attending: 'attending',
  MeetingRsvpStatus.pending: 'pending',
  MeetingRsvpStatus.notAttending: 'not_attending',
  MeetingRsvpStatus.reschedule: 'reschedule',
};
