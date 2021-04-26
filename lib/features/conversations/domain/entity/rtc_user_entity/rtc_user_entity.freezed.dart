// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'rtc_user_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$RtcUserTearOff {
  const _$RtcUserTearOff();

// ignore: unused_element
  _RtcUser call(
      {@required ConversationUser userInfo,
      @required String pk,
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
// ignore: unused_element
const $RtcUser = _$RtcUserTearOff();

/// @nodoc
mixin _$RtcUser {
  ConversationUser get userInfo;
  String get pk;
  bool get online;
  bool get muted;
  int get volume;

  @JsonKey(ignore: true)
  $RtcUserCopyWith<RtcUser> get copyWith;
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
    Object userInfo = freezed,
    Object pk = freezed,
    Object online = freezed,
    Object muted = freezed,
    Object volume = freezed,
  }) {
    return _then(_value.copyWith(
      userInfo:
          userInfo == freezed ? _value.userInfo : userInfo as ConversationUser,
      pk: pk == freezed ? _value.pk : pk as String,
      online: online == freezed ? _value.online : online as bool,
      muted: muted == freezed ? _value.muted : muted as bool,
      volume: volume == freezed ? _value.volume : volume as int,
    ));
  }

  @override
  $ConversationUserCopyWith<$Res> get userInfo {
    if (_value.userInfo == null) {
      return null;
    }
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
    Object userInfo = freezed,
    Object pk = freezed,
    Object online = freezed,
    Object muted = freezed,
    Object volume = freezed,
  }) {
    return _then(_RtcUser(
      userInfo:
          userInfo == freezed ? _value.userInfo : userInfo as ConversationUser,
      pk: pk == freezed ? _value.pk : pk as String,
      online: online == freezed ? _value.online : online as bool,
      muted: muted == freezed ? _value.muted : muted as bool,
      volume: volume == freezed ? _value.volume : volume as int,
    ));
  }
}

/// @nodoc
class _$_RtcUser implements _RtcUser {
  _$_RtcUser(
      {@required this.userInfo,
      @required this.pk,
      this.online = false,
      this.muted = false,
      this.volume = 0})
      : assert(userInfo != null),
        assert(pk != null),
        assert(online != null),
        assert(muted != null),
        assert(volume != null);

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
      {@required ConversationUser userInfo,
      @required String pk,
      bool online,
      bool muted,
      int volume}) = _$_RtcUser;

  @override
  ConversationUser get userInfo;
  @override
  String get pk;
  @override
  bool get online;
  @override
  bool get muted;
  @override
  int get volume;
  @override
  @JsonKey(ignore: true)
  _$RtcUserCopyWith<_RtcUser> get copyWith;
}
