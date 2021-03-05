// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'optin_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Optin _$OptinFromJson(Map<String, dynamic> json) {
  return _Optin.fromJson(json);
}

/// @nodoc
class _$OptinTearOff {
  const _$OptinTearOff();

// ignore: unused_element
  _Optin call({String name}) {
    return _Optin(
      name: name,
    );
  }

// ignore: unused_element
  Optin fromJson(Map<String, Object> json) {
    return Optin.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Optin = _$OptinTearOff();

/// @nodoc
mixin _$Optin {
  String get name;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $OptinCopyWith<Optin> get copyWith;
}

/// @nodoc
abstract class $OptinCopyWith<$Res> {
  factory $OptinCopyWith(Optin value, $Res Function(Optin) then) =
      _$OptinCopyWithImpl<$Res>;
  $Res call({String name});
}

/// @nodoc
class _$OptinCopyWithImpl<$Res> implements $OptinCopyWith<$Res> {
  _$OptinCopyWithImpl(this._value, this._then);

  final Optin _value;
  // ignore: unused_field
  final $Res Function(Optin) _then;

  @override
  $Res call({
    Object name = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed ? _value.name : name as String,
    ));
  }
}

/// @nodoc
abstract class _$OptinCopyWith<$Res> implements $OptinCopyWith<$Res> {
  factory _$OptinCopyWith(_Optin value, $Res Function(_Optin) then) =
      __$OptinCopyWithImpl<$Res>;
  @override
  $Res call({String name});
}

/// @nodoc
class __$OptinCopyWithImpl<$Res> extends _$OptinCopyWithImpl<$Res>
    implements _$OptinCopyWith<$Res> {
  __$OptinCopyWithImpl(_Optin _value, $Res Function(_Optin) _then)
      : super(_value, (v) => _then(v as _Optin));

  @override
  _Optin get _value => super._value as _Optin;

  @override
  $Res call({
    Object name = freezed,
  }) {
    return _then(_Optin(
      name: name == freezed ? _value.name : name as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Optin implements _Optin {
  _$_Optin({this.name});

  factory _$_Optin.fromJson(Map<String, dynamic> json) =>
      _$_$_OptinFromJson(json);

  @override
  final String name;

  @override
  String toString() {
    return 'Optin(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Optin &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(name);

  @JsonKey(ignore: true)
  @override
  _$OptinCopyWith<_Optin> get copyWith =>
      __$OptinCopyWithImpl<_Optin>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_OptinToJson(this);
  }
}

abstract class _Optin implements Optin {
  factory _Optin({String name}) = _$_Optin;

  factory _Optin.fromJson(Map<String, dynamic> json) = _$_Optin.fromJson;

  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$OptinCopyWith<_Optin> get copyWith;
}
