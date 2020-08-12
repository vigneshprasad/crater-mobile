part of 'meeting_bloc.dart';

abstract class MeetingEvent extends Equatable {
  const MeetingEvent();
}

class MeetingGetStarted extends MeetingEvent {
  @override
  List<Object> get props => [];
}
