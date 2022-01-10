import 'package:freezed_annotation/freezed_annotation.dart';

import '../error/failures/failures.dart';

part 'api_result.freezed.dart';

@freezed
@sealed
abstract class ApiResult<T> with _$ApiResult<T> {
  factory ApiResult.loading() = _ApiResultLoading<T>;
  factory ApiResult.data(T data) = _ApiResultData<T>;
  factory ApiResult.error(Failure? error, [StackTrace? stackTrace]) =
      _ApiResultError<T>;
}
