// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'roundtable_meta_api_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
RoundTableMetaApiResponse _$RoundTableMetaApiResponseFromJson(
    Map<String, dynamic> json) {
  return _RoundTableMetaApiResponse.fromJson(json);
}

/// @nodoc
class _$RoundTableMetaApiResponseTearOff {
  const _$RoundTableMetaApiResponseTearOff();

// ignore: unused_element
  _RoundTableMetaApiResponse call({int user, int upcoming, int all}) {
    return _RoundTableMetaApiResponse(
      user: user,
      upcoming: upcoming,
      all: all,
    );
  }

// ignore: unused_element
  RoundTableMetaApiResponse fromJson(Map<String, Object> json) {
    return RoundTableMetaApiResponse.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $RoundTableMetaApiResponse = _$RoundTableMetaApiResponseTearOff();

/// @nodoc
mixin _$RoundTableMetaApiResponse {
  int get user;
  int get upcoming;
  int get all;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $RoundTableMetaApiResponseCopyWith<RoundTableMetaApiResponse> get copyWith;
}

/// @nodoc
abstract class $RoundTableMetaApiResponseCopyWith<$Res> {
  factory $RoundTableMetaApiResponseCopyWith(RoundTableMetaApiResponse value,
          $Res Function(RoundTableMetaApiResponse) then) =
      _$RoundTableMetaApiResponseCopyWithImpl<$Res>;
  $Res call({int user, int upcoming, int all});
}

/// @nodoc
class _$RoundTableMetaApiResponseCopyWithImpl<$Res>
    implements $RoundTableMetaApiResponseCopyWith<$Res> {
  _$RoundTableMetaApiResponseCopyWithImpl(this._value, this._then);

  final RoundTableMetaApiResponse _value;
  // ignore: unused_field
  final $Res Function(RoundTableMetaApiResponse) _then;

  @override
  $Res call({
    Object user = freezed,
    Object upcoming = freezed,
    Object all = freezed,
  }) {
    return _then(_value.copyWith(
      user: user == freezed ? _value.user : user as int,
      upcoming: upcoming == freezed ? _value.upcoming : upcoming as int,
      all: all == freezed ? _value.all : all as int,
    ));
  }
}

/// @nodoc
abstract class _$RoundTableMetaApiResponseCopyWith<$Res>
    implements $RoundTableMetaApiResponseCopyWith<$Res> {
  factory _$RoundTableMetaApiResponseCopyWith(_RoundTableMetaApiResponse value,
          $Res Function(_RoundTableMetaApiResponse) then) =
      __$RoundTableMetaApiResponseCopyWithImpl<$Res>;
  @override
  $Res call({int user, int upcoming, int all});
}

/// @nodoc
class __$RoundTableMetaApiResponseCopyWithImpl<$Res>
    extends _$RoundTableMetaApiResponseCopyWithImpl<$Res>
    implements _$RoundTableMetaApiResponseCopyWith<$Res> {
  __$RoundTableMetaApiResponseCopyWithImpl(_RoundTableMetaApiResponse _value,
      $Res Function(_RoundTableMetaApiResponse) _then)
      : super(_value, (v) => _then(v as _RoundTableMetaApiResponse));

  @override
  _RoundTableMetaApiResponse get _value =>
      super._value as _RoundTableMetaApiResponse;

  @override
  $Res call({
    Object user = freezed,
    Object upcoming = freezed,
    Object all = freezed,
  }) {
    return _then(_RoundTableMetaApiResponse(
      user: user == freezed ? _value.user : user as int,
      upcoming: upcoming == freezed ? _value.upcoming : upcoming as int,
      all: all == freezed ? _value.all : all as int,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_RoundTableMetaApiResponse implements _RoundTableMetaApiResponse {
  _$_RoundTableMetaApiResponse({this.user, this.upcoming, this.all});

  factory _$_RoundTableMetaApiResponse.fromJson(Map<String, dynamic> json) =>
      _$_$_RoundTableMetaApiResponseFromJson(json);

  @override
  final int user;
  @override
  final int upcoming;
  @override
  final int all;

  @override
  String toString() {
    return 'RoundTableMetaApiResponse(user: $user, upcoming: $upcoming, all: $all)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RoundTableMetaApiResponse &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.upcoming, upcoming) ||
                const DeepCollectionEquality()
                    .equals(other.upcoming, upcoming)) &&
            (identical(other.all, all) ||
                const DeepCollectionEquality().equals(other.all, all)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(user) ^
      const DeepCollectionEquality().hash(upcoming) ^
      const DeepCollectionEquality().hash(all);

  @JsonKey(ignore: true)
  @override
  _$RoundTableMetaApiResponseCopyWith<_RoundTableMetaApiResponse>
      get copyWith =>
          __$RoundTableMetaApiResponseCopyWithImpl<_RoundTableMetaApiResponse>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_RoundTableMetaApiResponseToJson(this);
  }
}

abstract class _RoundTableMetaApiResponse implements RoundTableMetaApiResponse {
  factory _RoundTableMetaApiResponse({int user, int upcoming, int all}) =
      _$_RoundTableMetaApiResponse;

  factory _RoundTableMetaApiResponse.fromJson(Map<String, dynamic> json) =
      _$_RoundTableMetaApiResponse.fromJson;

  @override
  int get user;
  @override
  int get upcoming;
  @override
  int get all;
  @override
  @JsonKey(ignore: true)
  _$RoundTableMetaApiResponseCopyWith<_RoundTableMetaApiResponse> get copyWith;
}
