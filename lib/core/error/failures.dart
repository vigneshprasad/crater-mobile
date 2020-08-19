import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// General Failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

// Auth Failures
class UnknowSocialProvider extends Failure {}
