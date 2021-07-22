part of 'profile_tags_bloc.dart';

abstract class ProfileTagsState extends Equatable {
  final bool loading;
  final Failure? error;

  const ProfileTagsState({
    required this.loading,
    this.error,
  });

  @override
  List<Object> get props => error != null ? [loading, error!] : [loading];
}

class ProfileTagsInitial extends ProfileTagsState {
  const ProfileTagsInitial()
      : super(
          loading: false,
          error: null,
        );
}

class ProfileTagsRequestLoading extends ProfileTagsState {
  const ProfileTagsRequestLoading()
      : super(
          loading: true,
          error: null,
        );
}

class ProfileTagsRequestError extends ProfileTagsState {
  const ProfileTagsRequestError({
    required Failure error,
  }) : super(
          loading: false,
          error: error,
        );
}

class ProfileTagsRequestLoaded extends ProfileTagsState {
  final List<UserTag> tags;

  const ProfileTagsRequestLoaded({
    required this.tags,
  }) : super(
          loading: false,
          error: null,
        );

  @override
  List<Object> get props =>
      error != null ? [loading, error!, tags] : [loading, tags];
}

class PostProfileTagsRequestLoaded extends ProfileTagsState {
  final UserProfile user;

  const PostProfileTagsRequestLoaded({
    required this.user,
  }) : super(
          loading: false,
          error: null,
        );

  @override
  List<Object> get props =>
      error != null ? [loading, error!, user] : [loading, user];
}
