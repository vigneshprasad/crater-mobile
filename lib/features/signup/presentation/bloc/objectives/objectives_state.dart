part of 'objectives_bloc.dart';

abstract class ObjectivesState extends Equatable {
  final bool loading;
  final Failure? error;

  const ObjectivesState({
    required this.loading,
    this.error,
  });

  @override
  List<Object> get props => error != null ? [loading, error!] : [loading];
}

class ObjectivesInitial extends ObjectivesState {
  const ObjectivesInitial()
      : super(
          loading: false,
          error: null,
        );
}

class ObjectivesRequestLoading extends ObjectivesState {
  const ObjectivesRequestLoading()
      : super(
          loading: true,
          error: null,
        );
}

class ObjectivesRequestError extends ObjectivesState {
  const ObjectivesRequestError({
    required Failure error,
  }) : super(
          loading: false,
          error: error,
        );
}

class ObjectivesRequestLoaded extends ObjectivesState {
  final List<UserObjective> objectives;

  const ObjectivesRequestLoaded({
    required this.objectives,
  }) : super(
          loading: false,
          error: null,
        );

  @override
  List<Object> get props =>
      error != null ? [loading, error!, objectives] : [loading, objectives];
}

class PatchObjectivesRequestLoaded extends ObjectivesState {
  final User user;

  const PatchObjectivesRequestLoaded({
    required this.user,
  }) : super(
          loading: false,
          error: null,
        );

  @override
  List<Object> get props =>
      error != null ? [loading, error!, user] : [loading, user];
}
