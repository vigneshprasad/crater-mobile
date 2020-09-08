// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_slot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeSlotModel _$TimeSlotModelFromJson(Map<String, dynamic> json) {
  return TimeSlotModel(
    pk: json['pk'] as int,
    end: json['end'] as String,
    start: json['start'] as String,
  );
}

Map<String, dynamic> _$TimeSlotModelToJson(TimeSlotModel instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'end': instance.end,
      'start': instance.start,
    };
