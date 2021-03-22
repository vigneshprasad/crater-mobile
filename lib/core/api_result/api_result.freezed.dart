// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'api_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$ApiResultTearOff {
  const _$ApiResultTearOff();

// ignore: unused_element
  _ApiResultLoading<T> loading<T>() {
    return _ApiResultLoading<T>();
  }

// ignore: unused_element
  _ApiResultData<T> data<T>(T data) {
    return _ApiResultData<T>(
      data,
    );
  }

// ignore: unused_element
  _ApiResultError<T> error<T>(Failure error, [StackTrace stackTrace]) {
    return _ApiResultError<T>(
      error,
      stackTrace,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $ApiResult = _$ApiResultTearOff();

/// @nodoc
mixin _$ApiResult<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult loading(),
    @required TResult data(T data),
    @required TResult error(Failure error, StackTrace stackTrace),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult loading(),
    TResult data(T data),
    TResult error(Failure error, StackTrace stackTrace),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult loading(_ApiResultLoading<T> value),
    @required TResult data(_ApiResultData<T> value),
    @required TResult error(_ApiResultError<T> value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult loading(_ApiResultLoading<T> value),
    TResult data(_ApiResultData<T> value),
    TResult error(_ApiResultError<T> value),
    @required TResult orElse(),
  });
}

/// @nodoc
abstract class $ApiResultCopyWith<T, $Res> {
  factory $ApiResultCopyWith(
          ApiResult<T> value, $Res Function(ApiResult<T>) then) =
      _$ApiResultCopyWithImpl<T, $Res>;
}

/// @nodoc
class _$ApiResultCopyWithImpl<T, $Res> implements $ApiResultCopyWith<T, $Res> {
  _$ApiResultCopyWithImpl(this._value, this._then);

  final ApiResult<T> _value;
  // ignore: unused_field
  final $Res Function(ApiResult<T>) _then;
}

/// @nodoc
abstract class _$ApiResultLoadingCopyWith<T, $Res> {
  factory _$ApiResultLoadingCopyWith(_ApiResultLoading<T> value,
          $Res Function(_ApiResultLoading<T>) then) =
      __$ApiResultLoadingCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$ApiResultLoadingCopyWithImpl<T, $Res>
    extends _$ApiResultCopyWithImpl<T, $Res>
    implements _$ApiResultLoadingCopyWith<T, $Res> {
  __$ApiResultLoadingCopyWithImpl(
      _ApiResultLoading<T> _value, $Res Function(_ApiResultLoading<T>) _then)
      : super(_value, (v) => _then(v as _ApiResultLoading<T>));

  @override
  _ApiResultLoading<T> get _value => super._value as _ApiResultLoading<T>;
}

/// @nodoc
class _$_ApiResultLoading<T> implements _ApiResultLoading<T> {
  _$_ApiResultLoading();

  @override
  String toString() {
    return 'ApiResult<$T>.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _ApiResultLoading<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult loading(),
    @required TResult data(T data),
    @required TResult error(Failure error, StackTrace stackTrace),
  }) {
    assert(loading != null);
    assert(data != null);
    assert(error != null);
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult loading(),
    TResult data(T data),
    TResult error(Failure error, StackTrace stackTrace),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult loading(_ApiResultLoading<T> value),
    @required TResult data(_ApiResultData<T> value),
    @required TResult error(_ApiResultError<T> value),
  }) {
    assert(loading != null);
    assert(data != null);
    assert(error != null);
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult loading(_ApiResultLoading<T> value),
    TResult data(_ApiResultData<T> value),
    TResult error(_ApiResultError<T> value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _ApiResultLoading<T> implements ApiResult<T> {
  factory _ApiResultLoading() = _$_ApiResultLoading<T>;
}

/// @nodoc
abstract class _$ApiResultDataCopyWith<T, $Res> {
  factory _$ApiResultDataCopyWith(
          _ApiResultData<T> value, $Res Function(_ApiResultData<T>) then) =
      __$ApiResultDataCopyWithImpl<T, $Res>;
  $Res call({T data});
}

/// @nodoc
class __$ApiResultDataCopyWithImpl<T, $Res>
    extends _$ApiResultCopyWithImpl<T, $Res>
    implements _$ApiResultDataCopyWith<T, $Res> {
  __$ApiResultDataCopyWithImpl(
      _ApiResultData<T> _value, $Res Function(_ApiResultData<T>) _then)
      : super(_value, (v) => _then(v as _ApiResultData<T>));

  @override
  _ApiResultData<T> get _value => super._value as _ApiResultData<T>;

  @override
  $Res call({
    Object data = freezed,
  }) {
    return _then(_ApiResultData<T>(
      data == freezed ? _value.data : data as T,
    ));
  }
}

/// @nodoc
class _$_ApiResultData<T> implements _ApiResultData<T> {
  _$_ApiResultData(this.data) : assert(data != null);

  @override
  final T data;

  @override
  String toString() {
    return 'ApiResult<$T>.data(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ApiResultData<T> &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(data);

  @JsonKey(ignore: true)
  @override
  _$ApiResultDataCopyWith<T, _ApiResultData<T>> get copyWith =>
      __$ApiResultDataCopyWithImpl<T, _ApiResultData<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult loading(),
    @required TResult data(T data),
    @required TResult error(Failure error, StackTrace stackTrace),
  }) {
    assert(loading != null);
    assert(data != null);
    assert(error != null);
    return data(this.data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult loading(),
    TResult data(T data),
    TResult error(Failure error, StackTrace stackTrace),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (data != null) {
      return data(this.data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult loading(_ApiResultLoading<T> value),
    @required TResult data(_ApiResultData<T> value),
    @required TResult error(_ApiResultError<T> value),
  }) {
    assert(loading != null);
    assert(data != null);
    assert(error != null);
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult loading(_ApiResultLoading<T> value),
    TResult data(_ApiResultData<T> value),
    TResult error(_ApiResultError<T> value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _ApiResultData<T> implements ApiResult<T> {
  factory _ApiResultData(T data) = _$_ApiResultData<T>;

  T get data;
  @JsonKey(ignore: true)
  _$ApiResultDataCopyWith<T, _ApiResultData<T>> get copyWith;
}

/// @nodoc
abstract class _$ApiResultErrorCopyWith<T, $Res> {
  factory _$ApiResultErrorCopyWith(
          _ApiResultError<T> value, $Res Function(_ApiResultError<T>) then) =
      __$ApiResultErrorCopyWithImpl<T, $Res>;
  $Res call({Failure error, StackTrace stackTrace});
}

/// @nodoc
class __$ApiResultErrorCopyWithImpl<T, $Res>
    extends _$ApiResultCopyWithImpl<T, $Res>
    implements _$ApiResultErrorCopyWith<T, $Res> {
  __$ApiResultErrorCopyWithImpl(
      _ApiResultError<T> _value, $Res Function(_ApiResultError<T>) _then)
      : super(_value, (v) => _then(v as _ApiResultError<T>));

  @override
  _ApiResultError<T> get _value => super._value as _ApiResultError<T>;

  @override
  $Res call({
    Object error = freezed,
    Object stackTrace = freezed,
  }) {
    return _then(_ApiResultError<T>(
      error == freezed ? _value.error : error as Failure,
      stackTrace == freezed ? _value.stackTrace : stackTrace as StackTrace,
    ));
  }
}

/// @nodoc
class _$_ApiResultError<T> implements _ApiResultError<T> {
  _$_ApiResultError(this.error, [this.stackTrace]) : assert(error != null);

  @override
  final Failure error;
  @override
  final StackTrace stackTrace;

  @override
  String toString() {
    return 'ApiResult<$T>.error(error: $error, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ApiResultError<T> &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)) &&
            (identical(other.stackTrace, stackTrace) ||
                const DeepCollectionEquality()
                    .equals(other.stackTrace, stackTrace)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(error) ^
      const DeepCollectionEquality().hash(stackTrace);

  @JsonKey(ignore: true)
  @override
  _$ApiResultErrorCopyWith<T, _ApiResultError<T>> get copyWith =>
      __$ApiResultErrorCopyWithImpl<T, _ApiResultError<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult loading(),
    @required TResult data(T data),
    @required TResult error(Failure error, StackTrace stackTrace),
  }) {
    assert(loading != null);
    assert(data != null);
    assert(error != null);
    return error(this.error, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult loading(),
    TResult data(T data),
    TResult error(Failure error, StackTrace stackTrace),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(this.error, stackTrace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult loading(_ApiResultLoading<T> value),
    @required TResult data(_ApiResultData<T> value),
    @required TResult error(_ApiResultError<T> value),
  }) {
    assert(loading != null);
    assert(data != null);
    assert(error != null);
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult loading(_ApiResultLoading<T> value),
    TResult data(_ApiResultData<T> value),
    TResult error(_ApiResultError<T> value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _ApiResultError<T> implements ApiResult<T> {
  factory _ApiResultError(Failure error, [StackTrace stackTrace]) =
      _$_ApiResultError<T>;

  Failure get error;
  StackTrace get stackTrace;
  @JsonKey(ignore: true)
  _$ApiResultErrorCopyWith<T, _ApiResultError<T>> get copyWith;
}
