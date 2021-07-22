// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'rtc_user_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$RtcUserTearOff {
  const _$RtcUserTearOff();

  _RtcUser call(
      {required ConversationUser userInfo,
      required String pk,
      bool online = false,
      bool muted = false,
      int volume = 0}) {
    return _RtcUser(
      userInfo: userInfo,
      pk: pk,
      online: online,
      muted: muted,
      volume: volume,
    );
  }
}

/// @nodoc
const $RtcUser = _$RtcUserTearOff();

/// @nodoc
mixin _$RtcUser {
  ConversationUser get userInfo => throw _privateConstructorUsedError;
  String get pk => throw _privateConstructorUsedError;
  bool get online => throw _privateConstructorUsedError;
  bool get muted => throw _privateConstructorUsedError;
  int get volume => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RtcUserCopyWith<RtcUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RtcUserCopyWith<$Res> {
  factory $RtcUserCopyWith(RtcUser value, $Res Function(RtcUser) then) =
      _$RtcUserCopyWithImpl<$Res>;
  $Res call(
      {ConversationUser userInfo,
      String pk,
      bool online,
      bool muted,
      int volume});

  $ConversationUserCopyWith<$Res> get userInfo;
}

/// @nodoc
class _$RtcUserCopyWithImpl<$Res> implements $RtcUserCopyWith<$Res> {
  _$RtcUserCopyWithImpl(this._value, this._then);

  final RtcUser _value;
  // ignore: unused_field
  final $Res Function(RtcUser) _then;

  @override
  $Res call({
    Object? userInfo = freezed,
    Object? pk = freezed,
    Object? online = freezed,
    Object? muted = freezed,
    Object? volume = freezed,
  }) {
    return _then(_value.copyWith(
      userInfo: userInfo == freezed
          ? _value.userInfo
          : userInfo // ignore: cast_nullable_to_non_nullable
              as ConversationUser,
      pk: pk == freezed
          ? _value.pk
          : pk // ignore: cast_nullable_to_non_nullable
              as String,
      online: online == freezed
          ? _value.online
          : online // ignore: cast_nullable_to_non_nullable
              as bool,
      muted: muted == freezed
          ? _value.muted
          : muted // ignore: cast_nullable_to_non_nullable
              as bool,
      volume: volume == freezed
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  @override
  $ConversationUserCopyWith<$Res> get userInfo {
    return $ConversationUserCopyWith<$Res>(_value.userInfo, (value) {
      return _then(_value.copyWith(userInfo: value));
    });
  }
}

/// @nodoc
abstract class _$RtcUserCopyWith<$Res> implements $RtcUserCopyWith<$Res> {
  factory _$RtcUserCopyWith(_RtcUser value, $Res Function(_RtcUser) then) =
      __$RtcUserCopyWithImpl<$Res>;
  @override
  $Res call(
      {ConversationUser userInfo,
      String pk,
      bool online,
      bool muted,
      int volume});

  @override
  $ConversationUserCopyWith<$Res> get userInfo;
}

/// @nodoc
class __$RtcUserCopyWithImpl<$Res> extends _$RtcUserCopyWithImpl<$Res>
    implements _$RtcUserCopyWith<$Res> {
  __$RtcUserCopyWithImpl(_RtcUser _value, $Res Function(_RtcUser) _then)
      : super(_value, (v) => _then(v as _RtcUser));

  @override
  _RtcUser get _value => super._value as _RtcUser;

  @override
  $Res call({
    Object? userInfo = freezed,
    Object? pk = freezed,
    Object? online = freezed,
    Object? muted = freezed,
    Object? volume = freezed,
  }) {
    return _then(_RtcUser(
      userInfo: userInfo == freezed
          ? _value.userInfo
          : userInfo // ignore: cast_nullable_to_non_nullable
              as ConversationUser,
      pk: pk == freezed
          ? _value.pk
          : pk // ignore: cast_nullable_to_non_nullable
              as String,
      online: online == freezed
          ? _value.online
          : online // ignore: cast_nullable_to_non_nullable
              as bool,
      muted: muted == freezed
          ? _value.muted
          : muted // ignore: cast_nullable_to_non_nullable
              as bool,
      volume: volume == freezed
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_RtcUser implements _RtcUser {
  _$_RtcUser(
      {required this.userInfo,
      required this.pk,
      this.online = false,
      this.muted = false,
      this.volume = 0});

  @override
  final ConversationUser userInfo;
  @override
  final String pk;
  @JsonKey(defaultValue: false)
  @override
  final bool online;
  @JsonKey(defaultValue: false)
  @override
  final bool muted;
  @JsonKey(defaultValue: 0)
  @override
  final int volume;

  @override
  String toString() {
    return 'RtcUser(userInfo: $userInfo, pk: $pk, online: $online, muted: $muted, volume: $volume)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RtcUser &&
            (identical(other.userInfo, userInfo) ||
                const DeepCollectionEquality()
                    .equals(other.userInfo, userInfo)) &&
            (identical(other.pk, pk) ||
                const DeepCollectionEquality().equals(other.pk, pk)) &&
            (identical(other.online, online) ||
                const DeepCollectionEquality().equals(other.online, online)) &&
            (identical(other.muted, muted) ||
                const DeepCollectionEquality().equals(other.muted, muted)) &&
            (identical(other.volume, volume) ||
                const DeepCollectionEquality().equals(other.volume, volume)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(userInfo) ^
      const DeepCollectionEquality().hash(pk) ^
      const DeepCollectionEquality().hash(online) ^
      const DeepCollectionEquality().hash(muted) ^
      const DeepCollectionEquality().hash(volume);

  @JsonKey(ignore: true)
  @override
  _$RtcUserCopyWith<_RtcUser> get copyWith =>
      __$RtcUserCopyWithImpl<_RtcUser>(this, _$identity);
}

abstract class _RtcUser implements RtcUser {
  factory _RtcUser(
      {required ConversationUser userInfo,
      required String pk,
      bool online,
      bool muted,
      int volume}) = _$_RtcUser;

  @override
  ConversationUser get userInfo => throw _privateConstructorUsedError;
  @override
  String get pk => throw _privateConstructorUsedError;
  @override
  bool get online => throw _privateConstructorUsedError;
  @override
  bool get muted => throw _privateConstructorUsedError;
  @override
  int get volume => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$RtcUserCopyWith<_RtcUser> get copyWith =>
      throw _privateConstructorUsedError;
}
