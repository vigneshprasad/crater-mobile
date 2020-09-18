part of 'meeting_bloc.dart';

abstract class MeetingState extends Equatable {
  final bool loading;
  final dynamic error;

  const MeetingState({
    this.loading,
    this.error,
  });

  @override
  List<Object> get props => [loading, error];
}

class MeetingInitial extends MeetingState {
  const MeetingInitial()
      : super(
          loading: false,
          error: null,
        );
}

class MeetingGetRequestLoading extends MeetingState {
  const MeetingGetRequestLoading()
      : super(
          loading: true,
          error: null,
        );
}

class MeetingRequestError extends MeetingState {
  const MeetingRequestError({@required dynamic error})
      : super(
          loading: false,
          error: error,
        );
}

class GetMeetingConfigLoaded extends MeetingState {
  final MeetingConfig meeting;
  final UserMeetingPreference preferences;
  final List<MeetingInterest> interests;
  final List<MeetingObjective> objectives;

  const GetMeetingConfigLoaded({
    @required this.meeting,
    @required this.preferences,
    @required this.interests,
    @required this.objectives,
  });

  @override
  List<Object> get props => [
        loading,
        error,
        meeting,
        preferences,
        interests,
        objectives,
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
