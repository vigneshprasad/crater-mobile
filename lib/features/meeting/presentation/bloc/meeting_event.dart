part of 'meeting_bloc.dart';

abstract class MeetingEvent extends Equatable {
  const MeetingEvent();

  @override
  List<Object> get props => [];
}

class GetMeetingConfigStarted extends MeetingEvent {
  const GetMeetingConfigStarted();
}

class GetMeetingStarted extends MeetingEvent {
  const GetMeetingStarted();
}

class GetMeetingInterestsStarted extends MeetingEvent {
  const GetMeetingInterestsStarted();
}

class GetMeetingObjectivesStarted extends MeetingEvent {
  const GetMeetingObjectivesStarted();
}

class GetMeetingPreferencesStarted extends MeetingEvent {
  const GetMeetingPreferencesStarted();
}

class GetPastMeetingPreferencesStarted extends MeetingEvent {
  const GetPastMeetingPreferencesStarted();
}

class PostMeetingPreferencesStarted extends MeetingEvent {
  final List<MeetingInterest> interests;
  final MeetingConfig config;
  final NumberOfMeetings numberOfMeetings;
  final List<MeetingObjective> objectives;
  final List<TimeSlot> timeSlots;

  const PostMeetingPreferencesStarted({
    @required this.interests,
    @required this.config,
    @required this.numberOfMeetings,
    @required this.objectives,
    @required this.timeSlots,
  });

  @override
  List<Object> get props => [
        interests,
        config,
        numberOfMeetings,
        objectives,
        timeSlots,
      ];
}

class PostUserProfileRequestStarted extends MeetingEvent {
  final Map<String, dynamic> requestBody;

  const PostUserProfileRequestStarted({
    this.requestBody,
  });

  @override
  List<Object> get props => [requestBody];
}
