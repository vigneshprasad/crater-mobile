part of 'profile_basic_bloc.dart';

abstract class ProfileBasicState extends Equatable {
  final bool loading;
  final Failure error;

  const ProfileBasicState({
    this.loading,
    this.error,
  });

  @override
  List<Object> get props => [loading, error];
}

class ProfileBasicInitial extends ProfileBasicState {
  const ProfileBasicInitial()
      : super(
          loading: false,
          error: null,
        );
}

class ProfileBasicRequestLoading extends ProfileBasicState {
  const ProfileBasicRequestLoading()
      : super(
          loading: true,
          error: null,
        );
}

class ProfileBasicRequestError extends ProfileBasicState {
  const ProfileBasicRequestError({
    @required Failure error,
  }) : super(
          loading: false,
          error: error,
        );
}

class ProfileBasicRequestLoaded extends ProfileBasicState {
  const ProfileBasicRequestLoaded()
      : super(
          loading: false,
          error: null,
        );

  @override
  List<Object> get props => [loading, error];
}

class PatchProfileBasicRequestLoaded extends ProfileBasicState {
  final User user;
  final UserProfile profile;

  const PatchProfileBasicRequestLoaded({
    @required this.user,
    @required this.profile,
  }) : super(
          loading: false,
          error: null,
        );

  @override
  List<Object> get props => [loading, error, user, profile];
}
