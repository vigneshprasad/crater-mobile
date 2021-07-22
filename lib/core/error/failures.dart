import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// General Failures
class ServerFailure extends Failure {
  final Object? message;
  ServerFailure([this.message]);

  @override
  List<Object> get props => [message!];
}

class CacheFailure extends Failure {
  final Object? message;
  CacheFailure([this.message]);

  @override
  List<Object> get props => [message!];
}

class WebsocketServerFailure extends Failure {
  final Object? message;
  WebsocketServerFailure([this.message]);

  @override
  List<Object> get props => [message!];
}

class WebsocketLocalFailure extends Failure {
  final Object? message;
  WebsocketLocalFailure([this.message]);

  @override
  List<Object> get props => [message!];
}

class WebsocketCloseFailure extends Failure {
  final Object? message;
  WebsocketCloseFailure([this.message]);

  @override
  List<Object> get props => [message!];
}

// Auth Failures
class UnknowSocialProvider extends Failure {
  final Object? message;
  UnknowSocialProvider([this.message]);

  @override
  List<Object> get props => [message!];
}
