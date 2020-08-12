part of 'meeting_bloc.dart';

abstract class MeetingState extends Equatable {
  final bool loading;
  final Meeting meeting;
  final UserMeetingPreference userPrefs;
  final List<MeetingObjective> objectives;
  final List<Interest> interests;
  final dynamic error;

  const MeetingState({
    this.loading,
    this.meeting,
    this.userPrefs,
    this.objectives,
    this.interests,
    this.error,
  });
}

class MeetingInitial extends MeetingState {
  MeetingInitial()
      : super(
          loading: false,
          objectives: [],
          interests: [],
          error: null,
        );

  @override
  List<Object> get props => [];
}

class MeetingGetLoading extends MeetingState {
  const MeetingGetLoading() : super(loading: true);

  @override
  List<Object> get props => [true];
}

class MeetingGetSucess extends MeetingState {
  final MeetingsResponse response;

  MeetingGetSucess({this.response})
      : super(
          loading: false,
          objectives: response.objectives,
          interests: response.interests,
          userPrefs: response.userPreferences,
          meeting: Meeting(
            pk: response.pk,
            title: response.title,
            weekStartDate: response.weekStartDate,
            weekEndDate: response.weekEndDate,
            isActive: response.isActive,
            isRegistrationOpen: response.isRegistrationOpen,
            availableTimeSlots: response.availableTimeSlots,
          ),
        );

  @override
  List<Object> get props => [meeting, userPrefs, objectives, interests];
}

class MeetingGetError extends MeetingState {
  const MeetingGetError({error})
      : super(
          loading: false,
          error: error,
        );

  @override
  List<Object> get props => [error];
}
