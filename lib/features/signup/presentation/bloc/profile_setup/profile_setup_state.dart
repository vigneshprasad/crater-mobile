part of 'profile_setup_bloc.dart';

abstract class ProfileSetupState extends Equatable {
  final bool loading;
  final Failure error;

  const ProfileSetupState({
    @required this.loading,
    @required this.error,
  });

  @override
  List<Object> get props => [loading, error];
}

class ProfileSetupInitial extends ProfileSetupState {
  const ProfileSetupInitial()
      : super(
          loading: false,
          error: null,
        );
}

class ProfileSetupRequestLoading extends ProfileSetupState {
  const ProfileSetupRequestLoading()
      : super(
          loading: true,
          error: null,
        );
}

class ProfileSetupRequestError extends ProfileSetupState {
  const ProfileSetupRequestError({
    @required Failure error,
  }) : super(
          loading: false,
          error: error,
        );
}

class ProfileUserTagsRequestLoaded extends ProfileSetupState {
  final List<UserTag> tags;

  const ProfileUserTagsRequestLoaded({
    this.tags,
  }) : super(
          loading: false,
          error: null,
        );

  @override
  List<Object> get props => [loading, error, tags];
}

class PostUserProfileRequestLoaded extends ProfileSetupState {
  final UserProfile profile;

  const PostUserProfileRequestLoaded({
    @required this.profile,
  }) : super(
          loading: false,
          error: null,
        );
}
