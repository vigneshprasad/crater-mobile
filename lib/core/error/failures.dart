import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// General Failures
class ServerFailure extends Failure {
  final dynamic message;
  ServerFailure([this.message]);

  @override
  List<Object> get props => [message];
}

class CacheFailure extends Failure {
  final dynamic message;
  CacheFailure([this.message]);

  @override
  List<Object> get props => [message];
}

class WebsocketServerFailure extends Failure {
  final dynamic message;
  WebsocketServerFailure([this.message]);

  @override
  List<Object> get props => [message];
}

class WebsocketLocalFailure extends Failure {
  final dynamic message;
  WebsocketLocalFailure([this.message]);

  @override
  List<Object> get props => [message];
}

class WebsocketCloseFailure extends Failure {
  final dynamic message;
  WebsocketCloseFailure([this.message]);

  @override
  List<Object> get props => [message];
}

// Auth Failures
class UnknowSocialProvider extends Failure {
  final dynamic message;
  UnknowSocialProvider([this.message]);

  @override
  List<Object> get props => [message];
}
