import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// General Failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class WebsocketServerFailure extends Failure {
  final dynamic message;
  WebsocketServerFailure([this.message]);
}

class WebsocketLocalFailure extends Failure {}

class WebsocketCloseFailure extends Failure {}

// Auth Failures
class UnknowSocialProvider extends Failure {}
