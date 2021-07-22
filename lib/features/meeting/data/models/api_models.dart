import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'meeting_interest_model.dart';
import 'meeting_objective_model.dart';
import 'time_slot_model.dart';
import 'user_meeting_preference_model.dart';

part 'api_models.g.dart';

@JsonSerializable()
class GetMeetingConfigApiResponse extends Equatable {
  final int pk;
  final String title;
  final List<MeetingInterestModel> interests;
  final List<MeetingObjectiveModel> objectives;

  @JsonKey(name: "is_active")
  final bool isActive;

  @JsonKey(name: "available_time_slots")
  final Map<String, List<TimeSlotModel>> availableTimeSlots;

  @JsonKey(name: "week_end_date")
  final String weekEndDate;

  @JsonKey(name: "week_start_date")
  final String weekStartDate;

  @JsonKey(name: "is_registration_open")
  final bool isRegistrationOpen;

  @JsonKey(name: "user_preferences")
  final UserMeetingPreferenceModel userPreferences;

  const GetMeetingConfigApiResponse({
    required this.pk,
    required this.title,
    required this.interests,
    required this.objectives,
    required this.isActive,
    required this.availableTimeSlots,
    required this.weekEndDate,
    required this.weekStartDate,
    required this.isRegistrationOpen,
    required this.userPreferences,
  });

  @override
  List<Object> get props => [
        pk,
        title,
        interests,
        objectives,
        isActive,
        availableTimeSlots,
        weekEndDate,
        weekStartDate,
        isRegistrationOpen,
        userPreferences,
      ];

  factory GetMeetingConfigApiResponse.fromJson(Map<String, dynamic> json) =>
      _$GetMeetingConfigApiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetMeetingConfigApiResponseToJson(this);
}
