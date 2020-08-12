part of 'masterclass_bloc.dart';

abstract class MasterclassState extends Equatable {
  const MasterclassState();
}

class MasterclassInitial extends MasterclassState {
  @override
  List<Object> get props => [];
}

class MasterclassGetLoading extends MasterclassState {
  final bool loading;

  const MasterclassGetLoading({this.loading = true});

  @override
  List<Object> get props => [loading];
}

class MasterclassGetSuccess extends MasterclassState {
  final MasterClassGetResponse response;

  const MasterclassGetSuccess({this.response});

  @override
  List<Object> get props => [response];
}

class MasterclassGetError extends MasterclassState {
  final dynamic error;

  const MasterclassGetError({this.error});

  @override
  List<Object> get props => [error];
}
