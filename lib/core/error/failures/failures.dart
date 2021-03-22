import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

const networkFailureString =
    "Unable to Connect. Please check your network connection.";

abstract class Failure {
  String get message;
}

@freezed
abstract class ServerFailure extends Failure with _$ServerFailure {
  @Implements(Failure)
  factory ServerFailure({String message}) = _ServerFailure;
}

@freezed
abstract class CacheFailure extends Failure with _$CacheFailure {
  @Implements(Failure)
  factory CacheFailure({String message}) = _CacheFailure;
}

@freezed
abstract class NetworkFailure extends Failure with _$NetworkFailure {
  factory NetworkFailure({@Default(networkFailureString) String message}) =
      _NetworkFailure;
}
