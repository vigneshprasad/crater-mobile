// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'dyte_meeting_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DyteMeeting _$DyteMeetingFromJson(Map<String, dynamic> json) {
  return _DyteMeeting.fromJson(json);
}

/// @nodoc
class _$DyteMeetingTearOff {
  const _$DyteMeetingTearOff();

  _DyteMeeting call(
      {int? pk,
      int? dyteMeeting,
      String? authToken,
      bool isOnline = false,
      DyteMeetingDetail? dyteMeetingDetail}) {
    return _DyteMeeting(
      pk: pk,
      dyteMeeting: dyteMeeting,
      authToken: authToken,
      isOnline: isOnline,
      dyteMeetingDetail: dyteMeetingDetail,
    );
  }

  DyteMeeting fromJson(Map<String, Object> json) {
    return DyteMeeting.fromJson(json);
  }
}

/// @nodoc
const $DyteMeeting = _$DyteMeetingTearOff();

/// @nodoc
mixin _$DyteMeeting {
  int? get pk => throw _privateConstructorUsedError;
  int? get dyteMeeting => throw _privateConstructorUsedError;
  String? get authToken => throw _privateConstructorUsedError;
  bool get isOnline => throw _privateConstructorUsedError;
  DyteMeetingDetail? get dyteMeetingDetail =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DyteMeetingCopyWith<DyteMeeting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DyteMeetingCopyWith<$Res> {
  factory $DyteMeetingCopyWith(
          DyteMeeting value, $Res Function(DyteMeeting) then) =
      _$DyteMeetingCopyWithImpl<$Res>;
  $Res call(
      {int? pk,
      int? dyteMeeting,
      String? authToken,
      bool isOnline,
      DyteMeetingDetail? dyteMeetingDetail});

  $DyteMeetingDetailCopyWith<$Res>? get dyteMeetingDetail;
}

/// @nodoc
class _$DyteMeetingCopyWithImpl<$Res> implements $DyteMeetingCopyWith<$Res> {
  _$DyteMeetingCopyWithImpl(this._value, this._then);

  final DyteMeeting _value;
  // ignore: unused_field
  final $Res Function(DyteMeeting) _then;

  @override
  $Res call({
    Object? pk = freezed,
    Object? dyteMeeting = freezed,
    Object? authToken = freezed,
    Object? isOnline = freezed,
    Object? dyteMeetingDetail = freezed,
  }) {
    return _then(_value.copyWith(
      pk: pk == freezed
          ? _value.pk
          : pk // ignore: cast_nullable_to_non_nullable
              as int?,
      dyteMeeting: dyteMeeting == freezed
          ? _value.dyteMeeting
          : dyteMeeting // ignore: cast_nullable_to_non_nullable
              as int?,
      authToken: authToken == freezed
          ? _value.authToken
          : authToken // ignore: cast_nullable_to_non_nullable
              as String?,
      isOnline: isOnline == freezed
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      dyteMeetingDetail: dyteMeetingDetail == freezed
          ? _value.dyteMeetingDetail
          : dyteMeetingDetail // ignore: cast_nullable_to_non_nullable
              as DyteMeetingDetail?,
    ));
  }

  @override
  $DyteMeetingDetailCopyWith<$Res>? get dyteMeetingDetail {
    if (_value.dyteMeetingDetail == null) {
      return null;
    }

    return $DyteMeetingDetailCopyWith<$Res>(_value.dyteMeetingDetail!, (value) {
      return _then(_value.copyWith(dyteMeetingDetail: value));
    });
  }
}

/// @nodoc
abstract class _$DyteMeetingCopyWith<$Res>
    implements $DyteMeetingCopyWith<$Res> {
  factory _$DyteMeetingCopyWith(
          _DyteMeeting value, $Res Function(_DyteMeeting) then) =
      __$DyteMeetingCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? pk,
      int? dyteMeeting,
      String? authToken,
      bool isOnline,
      DyteMeetingDetail? dyteMeetingDetail});

  @override
  $DyteMeetingDetailCopyWith<$Res>? get dyteMeetingDetail;
}

/// @nodoc
class __$DyteMeetingCopyWithImpl<$Res> extends _$DyteMeetingCopyWithImpl<$Res>
    implements _$DyteMeetingCopyWith<$Res> {
  __$DyteMeetingCopyWithImpl(
      _DyteMeeting _value, $Res Function(_DyteMeeting) _then)
      : super(_value, (v) => _then(v as _DyteMeeting));

  @override
  _DyteMeeting get _value => super._value as _DyteMeeting;

  @override
  $Res call({
    Object? pk = freezed,
    Object? dyteMeeting = freezed,
    Object? authToken = freezed,
    Object? isOnline = freezed,
    Object? dyteMeetingDetail = freezed,
  }) {
    return _then(_DyteMeeting(
      pk: pk == freezed
          ? _value.pk
          : pk // ignore: cast_nullable_to_non_nullable
              as int?,
      dyteMeeting: dyteMeeting == freezed
          ? _value.dyteMeeting
          : dyteMeeting // ignore: cast_nullable_to_non_nullable
              as int?,
      authToken: authToken == freezed
          ? _value.authToken
          : authToken // ignore: cast_nullable_to_non_nullable
              as String?,
      isOnline: isOnline == freezed
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      dyteMeetingDetail: dyteMeetingDetail == freezed
          ? _value.dyteMeetingDetail
          : dyteMeetingDetail // ignore: cast_nullable_to_non_nullable
              as DyteMeetingDetail?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DyteMeeting implements _DyteMeeting {
  const _$_DyteMeeting(
      {this.pk,
      this.dyteMeeting,
      this.authToken,
      this.isOnline = false,
      this.dyteMeetingDetail});

  factory _$_DyteMeeting.fromJson(Map<String, dynamic> json) =>
      _$_$_DyteMeetingFromJson(json);

  @override
  final int? pk;
  @override
  final int? dyteMeeting;
  @override
  final String? authToken;
  @JsonKey(defaultValue: false)
  @override
  final bool isOnline;
  @override
  final DyteMeetingDetail? dyteMeetingDetail;

  @override
  String toString() {
    return 'DyteMeeting(pk: $pk, dyteMeeting: $dyteMeeting, authToken: $authToken, isOnline: $isOnline, dyteMeetingDetail: $dyteMeetingDetail)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DyteMeeting &&
            (identical(other.pk, pk) ||
                const DeepCollectionEquality().equals(other.pk, pk)) &&
            (identical(other.dyteMeeting, dyteMeeting) ||
                const DeepCollectionEquality()
                    .equals(other.dyteMeeting, dyteMeeting)) &&
            (identical(other.authToken, authToken) ||
                const DeepCollectionEquality()
                    .equals(other.authToken, authToken)) &&
            (identical(other.isOnline, isOnline) ||
                const DeepCollectionEquality()
                    .equals(other.isOnline, isOnline)) &&
            (identical(other.dyteMeetingDetail, dyteMeetingDetail) ||
                const DeepCollectionEquality()
                    .equals(other.dyteMeetingDetail, dyteMeetingDetail)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(pk) ^
      const DeepCollectionEquality().hash(dyteMeeting) ^
      const DeepCollectionEquality().hash(authToken) ^
      const DeepCollectionEquality().hash(isOnline) ^
      const DeepCollectionEquality().hash(dyteMeetingDetail);

  @JsonKey(ignore: true)
  @override
  _$DyteMeetingCopyWith<_DyteMeeting> get copyWith =>
      __$DyteMeetingCopyWithImpl<_DyteMeeting>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_DyteMeetingToJson(this);
  }
}

abstract class _DyteMeeting implements DyteMeeting {
  const factory _DyteMeeting(
      {int? pk,
      int? dyteMeeting,
      String? authToken,
      bool isOnline,
      DyteMeetingDetail? dyteMeetingDetail}) = _$_DyteMeeting;

  factory _DyteMeeting.fromJson(Map<String, dynamic> json) =
      _$_DyteMeeting.fromJson;

  @override
  int? get pk => throw _privateConstructorUsedError;
  @override
  int? get dyteMeeting => throw _privateConstructorUsedError;
  @override
  String? get authToken => throw _privateConstructorUsedError;
  @override
  bool get isOnline => throw _privateConstructorUsedError;
  @override
  DyteMeetingDetail? get dyteMeetingDetail =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$DyteMeetingCopyWith<_DyteMeeting> get copyWith =>
      throw _privateConstructorUsedError;
}

DyteMeetingDetail _$DyteMeetingDetailFromJson(Map<String, dynamic> json) {
  return _DyteMeetingDetail.fromJson(json);
}

/// @nodoc
class _$DyteMeetingDetailTearOff {
  const _$DyteMeetingDetailTearOff();

  _DyteMeetingDetail call(
      {int? group, String? dyteMeetingId, String? roomName}) {
    return _DyteMeetingDetail(
      group: group,
      dyteMeetingId: dyteMeetingId,
      roomName: roomName,
    );
  }

  DyteMeetingDetail fromJson(Map<String, Object> json) {
    return DyteMeetingDetail.fromJson(json);
  }
}

/// @nodoc
const $DyteMeetingDetail = _$DyteMeetingDetailTearOff();

/// @nodoc
mixin _$DyteMeetingDetail {
// dynamic? meeting,
  int? get group => throw _privateConstructorUsedError;
  String? get dyteMeetingId => throw _privateConstructorUsedError;
  String? get roomName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DyteMeetingDetailCopyWith<DyteMeetingDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DyteMeetingDetailCopyWith<$Res> {
  factory $DyteMeetingDetailCopyWith(
          DyteMeetingDetail value, $Res Function(DyteMeetingDetail) then) =
      _$DyteMeetingDetailCopyWithImpl<$Res>;
  $Res call({int? group, String? dyteMeetingId, String? roomName});
}

/// @nodoc
class _$DyteMeetingDetailCopyWithImpl<$Res>
    implements $DyteMeetingDetailCopyWith<$Res> {
  _$DyteMeetingDetailCopyWithImpl(this._value, this._then);

  final DyteMeetingDetail _value;
  // ignore: unused_field
  final $Res Function(DyteMeetingDetail) _then;

  @override
  $Res call({
    Object? group = freezed,
    Object? dyteMeetingId = freezed,
    Object? roomName = freezed,
  }) {
    return _then(_value.copyWith(
      group: group == freezed
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as int?,
      dyteMeetingId: dyteMeetingId == freezed
          ? _value.dyteMeetingId
          : dyteMeetingId // ignore: cast_nullable_to_non_nullable
              as String?,
      roomName: roomName == freezed
          ? _value.roomName
          : roomName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$DyteMeetingDetailCopyWith<$Res>
    implements $DyteMeetingDetailCopyWith<$Res> {
  factory _$DyteMeetingDetailCopyWith(
          _DyteMeetingDetail value, $Res Function(_DyteMeetingDetail) then) =
      __$DyteMeetingDetailCopyWithImpl<$Res>;
  @override
  $Res call({int? group, String? dyteMeetingId, String? roomName});
}

/// @nodoc
class __$DyteMeetingDetailCopyWithImpl<$Res>
    extends _$DyteMeetingDetailCopyWithImpl<$Res>
    implements _$DyteMeetingDetailCopyWith<$Res> {
  __$DyteMeetingDetailCopyWithImpl(
      _DyteMeetingDetail _value, $Res Function(_DyteMeetingDetail) _then)
      : super(_value, (v) => _then(v as _DyteMeetingDetail));

  @override
  _DyteMeetingDetail get _value => super._value as _DyteMeetingDetail;

  @override
  $Res call({
    Object? group = freezed,
    Object? dyteMeetingId = freezed,
    Object? roomName = freezed,
  }) {
    return _then(_DyteMeetingDetail(
      group: group == freezed
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as int?,
      dyteMeetingId: dyteMeetingId == freezed
          ? _value.dyteMeetingId
          : dyteMeetingId // ignore: cast_nullable_to_non_nullable
              as String?,
      roomName: roomName == freezed
          ? _value.roomName
          : roomName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DyteMeetingDetail implements _DyteMeetingDetail {
  const _$_DyteMeetingDetail({this.group, this.dyteMeetingId, this.roomName});

  factory _$_DyteMeetingDetail.fromJson(Map<String, dynamic> json) =>
      _$_$_DyteMeetingDetailFromJson(json);

  @override // dynamic? meeting,
  final int? group;
  @override
  final String? dyteMeetingId;
  @override
  final String? roomName;

  @override
  String toString() {
    return 'DyteMeetingDetail(group: $group, dyteMeetingId: $dyteMeetingId, roomName: $roomName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DyteMeetingDetail &&
            (identical(other.group, group) ||
                const DeepCollectionEquality().equals(other.group, group)) &&
            (identical(other.dyteMeetingId, dyteMeetingId) ||
                const DeepCollectionEquality()
                    .equals(other.dyteMeetingId, dyteMeetingId)) &&
            (identical(other.roomName, roomName) ||
                const DeepCollectionEquality()
                    .equals(other.roomName, roomName)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(group) ^
      const DeepCollectionEquality().hash(dyteMeetingId) ^
      const DeepCollectionEquality().hash(roomName);

  @JsonKey(ignore: true)
  @override
  _$DyteMeetingDetailCopyWith<_DyteMeetingDetail> get copyWith =>
      __$DyteMeetingDetailCopyWithImpl<_DyteMeetingDetail>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_DyteMeetingDetailToJson(this);
  }
}

abstract class _DyteMeetingDetail implements DyteMeetingDetail {
  const factory _DyteMeetingDetail(
      {int? group,
      String? dyteMeetingId,
      String? roomName}) = _$_DyteMeetingDetail;

  factory _DyteMeetingDetail.fromJson(Map<String, dynamic> json) =
      _$_DyteMeetingDetail.fromJson;

  @override // dynamic? meeting,
  int? get group => throw _privateConstructorUsedError;
  @override
  String? get dyteMeetingId => throw _privateConstructorUsedError;
  @override
  String? get roomName => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$DyteMeetingDetailCopyWith<_DyteMeetingDetail> get copyWith =>
      throw _privateConstructorUsedError;
}
