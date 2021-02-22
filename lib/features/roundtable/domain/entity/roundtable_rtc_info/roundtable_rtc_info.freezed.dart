// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'roundtable_rtc_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
RoundtableRtcInfo _$RoundtableRtcInfoFromJson(Map<String, dynamic> json) {
  return _RoundtableRtcInfo.fromJson(json);
}

/// @nodoc
class _$RoundtableRtcInfoTearOff {
  const _$RoundtableRtcInfoTearOff();

// ignore: unused_element
  _RoundtableRtcInfo call(
      {String token,
      @JsonKey(name: 'channel_name') String channelName,
      @JsonKey(name: 'rtc_uid') String rtcUid}) {
    return _RoundtableRtcInfo(
      token: token,
      channelName: channelName,
      rtcUid: rtcUid,
    );
  }

// ignore: unused_element
  RoundtableRtcInfo fromJson(Map<String, Object> json) {
    return RoundtableRtcInfo.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $RoundtableRtcInfo = _$RoundtableRtcInfoTearOff();

/// @nodoc
mixin _$RoundtableRtcInfo {
  String get token;
  @JsonKey(name: 'channel_name')
  String get channelName;
  @JsonKey(name: 'rtc_uid')
  String get rtcUid;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $RoundtableRtcInfoCopyWith<RoundtableRtcInfo> get copyWith;
}

/// @nodoc
abstract class $RoundtableRtcInfoCopyWith<$Res> {
  factory $RoundtableRtcInfoCopyWith(
          RoundtableRtcInfo value, $Res Function(RoundtableRtcInfo) then) =
      _$RoundtableRtcInfoCopyWithImpl<$Res>;
  $Res call(
      {String token,
      @JsonKey(name: 'channel_name') String channelName,
      @JsonKey(name: 'rtc_uid') String rtcUid});
}

/// @nodoc
class _$RoundtableRtcInfoCopyWithImpl<$Res>
    implements $RoundtableRtcInfoCopyWith<$Res> {
  _$RoundtableRtcInfoCopyWithImpl(this._value, this._then);

  final RoundtableRtcInfo _value;
  // ignore: unused_field
  final $Res Function(RoundtableRtcInfo) _then;

  @override
  $Res call({
    Object token = freezed,
    Object channelName = freezed,
    Object rtcUid = freezed,
  }) {
    return _then(_value.copyWith(
      token: token == freezed ? _value.token : token as String,
      channelName:
          channelName == freezed ? _value.channelName : channelName as String,
      rtcUid: rtcUid == freezed ? _value.rtcUid : rtcUid as String,
    ));
  }
}

/// @nodoc
abstract class _$RoundtableRtcInfoCopyWith<$Res>
    implements $RoundtableRtcInfoCopyWith<$Res> {
  factory _$RoundtableRtcInfoCopyWith(
          _RoundtableRtcInfo value, $Res Function(_RoundtableRtcInfo) then) =
      __$RoundtableRtcInfoCopyWithImpl<$Res>;
  @override
  $Res call(
      {String token,
      @JsonKey(name: 'channel_name') String channelName,
      @JsonKey(name: 'rtc_uid') String rtcUid});
}

/// @nodoc
class __$RoundtableRtcInfoCopyWithImpl<$Res>
    extends _$RoundtableRtcInfoCopyWithImpl<$Res>
    implements _$RoundtableRtcInfoCopyWith<$Res> {
  __$RoundtableRtcInfoCopyWithImpl(
      _RoundtableRtcInfo _value, $Res Function(_RoundtableRtcInfo) _then)
      : super(_value, (v) => _then(v as _RoundtableRtcInfo));

  @override
  _RoundtableRtcInfo get _value => super._value as _RoundtableRtcInfo;

  @override
  $Res call({
    Object token = freezed,
    Object channelName = freezed,
    Object rtcUid = freezed,
  }) {
    return _then(_RoundtableRtcInfo(
      token: token == freezed ? _value.token : token as String,
      channelName:
          channelName == freezed ? _value.channelName : channelName as String,
      rtcUid: rtcUid == freezed ? _value.rtcUid : rtcUid as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_RoundtableRtcInfo implements _RoundtableRtcInfo {
  _$_RoundtableRtcInfo(
      {this.token,
      @JsonKey(name: 'channel_name') this.channelName,
      @JsonKey(name: 'rtc_uid') this.rtcUid});

  factory _$_RoundtableRtcInfo.fromJson(Map<String, dynamic> json) =>
      _$_$_RoundtableRtcInfoFromJson(json);

  @override
  final String token;
  @override
  @JsonKey(name: 'channel_name')
  final String channelName;
  @override
  @JsonKey(name: 'rtc_uid')
  final String rtcUid;

  @override
  String toString() {
    return 'RoundtableRtcInfo(token: $token, channelName: $channelName, rtcUid: $rtcUid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RoundtableRtcInfo &&
            (identical(other.token, token) ||
                const DeepCollectionEquality().equals(other.token, token)) &&
            (identical(other.channelName, channelName) ||
                const DeepCollectionEquality()
                    .equals(other.channelName, channelName)) &&
            (identical(other.rtcUid, rtcUid) ||
                const DeepCollectionEquality().equals(other.rtcUid, rtcUid)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(token) ^
      const DeepCollectionEquality().hash(channelName) ^
      const DeepCollectionEquality().hash(rtcUid);

  @JsonKey(ignore: true)
  @override
  _$RoundtableRtcInfoCopyWith<_RoundtableRtcInfo> get copyWith =>
      __$RoundtableRtcInfoCopyWithImpl<_RoundtableRtcInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_RoundtableRtcInfoToJson(this);
  }
}

abstract class _RoundtableRtcInfo implements RoundtableRtcInfo {
  factory _RoundtableRtcInfo(
      {String token,
      @JsonKey(name: 'channel_name') String channelName,
      @JsonKey(name: 'rtc_uid') String rtcUid}) = _$_RoundtableRtcInfo;

  factory _RoundtableRtcInfo.fromJson(Map<String, dynamic> json) =
      _$_RoundtableRtcInfo.fromJson;

  @override
  String get token;
  @override
  @JsonKey(name: 'channel_name')
  String get channelName;
  @override
  @JsonKey(name: 'rtc_uid')
  String get rtcUid;
  @override
  @JsonKey(ignore: true)
  _$RoundtableRtcInfoCopyWith<_RoundtableRtcInfo> get copyWith;
}
