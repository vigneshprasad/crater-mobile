part of 'objectives_bloc.dart';

abstract class ObjectivesEvent extends Equatable {
  const ObjectivesEvent();

  @override
  List<Object> get props => [];
}

class GetObjectivesRequestStarted extends ObjectivesEvent {
  const GetObjectivesRequestStarted();
}

class PostObjectivesRequestStarted extends ObjectivesEvent {
  final List<int> objectives;

  const PostObjectivesRequestStarted({
    @required this.objectives,
  });

  @override
  List<Object> get props => [objectives];
}
