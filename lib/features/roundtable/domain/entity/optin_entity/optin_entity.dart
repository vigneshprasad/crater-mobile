import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:worknetwork/features/meeting/data/models/meeting_interest_model.dart';
import 'package:worknetwork/features/meeting/data/models/meeting_objective_model.dart';
import 'package:worknetwork/features/meeting/data/models/time_slot_model.dart';

part 'optin_entity.freezed.dart';
part 'optin_entity.g.dart';

@freezed
abstract class Optin with _$Optin {
  factory Optin({
    int pk,
    String user,
    int meeting,
    @JsonKey(name: "number_of_meetings") int numberOfMeetings,
    @JsonKey(name: "number_of_meetings_per_month") int numberOfMeetingsPerMonth,
    List<MeetingObjectiveModel> objectives,
    List<MeetingInterestModel> interests,
    @JsonKey(name: "time_slots") List<TimeSlotModel> timeSlots,
  }) = _Optin;

  factory Optin.fromJson(Map<String, dynamic> json) => _$OptinFromJson(json);
}
