part of 'meeting_bloc.dart';

abstract class MeetingEvent extends Equatable {
  const MeetingEvent();

  @override
  List<Object> get props => [];
}

class GetMeetingConfigStarted extends MeetingEvent {
  const GetMeetingConfigStarted();
}
