// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_rsvp_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingRsvpModel _$MeetingRsvpModelFromJson(Map<String, dynamic> json) {
  return MeetingRsvpModel(
    pk: json['pk'] as int,
    status: _$enumDecode(_$MeetingRsvpStatusEnumMap, json['status']),
  );
}

Map<String, dynamic> _$MeetingRsvpModelToJson(MeetingRsvpModel instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'status': _$MeetingRsvpStatusEnumMap[instance.status],
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

const _$MeetingRsvpStatusEnumMap = {
  MeetingRsvpStatus.attending: 'attending',
  MeetingRsvpStatus.pending: 'pending',
  MeetingRsvpStatus.notAttending: 'not_attending',
  MeetingRsvpStatus.reschedule: 'reschedule',
};
