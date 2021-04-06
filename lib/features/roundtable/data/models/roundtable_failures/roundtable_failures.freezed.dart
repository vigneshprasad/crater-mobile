// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'roundtable_failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
RoundTableFailure _$RoundTableFailureFromJson(Map<String, dynamic> json) {
  return _RoundTableFailure.fromJson(json);
}

/// @nodoc
class _$RoundTableFailureTearOff {
  const _$RoundTableFailureTearOff();

// ignore: unused_element
  _RoundTableFailure call(
      {@JsonKey(name: 'error_message')
          String message,
      @JsonKey(name: 'error_code', defaultValue: RoundTableFailureType.genericError)
          RoundTableFailureType errorCode}) {
    return _RoundTableFailure(
      message: message,
      errorCode: errorCode,
    );
  }

// ignore: unused_element
  RoundTableFailure fromJson(Map<String, Object> json) {
    return RoundTableFailure.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $RoundTableFailure = _$RoundTableFailureTearOff();

/// @nodoc
mixin _$RoundTableFailure {
  @JsonKey(name: 'error_message')
  String get message;
  @JsonKey(name: 'error_code', defaultValue: RoundTableFailureType.genericError)
  RoundTableFailureType get errorCode;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $RoundTableFailureCopyWith<RoundTableFailure> get copyWith;
}

/// @nodoc
abstract class $RoundTableFailureCopyWith<$Res> {
  factory $RoundTableFailureCopyWith(
          RoundTableFailure value, $Res Function(RoundTableFailure) then) =
      _$RoundTableFailureCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'error_message')
          String message,
      @JsonKey(name: 'error_code', defaultValue: RoundTableFailureType.genericError)
          RoundTableFailureType errorCode});
}

/// @nodoc
class _$RoundTableFailureCopyWithImpl<$Res>
    implements $RoundTableFailureCopyWith<$Res> {
  _$RoundTableFailureCopyWithImpl(this._value, this._then);

  final RoundTableFailure _value;
  // ignore: unused_field
  final $Res Function(RoundTableFailure) _then;

  @override
  $Res call({
    Object message = freezed,
    Object errorCode = freezed,
  }) {
    return _then(_value.copyWith(
      message: message == freezed ? _value.message : message as String,
      errorCode: errorCode == freezed
          ? _value.errorCode
          : errorCode as RoundTableFailureType,
    ));
  }
}

/// @nodoc
abstract class _$RoundTableFailureCopyWith<$Res>
    implements $RoundTableFailureCopyWith<$Res> {
  factory _$RoundTableFailureCopyWith(
          _RoundTableFailure value, $Res Function(_RoundTableFailure) then) =
      __$RoundTableFailureCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'error_message')
          String message,
      @JsonKey(name: 'error_code', defaultValue: RoundTableFailureType.genericError)
          RoundTableFailureType errorCode});
}

/// @nodoc
class __$RoundTableFailureCopyWithImpl<$Res>
    extends _$RoundTableFailureCopyWithImpl<$Res>
    implements _$RoundTableFailureCopyWith<$Res> {
  __$RoundTableFailureCopyWithImpl(
      _RoundTableFailure _value, $Res Function(_RoundTableFailure) _then)
      : super(_value, (v) => _then(v as _RoundTableFailure));

  @override
  _RoundTableFailure get _value => super._value as _RoundTableFailure;

  @override
  $Res call({
    Object message = freezed,
    Object errorCode = freezed,
  }) {
    return _then(_RoundTableFailure(
      message: message == freezed ? _value.message : message as String,
      errorCode: errorCode == freezed
          ? _value.errorCode
          : errorCode as RoundTableFailureType,
    ));
  }
}

@JsonSerializable()
@Implements(Failure)

/// @nodoc
class _$_RoundTableFailure implements _RoundTableFailure {
  _$_RoundTableFailure(
      {@JsonKey(name: 'error_message')
          this.message,
      @JsonKey(name: 'error_code', defaultValue: RoundTableFailureType.genericError)
          this.errorCode});

  factory _$_RoundTableFailure.fromJson(Map<String, dynamic> json) =>
      _$_$_RoundTableFailureFromJson(json);

  @override
  @JsonKey(name: 'error_message')
  final String message;
  @override
  @JsonKey(name: 'error_code', defaultValue: RoundTableFailureType.genericError)
  final RoundTableFailureType errorCode;

  @override
  String toString() {
    return 'RoundTableFailure(message: $message, errorCode: $errorCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RoundTableFailure &&
            (identical(other.message, message) ||
                const DeepCollectionEquality()
                    .equals(other.message, message)) &&
            (identical(other.errorCode, errorCode) ||
                const DeepCollectionEquality()
                    .equals(other.errorCode, errorCode)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(message) ^
      const DeepCollectionEquality().hash(errorCode);

  @JsonKey(ignore: true)
  @override
  _$RoundTableFailureCopyWith<_RoundTableFailure> get copyWith =>
      __$RoundTableFailureCopyWithImpl<_RoundTableFailure>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_RoundTableFailureToJson(this);
  }
}

abstract class _RoundTableFailure implements RoundTableFailure, Failure {
  factory _RoundTableFailure(
      {@JsonKey(name: 'error_message')
          String message,
      @JsonKey(name: 'error_code', defaultValue: RoundTableFailureType.genericError)
          RoundTableFailureType errorCode}) = _$_RoundTableFailure;

  factory _RoundTableFailure.fromJson(Map<String, dynamic> json) =
      _$_RoundTableFailure.fromJson;

  @override
  @JsonKey(name: 'error_message')
  String get message;
  @override
  @JsonKey(name: 'error_code', defaultValue: RoundTableFailureType.genericError)
  RoundTableFailureType get errorCode;
  @override
  @JsonKey(ignore: true)
  _$RoundTableFailureCopyWith<_RoundTableFailure> get copyWith;
}
