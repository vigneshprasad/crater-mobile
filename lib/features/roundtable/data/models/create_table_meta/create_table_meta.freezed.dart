// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'create_table_meta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$CreateTableMetaTearOff {
  const _$CreateTableMetaTearOff();

// ignore: unused_element
  _CreateTableMeta call(
      {List<MeetingInterest> interests, MeetingConfig config}) {
    return _CreateTableMeta(
      interests: interests,
      config: config,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $CreateTableMeta = _$CreateTableMetaTearOff();

/// @nodoc
mixin _$CreateTableMeta {
  List<MeetingInterest> get interests;
  MeetingConfig get config;

  @JsonKey(ignore: true)
  $CreateTableMetaCopyWith<CreateTableMeta> get copyWith;
}

/// @nodoc
abstract class $CreateTableMetaCopyWith<$Res> {
  factory $CreateTableMetaCopyWith(
          CreateTableMeta value, $Res Function(CreateTableMeta) then) =
      _$CreateTableMetaCopyWithImpl<$Res>;
  $Res call({List<MeetingInterest> interests, MeetingConfig config});
}

/// @nodoc
class _$CreateTableMetaCopyWithImpl<$Res>
    implements $CreateTableMetaCopyWith<$Res> {
  _$CreateTableMetaCopyWithImpl(this._value, this._then);

  final CreateTableMeta _value;
  // ignore: unused_field
  final $Res Function(CreateTableMeta) _then;

  @override
  $Res call({
    Object interests = freezed,
    Object config = freezed,
  }) {
    return _then(_value.copyWith(
      interests: interests == freezed
          ? _value.interests
          : interests as List<MeetingInterest>,
      config: config == freezed ? _value.config : config as MeetingConfig,
    ));
  }
}

/// @nodoc
abstract class _$CreateTableMetaCopyWith<$Res>
    implements $CreateTableMetaCopyWith<$Res> {
  factory _$CreateTableMetaCopyWith(
          _CreateTableMeta value, $Res Function(_CreateTableMeta) then) =
      __$CreateTableMetaCopyWithImpl<$Res>;
  @override
  $Res call({List<MeetingInterest> interests, MeetingConfig config});
}

/// @nodoc
class __$CreateTableMetaCopyWithImpl<$Res>
    extends _$CreateTableMetaCopyWithImpl<$Res>
    implements _$CreateTableMetaCopyWith<$Res> {
  __$CreateTableMetaCopyWithImpl(
      _CreateTableMeta _value, $Res Function(_CreateTableMeta) _then)
      : super(_value, (v) => _then(v as _CreateTableMeta));

  @override
  _CreateTableMeta get _value => super._value as _CreateTableMeta;

  @override
  $Res call({
    Object interests = freezed,
    Object config = freezed,
  }) {
    return _then(_CreateTableMeta(
      interests: interests == freezed
          ? _value.interests
          : interests as List<MeetingInterest>,
      config: config == freezed ? _value.config : config as MeetingConfig,
    ));
  }
}

/// @nodoc
class _$_CreateTableMeta implements _CreateTableMeta {
  _$_CreateTableMeta({this.interests, this.config});

  @override
  final List<MeetingInterest> interests;
  @override
  final MeetingConfig config;

  @override
  String toString() {
    return 'CreateTableMeta(interests: $interests, config: $config)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CreateTableMeta &&
            (identical(other.interests, interests) ||
                const DeepCollectionEquality()
                    .equals(other.interests, interests)) &&
            (identical(other.config, config) ||
                const DeepCollectionEquality().equals(other.config, config)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(interests) ^
      const DeepCollectionEquality().hash(config);

  @JsonKey(ignore: true)
  @override
  _$CreateTableMetaCopyWith<_CreateTableMeta> get copyWith =>
      __$CreateTableMetaCopyWithImpl<_CreateTableMeta>(this, _$identity);
}

abstract class _CreateTableMeta implements CreateTableMeta {
  factory _CreateTableMeta(
      {List<MeetingInterest> interests,
      MeetingConfig config}) = _$_CreateTableMeta;

  @override
  List<MeetingInterest> get interests;
  @override
  MeetingConfig get config;
  @override
  @JsonKey(ignore: true)
  _$CreateTableMetaCopyWith<_CreateTableMeta> get copyWith;
}
