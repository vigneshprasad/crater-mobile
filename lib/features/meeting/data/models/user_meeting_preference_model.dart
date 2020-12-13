import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/user_meeting_preference_entity.dart';
import 'meeting_interest_model.dart';
import 'meeting_objective_model.dart';

part 'user_meeting_preference_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

@JsonSerializable()
class UserMeetingPreferenceModel extends UserMeetingPreference {
  final int pk;

  final String user;

  final int meeting;

  @JsonKey(name: 'number_of_meetings')
  final int numberOfMeetings;

  @JsonKey(name: 'number_of_meetings_per_month')
  final int numberOfMeetingsPerMonth;

  final List<MeetingObjectiveModel> objectives;

  final List<MeetingInterestModel> interests;

  @JsonKey(name: 'time_slots')
  final List<int> timeSlots;

  UserMeetingPreferenceModel({
    this.pk,
    this.user,
    this.meeting,
    this.numberOfMeetings,
    this.numberOfMeetingsPerMonth,
    this.objectives,
    this.interests,
    this.timeSlots,
  }) : super(
          pk: pk,
          user: user,
          meeting: meeting,
          numberOfMeetings: numberOfMeetings,
          numberOfMeetingsPerMonth: numberOfMeetingsPerMonth,
          objectives: objectives,
          interests: interests,
          timeSlots: timeSlots,
        );

  factory UserMeetingPreferenceModel.fromJson(Map<String, dynamic> json) =>
      _$UserMeetingPreferenceModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserMeetingPreferenceModelToJson(this);
}
