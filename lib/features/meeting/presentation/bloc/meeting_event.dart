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

class GetUpcomingMeetingsStarted extends MeetingEvent {
  const GetUpcomingMeetingsStarted();
}

class GetPastMeetingStarted extends MeetingEvent {
  const GetPastMeetingStarted();
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

class RetrieveMeetingDetailStarted extends MeetingEvent {
  final int meetingId;

  const RetrieveMeetingDetailStarted({
    @required this.meetingId,
  });

  @override
  List<Object> get props => [meetingId];
}

class PostMeetingRsvpStatusStarted extends MeetingEvent {
  final MeetingRsvpStatus status;
  final int meetingId;

  const PostMeetingRsvpStatusStarted({
    @required this.status,
    @required this.meetingId,
  });

  @override
  List<Object> get props => [
        status,
        meetingId,
      ];
}

class GetMeetingRescheduleSlotsStarted extends MeetingEvent {
  const GetMeetingRescheduleSlotsStarted();
}

class PostMeetingRescheduleRsvpStarted extends MeetingEvent {
  final int oldMeeting;
  final String requestedBy;
  final List<DateTime> timeSlots;

  const PostMeetingRescheduleRsvpStarted({
    this.oldMeeting,
    this.requestedBy,
    this.timeSlots,
  });

  @override
  List<Object> get props => [
        oldMeeting,
        requestedBy,
        timeSlots,
      ];
}

class GetRescheduleRequestStarted extends MeetingEvent {
  final int meetingId;

  const GetRescheduleRequestStarted({
    @required this.meetingId,
  });

  @override
  List<Object> get props => [
        meetingId,
      ];
}

class PostConfirmRescheduleRequestStarted extends MeetingEvent {
  final DateTime timeSlot;
  final int rescheduleRequest;

  const PostConfirmRescheduleRequestStarted({
    @required this.timeSlot,
    @required this.rescheduleRequest,
  });

  @override
  List<Object> get props => [
        timeSlot,
        rescheduleRequest,
      ];
}
