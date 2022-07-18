// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'conversation_failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ConversationFailure _$ConversationFailureFromJson(Map<String, dynamic> json) {
  return _ConversationFailure.fromJson(json);
}

/// @nodoc
mixin _$ConversationFailure {
  @JsonKey(name: "error_message")
  String? get message => throw _privateConstructorUsedError;
  @JsonKey(name: "error_code")
  ConversationFailuresType get errorCode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConversationFailureCopyWith<ConversationFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationFailureCopyWith<$Res> {
  factory $ConversationFailureCopyWith(
          ConversationFailure value, $Res Function(ConversationFailure) then) =
      _$ConversationFailureCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: "error_message") String? message,
      @JsonKey(name: "error_code") ConversationFailuresType errorCode});
}

/// @nodoc
class _$ConversationFailureCopyWithImpl<$Res>
    implements $ConversationFailureCopyWith<$Res> {
  _$ConversationFailureCopyWithImpl(this._value, this._then);

  final ConversationFailure _value;
  // ignore: unused_field
  final $Res Function(ConversationFailure) _then;

  @override
  $Res call({
    Object? message = freezed,
    Object? errorCode = freezed,
  }) {
    return _then(_value.copyWith(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      errorCode: errorCode == freezed
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as ConversationFailuresType,
    ));
  }
}

/// @nodoc
abstract class _$$_ConversationFailureCopyWith<$Res>
    implements $ConversationFailureCopyWith<$Res> {
  factory _$$_ConversationFailureCopyWith(_$_ConversationFailure value,
          $Res Function(_$_ConversationFailure) then) =
      __$$_ConversationFailureCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: "error_message") String? message,
      @JsonKey(name: "error_code") ConversationFailuresType errorCode});
}

/// @nodoc
class __$$_ConversationFailureCopyWithImpl<$Res>
    extends _$ConversationFailureCopyWithImpl<$Res>
    implements _$$_ConversationFailureCopyWith<$Res> {
  __$$_ConversationFailureCopyWithImpl(_$_ConversationFailure _value,
      $Res Function(_$_ConversationFailure) _then)
      : super(_value, (v) => _then(v as _$_ConversationFailure));

  @override
  _$_ConversationFailure get _value => super._value as _$_ConversationFailure;

  @override
  $Res call({
    Object? message = freezed,
    Object? errorCode = freezed,
  }) {
    return _then(_$_ConversationFailure(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      errorCode: errorCode == freezed
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as ConversationFailuresType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ConversationFailure implements _ConversationFailure {
  _$_ConversationFailure(
      {@JsonKey(name: "error_message")
          this.message,
      @JsonKey(name: "error_code")
          this.errorCode = ConversationFailuresType.genericError});

  factory _$_ConversationFailure.fromJson(Map<String, dynamic> json) =>
      _$$_ConversationFailureFromJson(json);

  @override
  @JsonKey(name: "error_message")
  final String? message;
  @override
  @JsonKey(name: "error_code")
  final ConversationFailuresType errorCode;

  @override
  String toString() {
    return 'ConversationFailure(message: $message, errorCode: $errorCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ConversationFailure &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.errorCode, errorCode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(errorCode));

  @JsonKey(ignore: true)
  @override
  _$$_ConversationFailureCopyWith<_$_ConversationFailure> get copyWith =>
      __$$_ConversationFailureCopyWithImpl<_$_ConversationFailure>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ConversationFailureToJson(this);
  }
}

abstract class _ConversationFailure implements ConversationFailure {
  factory _ConversationFailure(
      {@JsonKey(name: "error_message")
          final String? message,
      @JsonKey(name: "error_code")
          final ConversationFailuresType errorCode}) = _$_ConversationFailure;

  factory _ConversationFailure.fromJson(Map<String, dynamic> json) =
      _$_ConversationFailure.fromJson;

  @override
  @JsonKey(name: "error_message")
  String? get message;
  @override
  @JsonKey(name: "error_code")
  ConversationFailuresType get errorCode;
  @override
  @JsonKey(ignore: true)
  _$$_ConversationFailureCopyWith<_$_ConversationFailure> get copyWith =>
      throw _privateConstructorUsedError;
}
