// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'series_request_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SeriesRequest _$SeriesRequestFromJson(Map<String, dynamic> json) {
  return _SeriesRequest.fromJson(json);
}

/// @nodoc
class _$SeriesRequestTearOff {
  const _$SeriesRequestTearOff();

  _SeriesRequest call({@JsonKey(name: "series_id") String? seriesId}) {
    return _SeriesRequest(
      seriesId: seriesId,
    );
  }

  SeriesRequest fromJson(Map<String, Object> json) {
    return SeriesRequest.fromJson(json);
  }
}

/// @nodoc
const $SeriesRequest = _$SeriesRequestTearOff();

/// @nodoc
mixin _$SeriesRequest {
  @JsonKey(name: "series_id")
  String? get seriesId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SeriesRequestCopyWith<SeriesRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeriesRequestCopyWith<$Res> {
  factory $SeriesRequestCopyWith(
          SeriesRequest value, $Res Function(SeriesRequest) then) =
      _$SeriesRequestCopyWithImpl<$Res>;
  $Res call({@JsonKey(name: "series_id") String? seriesId});
}

/// @nodoc
class _$SeriesRequestCopyWithImpl<$Res>
    implements $SeriesRequestCopyWith<$Res> {
  _$SeriesRequestCopyWithImpl(this._value, this._then);

  final SeriesRequest _value;
  // ignore: unused_field
  final $Res Function(SeriesRequest) _then;

  @override
  $Res call({
    Object? seriesId = freezed,
  }) {
    return _then(_value.copyWith(
      seriesId: seriesId == freezed
          ? _value.seriesId
          : seriesId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$SeriesRequestCopyWith<$Res>
    implements $SeriesRequestCopyWith<$Res> {
  factory _$SeriesRequestCopyWith(
          _SeriesRequest value, $Res Function(_SeriesRequest) then) =
      __$SeriesRequestCopyWithImpl<$Res>;
  @override
  $Res call({@JsonKey(name: "series_id") String? seriesId});
}

/// @nodoc
class __$SeriesRequestCopyWithImpl<$Res>
    extends _$SeriesRequestCopyWithImpl<$Res>
    implements _$SeriesRequestCopyWith<$Res> {
  __$SeriesRequestCopyWithImpl(
      _SeriesRequest _value, $Res Function(_SeriesRequest) _then)
      : super(_value, (v) => _then(v as _SeriesRequest));

  @override
  _SeriesRequest get _value => super._value as _SeriesRequest;

  @override
  $Res call({
    Object? seriesId = freezed,
  }) {
    return _then(_SeriesRequest(
      seriesId: seriesId == freezed
          ? _value.seriesId
          : seriesId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SeriesRequest implements _SeriesRequest {
  _$_SeriesRequest({@JsonKey(name: "series_id") this.seriesId});

  factory _$_SeriesRequest.fromJson(Map<String, dynamic> json) =>
      _$_$_SeriesRequestFromJson(json);

  @override
  @JsonKey(name: "series_id")
  final String? seriesId;

  @override
  String toString() {
    return 'SeriesRequest(seriesId: $seriesId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SeriesRequest &&
            (identical(other.seriesId, seriesId) ||
                const DeepCollectionEquality()
                    .equals(other.seriesId, seriesId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(seriesId);

  @JsonKey(ignore: true)
  @override
  _$SeriesRequestCopyWith<_SeriesRequest> get copyWith =>
      __$SeriesRequestCopyWithImpl<_SeriesRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_SeriesRequestToJson(this);
  }
}

abstract class _SeriesRequest implements SeriesRequest {
  factory _SeriesRequest({@JsonKey(name: "series_id") String? seriesId}) =
      _$_SeriesRequest;

  factory _SeriesRequest.fromJson(Map<String, dynamic> json) =
      _$_SeriesRequest.fromJson;

  @override
  @JsonKey(name: "series_id")
  String? get seriesId => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$SeriesRequestCopyWith<_SeriesRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
