// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'agora_rtc_user_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
AgoraRtcUserInfo _$AgoraRtcUserInfoFromJson(Map<String, dynamic> json) {
  return _AgoraRtcUserInfo.fromJson(json);
}

/// @nodoc
class _$AgoraRtcUserInfoTearOff {
  const _$AgoraRtcUserInfoTearOff();

// ignore: unused_element
  _AgoraRtcUserInfo call(
      {String uid, @JsonKey(name: 'user_pk') String userPk}) {
    return _AgoraRtcUserInfo(
      uid: uid,
      userPk: userPk,
    );
  }

// ignore: unused_element
  AgoraRtcUserInfo fromJson(Map<String, Object> json) {
    return AgoraRtcUserInfo.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $AgoraRtcUserInfo = _$AgoraRtcUserInfoTearOff();

/// @nodoc
mixin _$AgoraRtcUserInfo {
  String get uid;
  @JsonKey(name: 'user_pk')
  String get userPk;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $AgoraRtcUserInfoCopyWith<AgoraRtcUserInfo> get copyWith;
}

/// @nodoc
abstract class $AgoraRtcUserInfoCopyWith<$Res> {
  factory $AgoraRtcUserInfoCopyWith(
          AgoraRtcUserInfo value, $Res Function(AgoraRtcUserInfo) then) =
      _$AgoraRtcUserInfoCopyWithImpl<$Res>;
  $Res call({String uid, @JsonKey(name: 'user_pk') String userPk});
}

/// @nodoc
class _$AgoraRtcUserInfoCopyWithImpl<$Res>
    implements $AgoraRtcUserInfoCopyWith<$Res> {
  _$AgoraRtcUserInfoCopyWithImpl(this._value, this._then);

  final AgoraRtcUserInfo _value;
  // ignore: unused_field
  final $Res Function(AgoraRtcUserInfo) _then;

  @override
  $Res call({
    Object uid = freezed,
    Object userPk = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed ? _value.uid : uid as String,
      userPk: userPk == freezed ? _value.userPk : userPk as String,
    ));
  }
}

/// @nodoc
abstract class _$AgoraRtcUserInfoCopyWith<$Res>
    implements $AgoraRtcUserInfoCopyWith<$Res> {
  factory _$AgoraRtcUserInfoCopyWith(
          _AgoraRtcUserInfo value, $Res Function(_AgoraRtcUserInfo) then) =
      __$AgoraRtcUserInfoCopyWithImpl<$Res>;
  @override
  $Res call({String uid, @JsonKey(name: 'user_pk') String userPk});
}

/// @nodoc
class __$AgoraRtcUserInfoCopyWithImpl<$Res>
    extends _$AgoraRtcUserInfoCopyWithImpl<$Res>
    implements _$AgoraRtcUserInfoCopyWith<$Res> {
  __$AgoraRtcUserInfoCopyWithImpl(
      _AgoraRtcUserInfo _value, $Res Function(_AgoraRtcUserInfo) _then)
      : super(_value, (v) => _then(v as _AgoraRtcUserInfo));

  @override
  _AgoraRtcUserInfo get _value => super._value as _AgoraRtcUserInfo;

  @override
  $Res call({
    Object uid = freezed,
    Object userPk = freezed,
  }) {
    return _then(_AgoraRtcUserInfo(
      uid: uid == freezed ? _value.uid : uid as String,
      userPk: userPk == freezed ? _value.userPk : userPk as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_AgoraRtcUserInfo implements _AgoraRtcUserInfo {
  _$_AgoraRtcUserInfo({this.uid, @JsonKey(name: 'user_pk') this.userPk});

  factory _$_AgoraRtcUserInfo.fromJson(Map<String, dynamic> json) =>
      _$_$_AgoraRtcUserInfoFromJson(json);

  @override
  final String uid;
  @override
  @JsonKey(name: 'user_pk')
  final String userPk;

  @override
  String toString() {
    return 'AgoraRtcUserInfo(uid: $uid, userPk: $userPk)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AgoraRtcUserInfo &&
            (identical(other.uid, uid) ||
                const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.userPk, userPk) ||
                const DeepCollectionEquality().equals(other.userPk, userPk)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(uid) ^
      const DeepCollectionEquality().hash(userPk);

  @JsonKey(ignore: true)
  @override
  _$AgoraRtcUserInfoCopyWith<_AgoraRtcUserInfo> get copyWith =>
      __$AgoraRtcUserInfoCopyWithImpl<_AgoraRtcUserInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_AgoraRtcUserInfoToJson(this);
  }
}

abstract class _AgoraRtcUserInfo implements AgoraRtcUserInfo {
  factory _AgoraRtcUserInfo(
      {String uid,
      @JsonKey(name: 'user_pk') String userPk}) = _$_AgoraRtcUserInfo;

  factory _AgoraRtcUserInfo.fromJson(Map<String, dynamic> json) =
      _$_AgoraRtcUserInfo.fromJson;

  @override
  String get uid;
  @override
  @JsonKey(name: 'user_pk')
  String get userPk;
  @override
  @JsonKey(ignore: true)
  _$AgoraRtcUserInfoCopyWith<_AgoraRtcUserInfo> get copyWith;
}
