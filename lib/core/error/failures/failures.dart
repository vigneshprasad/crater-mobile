import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

const networkFailureString =
    "Unable to Connect. Please check your network connection.";

abstract class Failure {
  Object? get message;
}

@freezed
abstract class ServerFailure extends Failure with _$ServerFailure {
  factory ServerFailure(Object? message) = _ServerFailure;
}

@freezed
abstract class CacheFailure extends Failure with _$CacheFailure {
  factory CacheFailure({Object? message}) = _CacheFailure;
}

@freezed
abstract class NetworkFailure extends Failure with _$NetworkFailure {
  factory NetworkFailure({@Default(networkFailureString) String? message}) =
      _NetworkFailure;
}
