part of 'meeting_bloc.dart';

abstract class MeetingState extends Equatable {
  final bool loading;
  final dynamic error;
  final MeetingConfig config;
  final List<Meeting> upcoming;
  final List<Meeting> past;
  final List<MeetingObjective> objectives;
  final List<MeetingInterest> interests;
  final UserMeetingPreference preference;
  final UserMeetingPreference pastPreferences;

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

class GetMeetingLoaded extends MeetingState {
  const GetMeetingLoaded({
    @required List<Meeting> upcoming,
    @required List<Meeting> past,
  }) : super(
          loading: false,
          error: null,
          upcoming: upcoming,
          past: past,
        );

  @override
  List<Object> get props => [
        loading,
        error,
        upcoming,
        past,
      ];
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
