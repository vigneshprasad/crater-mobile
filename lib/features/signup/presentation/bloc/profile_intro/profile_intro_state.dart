part of 'profile_intro_bloc.dart';

abstract class ProfileIntroState extends Equatable {
  final bool loading;
  final Failure? error;

  const ProfileIntroState({
    required this.loading,
    this.error,
  });

  @override
  List<Object> get props => error != null ? [loading, error!] : [loading];
}

class ProfileIntroInitial extends ProfileIntroState {
  const ProfileIntroInitial()
      : super(
          loading: false,
          error: null,
        );
}

class ProfileIntroRequestLoading extends ProfileIntroState {
  const ProfileIntroRequestLoading()
      : super(
          loading: true,
          error: null,
        );
}

class ProfileIntroRequestError extends ProfileIntroState {
  const ProfileIntroRequestError({
    required Failure error,
  }) : super(
          loading: false,
          error: error,
        );
}

class ProfileIntroRequestLoaded extends ProfileIntroState {
  final List<ProfileIntroQuestion> questions;

  const ProfileIntroRequestLoaded({
    required this.questions,
  }) : super(
          loading: false,
          error: null,
        );

  @override
  List<Object> get props =>
      error != null ? [loading, error!, questions] : [loading, questions];
}

class PatchProfileIntroRequestLoaded extends ProfileIntroState {
  final UserProfile profile;

  const PatchProfileIntroRequestLoaded({
    required this.profile,
  }) : super(
          loading: false,
          error: null,
        );

  @override
  List<Object> get props =>
      error != null ? [loading, error!, profile] : [loading, profile];
}
