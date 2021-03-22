// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'roundtables_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$PageStateTearOff {
  const _$PageStateTearOff();

// ignore: unused_element
  _PageState call(
      {List<RoundTable> tables, List<Optin> optins, List<Meeting> meetings}) {
    return _PageState(
      tables: tables,
      optins: optins,
      meetings: meetings,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $PageState = _$PageStateTearOff();

/// @nodoc
mixin _$PageState {
  List<RoundTable> get tables;
  List<Optin> get optins;
  List<Meeting> get meetings;

  @JsonKey(ignore: true)
  $PageStateCopyWith<PageState> get copyWith;
}

/// @nodoc
abstract class $PageStateCopyWith<$Res> {
  factory $PageStateCopyWith(PageState value, $Res Function(PageState) then) =
      _$PageStateCopyWithImpl<$Res>;
  $Res call(
      {List<RoundTable> tables, List<Optin> optins, List<Meeting> meetings});
}

/// @nodoc
class _$PageStateCopyWithImpl<$Res> implements $PageStateCopyWith<$Res> {
  _$PageStateCopyWithImpl(this._value, this._then);

  final PageState _value;
  // ignore: unused_field
  final $Res Function(PageState) _then;

  @override
  $Res call({
    Object tables = freezed,
    Object optins = freezed,
    Object meetings = freezed,
  }) {
    return _then(_value.copyWith(
      tables: tables == freezed ? _value.tables : tables as List<RoundTable>,
      optins: optins == freezed ? _value.optins : optins as List<Optin>,
      meetings:
          meetings == freezed ? _value.meetings : meetings as List<Meeting>,
    ));
  }
}

/// @nodoc
abstract class _$PageStateCopyWith<$Res> implements $PageStateCopyWith<$Res> {
  factory _$PageStateCopyWith(
          _PageState value, $Res Function(_PageState) then) =
      __$PageStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<RoundTable> tables, List<Optin> optins, List<Meeting> meetings});
}

/// @nodoc
class __$PageStateCopyWithImpl<$Res> extends _$PageStateCopyWithImpl<$Res>
    implements _$PageStateCopyWith<$Res> {
  __$PageStateCopyWithImpl(_PageState _value, $Res Function(_PageState) _then)
      : super(_value, (v) => _then(v as _PageState));

  @override
  _PageState get _value => super._value as _PageState;

  @override
  $Res call({
    Object tables = freezed,
    Object optins = freezed,
    Object meetings = freezed,
  }) {
    return _then(_PageState(
      tables: tables == freezed ? _value.tables : tables as List<RoundTable>,
      optins: optins == freezed ? _value.optins : optins as List<Optin>,
      meetings:
          meetings == freezed ? _value.meetings : meetings as List<Meeting>,
    ));
  }
}

/// @nodoc
class _$_PageState implements _PageState {
  _$_PageState({this.tables, this.optins, this.meetings});

  @override
  final List<RoundTable> tables;
  @override
  final List<Optin> optins;
  @override
  final List<Meeting> meetings;

  @override
  String toString() {
    return 'PageState(tables: $tables, optins: $optins, meetings: $meetings)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PageState &&
            (identical(other.tables, tables) ||
                const DeepCollectionEquality().equals(other.tables, tables)) &&
            (identical(other.optins, optins) ||
                const DeepCollectionEquality().equals(other.optins, optins)) &&
            (identical(other.meetings, meetings) ||
                const DeepCollectionEquality()
                    .equals(other.meetings, meetings)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(tables) ^
      const DeepCollectionEquality().hash(optins) ^
      const DeepCollectionEquality().hash(meetings);

  @JsonKey(ignore: true)
  @override
  _$PageStateCopyWith<_PageState> get copyWith =>
      __$PageStateCopyWithImpl<_PageState>(this, _$identity);
}

abstract class _PageState implements PageState {
  factory _PageState(
      {List<RoundTable> tables,
      List<Optin> optins,
      List<Meeting> meetings}) = _$_PageState;

  @override
  List<RoundTable> get tables;
  @override
  List<Optin> get optins;
  @override
  List<Meeting> get meetings;
  @override
  @JsonKey(ignore: true)
  _$PageStateCopyWith<_PageState> get copyWith;
}
