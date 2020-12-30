part of 'meeting_bloc.dart';

abstract class MeetingState extends Equatable {
  final bool loading;
  final dynamic error;
  final MeetingConfig config;
  final List<MeetingsByDate> upcoming;
  final List<MeetingsByDate> past;
  final List<MeetingObjective> objectives;
  final List<MeetingInterest> interests;
  final UserMeetingPreference preference;
  final UserMeetingPreference pastPreferences;
  final Meeting meeting;

  const MeetingState({
    this.loading,
    this.error,
    this.upcoming,
    this.past,
    this.objectives,
    this.interests,
    this.config,
    this.preference,
    this.pastPreferences,
    this.meeting,
  });

  @override
  List<Object> get props => [
        loading,
        error,
        upcoming,
        past,
        objectives,
        interests,
        config,
        pastPreferences,
        meeting,
      ];
}

class MeetingInitial extends MeetingState {
  const MeetingInitial()
      : super(
          loading: false,
          error: null,
          upcoming: const [],
          past: const [],
          config: null,
          preference: null,
          meeting: null,
        );
}

class MeetingGetRequestLoading extends MeetingState {
  const MeetingGetRequestLoading()
      : super(
          loading: true,
          error: null,
        );
}

class MeetingGetConfigLoading extends MeetingState {
  const MeetingGetConfigLoading()
      : super(
          loading: true,
          error: null,
        );
}

class MeetingGetPreferencesLoading extends MeetingState {
  const MeetingGetPreferencesLoading()
      : super(
          loading: true,
          error: null,
        );
}

class MeetingGetInterestsRequestLoading extends MeetingState {
  const MeetingGetInterestsRequestLoading()
      : super(
          loading: true,
          error: null,
        );
}

class MeetingGetObjectivesRequestLoading extends MeetingState {
  const MeetingGetObjectivesRequestLoading()
      : super(
          loading: true,
          error: null,
        );
}

class MeetingPostPreferencesLoading extends MeetingState {
  const MeetingPostPreferencesLoading()
      : super(
          loading: true,
          error: null,
        );
}

class MeetingGetPastPreferencesLoading extends MeetingState {
  const MeetingGetPastPreferencesLoading()
      : super(
          loading: true,
          error: null,
        );
}

class MeetingGetUpcomingRequestLoading extends MeetingState {
  const MeetingGetUpcomingRequestLoading()
      : super(
          loading: true,
          error: null,
        );
}

class MeetingGetUpcomingRequestError extends MeetingState {
  const MeetingGetUpcomingRequestError({
    @required Failure error,
  }) : super(
          loading: true,
          error: error,
        );
}

class MeetingPastRequestError extends MeetingState {
  const MeetingPastRequestError({
    @required Failure error,
  }) : super(
          loading: true,
          error: error,
        );
}

class MeetingGetPastRequestLoading extends MeetingState {
  const MeetingGetPastRequestLoading()
      : super(
          loading: true,
          error: null,
        );
}

class MeetingGetRequestError extends MeetingState {
  const MeetingGetRequestError({@required dynamic error})
      : super(
          loading: false,
          error: error,
        );
}

class MeetingGetInterestsLoaded extends MeetingState {
  const MeetingGetInterestsLoaded({
    @required List<MeetingInterest> interests,
  }) : super(
          loading: false,
          error: null,
          interests: interests,
        );
}

class MeetingGetObjectivesLoaded extends MeetingState {
  const MeetingGetObjectivesLoaded({
    @required List<MeetingObjective> objectives,
  }) : super(
          loading: false,
          error: null,
          objectives: objectives,
        );
}

class MeetingGetPreferencesLoaded extends MeetingState {
  const MeetingGetPreferencesLoaded({
    @required UserMeetingPreference preference,
  }) : super(
          loading: false,
          error: null,
          preference: preference,
        );
}

class MeetingGetPastPreferencesLoaded extends MeetingState {
  const MeetingGetPastPreferencesLoaded({
    @required UserMeetingPreference pastPreferences,
  }) : super(
          loading: false,
          error: null,
          pastPreferences: pastPreferences,
        );
}

class MeetingGetConfigLoaded extends MeetingState {
  const MeetingGetConfigLoaded({
    @required MeetingConfig config,
  }) : super(
          loading: false,
          error: null,
          config: config,
        );
}

class GetUpcomingMeetingsLoaded extends MeetingState {
  const GetUpcomingMeetingsLoaded({
    @required List<MeetingsByDate> upcoming,
  }) : super(
          upcoming: upcoming,
          loading: false,
          error: null,
        );
}

class GetPastMeetingsLoaded extends MeetingState {
  const GetPastMeetingsLoaded({
    @required List<MeetingsByDate> past,
  }) : super(
          past: past,
          loading: false,
          error: null,
        );
}

class PostMeetingPreferencesLoaded extends MeetingState {
  final UserMeetingPreference preferences;

  const PostMeetingPreferencesLoaded({
    @required this.preferences,
  }) : super(
          loading: false,
          error: null,
        );

  @override
  List<Object> get props => [
        loading,
        error,
        preferences,
      ];
}

class PostMeetingPreferenceError extends MeetingState {
  const PostMeetingPreferenceError({
    dynamic error,
  }) : super(
          loading: false,
          error: error,
        );
  @override
  List<Object> get props => [
        loading,
        error,
      ];
}

class PostUserProfileResponseLoaded extends MeetingState {
  final UserProfile profile;

  const PostUserProfileResponseLoaded({
    @required this.profile,
  }) : super(
          loading: false,
          error: null,
        );

  @override
  List<Object> get props => [
        loading,
        error,
        profile,
      ];
}

/// Retrieve Meeting States

class RetrieveMeetingLoading extends MeetingState {
  const RetrieveMeetingLoading()
      : super(
          loading: true,
          error: null,
        );
}

class RetrieveMeetingLoaded extends MeetingState {
  const RetrieveMeetingLoaded({
    @required Meeting meeting,
  }) : super(
          loading: false,
          error: null,
          meeting: meeting,
        );
}

class RetrieveMeetingError extends MeetingState {
  const RetrieveMeetingError({
    @required dynamic error,
  }) : super(
          loading: false,
          error: error,
        );
}

/// Post Meeting RSVP status states

class PostMeetingRsvpStatusLoading extends MeetingState {
  const PostMeetingRsvpStatusLoading()
      : super(
          loading: true,
          error: null,
        );
}

class PostMeetingRsvpStatusLoaded extends MeetingState {
  final MeetingRsvp rsvp;
  const PostMeetingRsvpStatusLoaded({
    @required this.rsvp,
  }) : super(
          loading: false,
          error: null,
        );
}

class PostMeetingRsvpStatusError extends MeetingState {
  const PostMeetingRsvpStatusError({
    @required dynamic error,
  }) : super(
          loading: false,
          error: error,
        );
}
