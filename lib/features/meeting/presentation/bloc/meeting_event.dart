part of 'meeting_bloc.dart';

abstract class MeetingEvent extends Equatable {
  const MeetingEvent();

  @override
  List<Object> get props => [];
}

class GetMeetingConfigStarted extends MeetingEvent {
  const GetMeetingConfigStarted();
}

class PostMeetingPreferencesStarted extends MeetingEvent {
  final List<int> interests;
  final int meeting;
  final int numberOfMeetings;
  final String objective;
  final List<int> timeSlots;

  const PostMeetingPreferencesStarted({
    @required this.interests,
    @required this.meeting,
    @required this.numberOfMeetings,
    @required this.objective,
    @required this.timeSlots,
  });

  @override
  List<Object> get props => [
        interests,
        meeting,
        numberOfMeetings,
        objective,
        timeSlots,
      ];
}
