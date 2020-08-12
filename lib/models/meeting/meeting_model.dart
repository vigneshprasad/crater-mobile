import 'package:json_annotation/json_annotation.dart';

part 'meeting_model.g.dart';

@JsonSerializable()
class Meeting {
  final int pk;

  final String title;

  @JsonKey(name: 'week_start_date')
  final String weekStartDate;

  @JsonKey(name: 'week_end_date')
  final String weekEndDate;

  @JsonKey(name: 'is_registration_open')
  final bool isRegistrationOpen;

  @JsonKey(name: 'is_active')
  final bool isActive;

  @JsonKey(name: 'available_time_slots')
  final Map<String, List<TimeSlot>> availableTimeSlots;

  Meeting({
    this.pk,
    this.title,
    this.weekStartDate,
    this.weekEndDate,
    this.isRegistrationOpen,
    this.isActive,
    this.availableTimeSlots,
  });

  factory Meeting.fromJson(Map<String, dynamic> json) =>
      _$MeetingFromJson(json);
  Map<String, dynamic> toJson() => _$MeetingToJson(this);
}

@JsonSerializable()
class UserMeetingPreference {
  final int pk;

  final String user;

  final int meeting;

  @JsonKey(name: 'number_of_meetings')
  final int numberOfMeetings;

  final String objective;

  final List<int> interests;

  @JsonKey(name: 'time_slots')
  final List<int> timeSlots;

  UserMeetingPreference({
    this.pk,
    this.user,
    this.meeting,
    this.numberOfMeetings,
    this.objective,
    this.interests,
    this.timeSlots,
  });

  factory UserMeetingPreference.fromJson(Map<String, dynamic> json) =>
      _$UserMeetingPreferenceFromJson(json);
  Map<String, dynamic> toJson() => _$UserMeetingPreferenceToJson(this);

  UserMeetingPreference copyWith({
    int pk,
    String user,
    int meeting,
    int numberOfMeetings,
    String objective,
    List<int> interests,
    List<int> timeSlots,
  }) {
    return UserMeetingPreference(
      pk: pk ?? this.pk,
      user: user ?? this.user,
      meeting: meeting ?? this.meeting,
      numberOfMeetings: numberOfMeetings ?? this.numberOfMeetings,
      objective: objective ?? this.objective,
      interests: interests ?? this.interests,
      timeSlots: timeSlots ?? this.timeSlots,
    );
  }
}

@JsonSerializable()
class Interest {
  final int pk;
  final String name;
  final String icon;

  Interest({
    this.pk,
    this.name,
    this.icon,
  });

  factory Interest.fromJson(Map<String, dynamic> json) =>
      _$InterestFromJson(json);
  Map<String, dynamic> toJson() => _$InterestToJson(this);
}

@JsonSerializable()
class MeetingObjective {
  final String key;
  final String label;

  MeetingObjective({
    this.key,
    this.label,
  });

  factory MeetingObjective.fromJson(Map<String, dynamic> json) =>
      _$MeetingObjectiveFromJson(json);
  Map<String, dynamic> toJson() => _$MeetingObjectiveToJson(this);
}

@JsonSerializable()
class TimeSlot {
  final int pk;
  final String end;
  final String start;

  TimeSlot({
    this.pk,
    this.end,
    this.start,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotFromJson(json);
  Map<String, dynamic> toJson() => _$TimeSlotToJson(this);
}
