// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$ServerFailureTearOff {
  const _$ServerFailureTearOff();

// ignore: unused_element
  _ServerFailure call({String message}) {
    return _ServerFailure(
      message: message,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $ServerFailure = _$ServerFailureTearOff();

/// @nodoc
mixin _$ServerFailure {
  String get message;

  @JsonKey(ignore: true)
  $ServerFailureCopyWith<ServerFailure> get copyWith;
}

/// @nodoc
abstract class $ServerFailureCopyWith<$Res> {
  factory $ServerFailureCopyWith(
          ServerFailure value, $Res Function(ServerFailure) then) =
      _$ServerFailureCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class _$ServerFailureCopyWithImpl<$Res>
    implements $ServerFailureCopyWith<$Res> {
  _$ServerFailureCopyWithImpl(this._value, this._then);

  final ServerFailure _value;
  // ignore: unused_field
  final $Res Function(ServerFailure) _then;

  @override
  $Res call({
    Object message = freezed,
  }) {
    return _then(_value.copyWith(
      message: message == freezed ? _value.message : message as String,
    ));
  }
}

/// @nodoc
abstract class _$ServerFailureCopyWith<$Res>
    implements $ServerFailureCopyWith<$Res> {
  factory _$ServerFailureCopyWith(
          _ServerFailure value, $Res Function(_ServerFailure) then) =
      __$ServerFailureCopyWithImpl<$Res>;
  @override
  $Res call({String message});
}

/// @nodoc
class __$ServerFailureCopyWithImpl<$Res>
    extends _$ServerFailureCopyWithImpl<$Res>
    implements _$ServerFailureCopyWith<$Res> {
  __$ServerFailureCopyWithImpl(
      _ServerFailure _value, $Res Function(_ServerFailure) _then)
      : super(_value, (v) => _then(v as _ServerFailure));

  @override
  _ServerFailure get _value => super._value as _ServerFailure;

  @override
  $Res call({
    Object message = freezed,
  }) {
    return _then(_ServerFailure(
      message: message == freezed ? _value.message : message as String,
    ));
  }
}

@Implements(Failure)

/// @nodoc
class _$_ServerFailure implements _ServerFailure {
  _$_ServerFailure({this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'ServerFailure(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ServerFailure &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);

  @JsonKey(ignore: true)
  @override
  _$ServerFailureCopyWith<_ServerFailure> get copyWith =>
      __$ServerFailureCopyWithImpl<_ServerFailure>(this, _$identity);
}

abstract class _ServerFailure implements ServerFailure, Failure {
  factory _ServerFailure({String message}) = _$_ServerFailure;

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$ServerFailureCopyWith<_ServerFailure> get copyWith;
}

/// @nodoc
class _$CacheFailureTearOff {
  const _$CacheFailureTearOff();

// ignore: unused_element
  _CacheFailure call({String message}) {
    return _CacheFailure(
      message: message,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $CacheFailure = _$CacheFailureTearOff();

/// @nodoc
mixin _$CacheFailure {
  String get message;

  @JsonKey(ignore: true)
  $CacheFailureCopyWith<CacheFailure> get copyWith;
}

/// @nodoc
abstract class $CacheFailureCopyWith<$Res> {
  factory $CacheFailureCopyWith(
          CacheFailure value, $Res Function(CacheFailure) then) =
      _$CacheFailureCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class _$CacheFailureCopyWithImpl<$Res> implements $CacheFailureCopyWith<$Res> {
  _$CacheFailureCopyWithImpl(this._value, this._then);

  final CacheFailure _value;
  // ignore: unused_field
  final $Res Function(CacheFailure) _then;

  @override
  $Res call({
    Object message = freezed,
  }) {
    return _then(_value.copyWith(
      message: message == freezed ? _value.message : message as String,
    ));
  }
}

/// @nodoc
abstract class _$CacheFailureCopyWith<$Res>
    implements $CacheFailureCopyWith<$Res> {
  factory _$CacheFailureCopyWith(
          _CacheFailure value, $Res Function(_CacheFailure) then) =
      __$CacheFailureCopyWithImpl<$Res>;
  @override
  $Res call({String message});
}

/// @nodoc
class __$CacheFailureCopyWithImpl<$Res> extends _$CacheFailureCopyWithImpl<$Res>
    implements _$CacheFailureCopyWith<$Res> {
  __$CacheFailureCopyWithImpl(
      _CacheFailure _value, $Res Function(_CacheFailure) _then)
      : super(_value, (v) => _then(v as _CacheFailure));

  @override
  _CacheFailure get _value => super._value as _CacheFailure;

  @override
  $Res call({
    Object message = freezed,
  }) {
    return _then(_CacheFailure(
      message: message == freezed ? _value.message : message as String,
    ));
  }
}

@Implements(Failure)

/// @nodoc
class _$_CacheFailure implements _CacheFailure {
  _$_CacheFailure({this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'CacheFailure(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CacheFailure &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);

  @JsonKey(ignore: true)
  @override
  _$CacheFailureCopyWith<_CacheFailure> get copyWith =>
      __$CacheFailureCopyWithImpl<_CacheFailure>(this, _$identity);
}

abstract class _CacheFailure implements CacheFailure, Failure {
  factory _CacheFailure({String message}) = _$_CacheFailure;

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$CacheFailureCopyWith<_CacheFailure> get copyWith;
}

/// @nodoc
class _$NetworkFailureTearOff {
  const _$NetworkFailureTearOff();

// ignore: unused_element
  _NetworkFailure call({String message = networkFailureString}) {
    return _NetworkFailure(
      message: message,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $NetworkFailure = _$NetworkFailureTearOff();

/// @nodoc
mixin _$NetworkFailure {
  String get message;

  @JsonKey(ignore: true)
  $NetworkFailureCopyWith<NetworkFailure> get copyWith;
}

/// @nodoc
abstract class $NetworkFailureCopyWith<$Res> {
  factory $NetworkFailureCopyWith(
          NetworkFailure value, $Res Function(NetworkFailure) then) =
      _$NetworkFailureCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class _$NetworkFailureCopyWithImpl<$Res>
    implements $NetworkFailureCopyWith<$Res> {
  _$NetworkFailureCopyWithImpl(this._value, this._then);

  final NetworkFailure _value;
  // ignore: unused_field
  final $Res Function(NetworkFailure) _then;

  @override
  $Res call({
    Object message = freezed,
  }) {
    return _then(_value.copyWith(
      message: message == freezed ? _value.message : message as String,
    ));
  }
}

/// @nodoc
abstract class _$NetworkFailureCopyWith<$Res>
    implements $NetworkFailureCopyWith<$Res> {
  factory _$NetworkFailureCopyWith(
          _NetworkFailure value, $Res Function(_NetworkFailure) then) =
      __$NetworkFailureCopyWithImpl<$Res>;
  @override
  $Res call({String message});
}

/// @nodoc
class __$NetworkFailureCopyWithImpl<$Res>
    extends _$NetworkFailureCopyWithImpl<$Res>
    implements _$NetworkFailureCopyWith<$Res> {
  __$NetworkFailureCopyWithImpl(
      _NetworkFailure _value, $Res Function(_NetworkFailure) _then)
      : super(_value, (v) => _then(v as _NetworkFailure));

  @override
  _NetworkFailure get _value => super._value as _NetworkFailure;

  @override
  $Res call({
    Object message = freezed,
  }) {
    return _then(_NetworkFailure(
      message: message == freezed ? _value.message : message as String,
    ));
  }
}

/// @nodoc
class _$_NetworkFailure implements _NetworkFailure {
  _$_NetworkFailure({this.message = networkFailureString})
      : assert(message != null);

  @JsonKey(defaultValue: networkFailureString)
  @override
  final String message;

  @override
  String toString() {
    return 'NetworkFailure(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _NetworkFailure &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);

  @JsonKey(ignore: true)
  @override
  _$NetworkFailureCopyWith<_NetworkFailure> get copyWith =>
      __$NetworkFailureCopyWithImpl<_NetworkFailure>(this, _$identity);
}

abstract class _NetworkFailure implements NetworkFailure {
  factory _NetworkFailure({String message}) = _$_NetworkFailure;

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$NetworkFailureCopyWith<_NetworkFailure> get copyWith;
}
