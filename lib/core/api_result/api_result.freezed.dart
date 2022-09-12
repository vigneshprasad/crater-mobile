// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'api_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ApiResult<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(T data) data,
    required TResult Function(Failure? error, StackTrace? stackTrace) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(T data)? data,
    TResult Function(Failure? error, StackTrace? stackTrace)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(T data)? data,
    TResult Function(Failure? error, StackTrace? stackTrace)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ApiResultLoading<T> value) loading,
    required TResult Function(_ApiResultData<T> value) data,
    required TResult Function(_ApiResultError<T> value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ApiResultLoading<T> value)? loading,
    TResult Function(_ApiResultData<T> value)? data,
    TResult Function(_ApiResultError<T> value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ApiResultLoading<T> value)? loading,
    TResult Function(_ApiResultData<T> value)? data,
    TResult Function(_ApiResultError<T> value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
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
abstract class _$$_ApiResultLoadingCopyWith<T, $Res> {
  factory _$$_ApiResultLoadingCopyWith(_$_ApiResultLoading<T> value,
          $Res Function(_$_ApiResultLoading<T>) then) =
      __$$_ApiResultLoadingCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$_ApiResultLoadingCopyWithImpl<T, $Res>
    extends _$ApiResultCopyWithImpl<T, $Res>
    implements _$$_ApiResultLoadingCopyWith<T, $Res> {
  __$$_ApiResultLoadingCopyWithImpl(_$_ApiResultLoading<T> _value,
      $Res Function(_$_ApiResultLoading<T>) _then)
      : super(_value, (v) => _then(v as _$_ApiResultLoading<T>));

  @override
  _$_ApiResultLoading<T> get _value => super._value as _$_ApiResultLoading<T>;
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
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_ApiResultLoading<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(T data) data,
    required TResult Function(Failure? error, StackTrace? stackTrace) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(T data)? data,
    TResult Function(Failure? error, StackTrace? stackTrace)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(T data)? data,
    TResult Function(Failure? error, StackTrace? stackTrace)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ApiResultLoading<T> value) loading,
    required TResult Function(_ApiResultData<T> value) data,
    required TResult Function(_ApiResultError<T> value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ApiResultLoading<T> value)? loading,
    TResult Function(_ApiResultData<T> value)? data,
    TResult Function(_ApiResultError<T> value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ApiResultLoading<T> value)? loading,
    TResult Function(_ApiResultData<T> value)? data,
    TResult Function(_ApiResultError<T> value)? error,
    required TResult orElse(),
  }) {
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
abstract class _$$_ApiResultDataCopyWith<T, $Res> {
  factory _$$_ApiResultDataCopyWith(
          _$_ApiResultData<T> value, $Res Function(_$_ApiResultData<T>) then) =
      __$$_ApiResultDataCopyWithImpl<T, $Res>;
  $Res call({T data});
}

/// @nodoc
class __$$_ApiResultDataCopyWithImpl<T, $Res>
    extends _$ApiResultCopyWithImpl<T, $Res>
    implements _$$_ApiResultDataCopyWith<T, $Res> {
  __$$_ApiResultDataCopyWithImpl(
      _$_ApiResultData<T> _value, $Res Function(_$_ApiResultData<T>) _then)
      : super(_value, (v) => _then(v as _$_ApiResultData<T>));

  @override
  _$_ApiResultData<T> get _value => super._value as _$_ApiResultData<T>;

  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$_ApiResultData<T>(
      data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$_ApiResultData<T> implements _ApiResultData<T> {
  _$_ApiResultData(this.data);

  @override
  final T data;

  @override
  String toString() {
    return 'ApiResult<$T>.data(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ApiResultData<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  _$$_ApiResultDataCopyWith<T, _$_ApiResultData<T>> get copyWith =>
      __$$_ApiResultDataCopyWithImpl<T, _$_ApiResultData<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(T data) data,
    required TResult Function(Failure? error, StackTrace? stackTrace) error,
  }) {
    return data(this.data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(T data)? data,
    TResult Function(Failure? error, StackTrace? stackTrace)? error,
  }) {
    return data?.call(this.data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(T data)? data,
    TResult Function(Failure? error, StackTrace? stackTrace)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this.data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ApiResultLoading<T> value) loading,
    required TResult Function(_ApiResultData<T> value) data,
    required TResult Function(_ApiResultError<T> value) error,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ApiResultLoading<T> value)? loading,
    TResult Function(_ApiResultData<T> value)? data,
    TResult Function(_ApiResultError<T> value)? error,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ApiResultLoading<T> value)? loading,
    TResult Function(_ApiResultData<T> value)? data,
    TResult Function(_ApiResultError<T> value)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _ApiResultData<T> implements ApiResult<T> {
  factory _ApiResultData(final T data) = _$_ApiResultData<T>;

  T get data;
  @JsonKey(ignore: true)
  _$$_ApiResultDataCopyWith<T, _$_ApiResultData<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ApiResultErrorCopyWith<T, $Res> {
  factory _$$_ApiResultErrorCopyWith(_$_ApiResultError<T> value,
          $Res Function(_$_ApiResultError<T>) then) =
      __$$_ApiResultErrorCopyWithImpl<T, $Res>;
  $Res call({Failure? error, StackTrace? stackTrace});
}

/// @nodoc
class __$$_ApiResultErrorCopyWithImpl<T, $Res>
    extends _$ApiResultCopyWithImpl<T, $Res>
    implements _$$_ApiResultErrorCopyWith<T, $Res> {
  __$$_ApiResultErrorCopyWithImpl(
      _$_ApiResultError<T> _value, $Res Function(_$_ApiResultError<T>) _then)
      : super(_value, (v) => _then(v as _$_ApiResultError<T>));

  @override
  _$_ApiResultError<T> get _value => super._value as _$_ApiResultError<T>;

  @override
  $Res call({
    Object? error = freezed,
    Object? stackTrace = freezed,
  }) {
    return _then(_$_ApiResultError<T>(
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Failure?,
      stackTrace == freezed
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ));
  }
}

/// @nodoc

class _$_ApiResultError<T> implements _ApiResultError<T> {
  _$_ApiResultError(this.error, [this.stackTrace]);

  @override
  final Failure? error;
  @override
  final StackTrace? stackTrace;

  @override
  String toString() {
    return 'ApiResult<$T>.error(error: $error, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ApiResultError<T> &&
            const DeepCollectionEquality().equals(other.error, error) &&
            const DeepCollectionEquality()
                .equals(other.stackTrace, stackTrace));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(error),
      const DeepCollectionEquality().hash(stackTrace));

  @JsonKey(ignore: true)
  @override
  _$$_ApiResultErrorCopyWith<T, _$_ApiResultError<T>> get copyWith =>
      __$$_ApiResultErrorCopyWithImpl<T, _$_ApiResultError<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(T data) data,
    required TResult Function(Failure? error, StackTrace? stackTrace) error,
  }) {
    return error(this.error, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(T data)? data,
    TResult Function(Failure? error, StackTrace? stackTrace)? error,
  }) {
    return error?.call(this.error, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(T data)? data,
    TResult Function(Failure? error, StackTrace? stackTrace)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error, stackTrace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ApiResultLoading<T> value) loading,
    required TResult Function(_ApiResultData<T> value) data,
    required TResult Function(_ApiResultError<T> value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ApiResultLoading<T> value)? loading,
    TResult Function(_ApiResultData<T> value)? data,
    TResult Function(_ApiResultError<T> value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ApiResultLoading<T> value)? loading,
    TResult Function(_ApiResultData<T> value)? data,
    TResult Function(_ApiResultError<T> value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _ApiResultError<T> implements ApiResult<T> {
  factory _ApiResultError(final Failure? error,
      [final StackTrace? stackTrace]) = _$_ApiResultError<T>;

  Failure? get error;
  StackTrace? get stackTrace;
  @JsonKey(ignore: true)
  _$$_ApiResultErrorCopyWith<T, _$_ApiResultError<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
