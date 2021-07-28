import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../meeting/data/models/meeting_interest_model.dart';
import '../../../../meeting/data/models/time_slot_model.dart';
import '../topic_entity/topic_entity.dart';

part 'optin_entity.freezed.dart';
part 'optin_entity.g.dart';

@freezed
abstract class Optin with _$Optin {
  factory Optin({
    int? pk,
    String? user,
    int? meeting,
    int? topic,
    @JsonKey(name: "topic_detail") Topic? topicDetail,
    @JsonKey(name: "number_of_meetings") int? numberOfMeetings,
    @JsonKey(name: "number_of_meetings_per_month")
        int? numberOfMeetingsPerMonth,
    List<int>? objectives,
    List<int>? interests,
    @JsonKey(name: "interest_list") List<MeetingInterestModel>? interestList,
    @JsonKey(name: "time_slots") List<int>? timeSlots,
    @JsonKey(name: "time_slot_list") List<TimeSlotModel>? timeSlotList,
  }) = _Optin;

  factory Optin.fromJson(Map<String, dynamic> json) => _$OptinFromJson(json);
}

@freezed
abstract class OptinsByDate with _$OptinsByDate {
  factory OptinsByDate({
    DateTime? date,
    List<Optin>? optins,
  }) = _OptinsByDate;

  factory OptinsByDate.fromJson(Map<String, dynamic> json) =>
      _$OptinsByDateFromJson(json);
}
