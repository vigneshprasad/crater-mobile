// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'conversation_rtc_info_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ConversationRtcInfo _$ConversationRtcInfoFromJson(Map<String, dynamic> json) {
  return _ConversationRtcInfo.fromJson(json);
}

/// @nodoc
class _$ConversationRtcInfoTearOff {
  const _$ConversationRtcInfoTearOff();

  _ConversationRtcInfo call(
      {String? token,
      @JsonKey(name: "channel_name") String? channelName,
      @JsonKey(name: "rtc_uid") String? rtcUid}) {
    return _ConversationRtcInfo(
      token: token,
      channelName: channelName,
      rtcUid: rtcUid,
    );
  }

  ConversationRtcInfo fromJson(Map<String, Object> json) {
    return ConversationRtcInfo.fromJson(json);
  }
}

/// @nodoc
const $ConversationRtcInfo = _$ConversationRtcInfoTearOff();

/// @nodoc
mixin _$ConversationRtcInfo {
  String? get token => throw _privateConstructorUsedError;
  @JsonKey(name: "channel_name")
  String? get channelName => throw _privateConstructorUsedError;
  @JsonKey(name: "rtc_uid")
  String? get rtcUid => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConversationRtcInfoCopyWith<ConversationRtcInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationRtcInfoCopyWith<$Res> {
  factory $ConversationRtcInfoCopyWith(
          ConversationRtcInfo value, $Res Function(ConversationRtcInfo) then) =
      _$ConversationRtcInfoCopyWithImpl<$Res>;
  $Res call(
      {String? token,
      @JsonKey(name: "channel_name") String? channelName,
      @JsonKey(name: "rtc_uid") String? rtcUid});
}

/// @nodoc
class _$ConversationRtcInfoCopyWithImpl<$Res>
    implements $ConversationRtcInfoCopyWith<$Res> {
  _$ConversationRtcInfoCopyWithImpl(this._value, this._then);

  final ConversationRtcInfo _value;
  // ignore: unused_field
  final $Res Function(ConversationRtcInfo) _then;

  @override
  $Res call({
    Object? token = freezed,
    Object? channelName = freezed,
    Object? rtcUid = freezed,
  }) {
    return _then(_value.copyWith(
      token: token == freezed
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      channelName: channelName == freezed
          ? _value.channelName
          : channelName // ignore: cast_nullable_to_non_nullable
              as String?,
      rtcUid: rtcUid == freezed
          ? _value.rtcUid
          : rtcUid // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$ConversationRtcInfoCopyWith<$Res>
    implements $ConversationRtcInfoCopyWith<$Res> {
  factory _$ConversationRtcInfoCopyWith(_ConversationRtcInfo value,
          $Res Function(_ConversationRtcInfo) then) =
      __$ConversationRtcInfoCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? token,
      @JsonKey(name: "channel_name") String? channelName,
      @JsonKey(name: "rtc_uid") String? rtcUid});
}

/// @nodoc
class __$ConversationRtcInfoCopyWithImpl<$Res>
    extends _$ConversationRtcInfoCopyWithImpl<$Res>
    implements _$ConversationRtcInfoCopyWith<$Res> {
  __$ConversationRtcInfoCopyWithImpl(
      _ConversationRtcInfo _value, $Res Function(_ConversationRtcInfo) _then)
      : super(_value, (v) => _then(v as _ConversationRtcInfo));

  @override
  _ConversationRtcInfo get _value => super._value as _ConversationRtcInfo;

  @override
  $Res call({
    Object? token = freezed,
    Object? channelName = freezed,
    Object? rtcUid = freezed,
  }) {
    return _then(_ConversationRtcInfo(
      token: token == freezed
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      channelName: channelName == freezed
          ? _value.channelName
          : channelName // ignore: cast_nullable_to_non_nullable
              as String?,
      rtcUid: rtcUid == freezed
          ? _value.rtcUid
          : rtcUid // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ConversationRtcInfo implements _ConversationRtcInfo {
  _$_ConversationRtcInfo(
      {this.token,
      @JsonKey(name: "channel_name") this.channelName,
      @JsonKey(name: "rtc_uid") this.rtcUid});

  factory _$_ConversationRtcInfo.fromJson(Map<String, dynamic> json) =>
      _$_$_ConversationRtcInfoFromJson(json);

  @override
  final String? token;
  @override
  @JsonKey(name: "channel_name")
  final String? channelName;
  @override
  @JsonKey(name: "rtc_uid")
  final String? rtcUid;

  @override
  String toString() {
    return 'ConversationRtcInfo(token: $token, channelName: $channelName, rtcUid: $rtcUid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ConversationRtcInfo &&
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
  _$ConversationRtcInfoCopyWith<_ConversationRtcInfo> get copyWith =>
      __$ConversationRtcInfoCopyWithImpl<_ConversationRtcInfo>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ConversationRtcInfoToJson(this);
  }
}

abstract class _ConversationRtcInfo implements ConversationRtcInfo {
  factory _ConversationRtcInfo(
      {String? token,
      @JsonKey(name: "channel_name") String? channelName,
      @JsonKey(name: "rtc_uid") String? rtcUid}) = _$_ConversationRtcInfo;

  factory _ConversationRtcInfo.fromJson(Map<String, dynamic> json) =
      _$_ConversationRtcInfo.fromJson;

  @override
  String? get token => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "channel_name")
  String? get channelName => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "rtc_uid")
  String? get rtcUid => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ConversationRtcInfoCopyWith<_ConversationRtcInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
