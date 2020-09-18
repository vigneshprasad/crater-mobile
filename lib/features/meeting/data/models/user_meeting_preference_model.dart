import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/user_meeting_preference_entity.dart';

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

  final String objective;

  final List<int> interests;

  @JsonKey(name: 'time_slots')
  final List<int> timeSlots;

  UserMeetingPreferenceModel({
    this.pk,
    this.user,
    this.meeting,
    this.numberOfMeetings,
    this.objective,
    this.interests,
    this.timeSlots,
  });

  factory UserMeetingPreferenceModel.fromJson(Map<String, dynamic> json) =>
      _$UserMeetingPreferenceModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserMeetingPreferenceModelToJson(this);
}
