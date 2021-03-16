// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'roundtable_tab_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$MyTablesStateTearOff {
  const _$MyTablesStateTearOff();

// ignore: unused_element
  _MyTablesState call(
      {List<RoundTable> tables, List<Optin> optins, List<Meeting> meetings}) {
    return _MyTablesState(
      tables: tables,
      optins: optins,
      meetings: meetings,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $MyTablesState = _$MyTablesStateTearOff();

/// @nodoc
mixin _$MyTablesState {
  List<RoundTable> get tables;
  List<Optin> get optins;
  List<Meeting> get meetings;

  @JsonKey(ignore: true)
  $MyTablesStateCopyWith<MyTablesState> get copyWith;
}

/// @nodoc
abstract class $MyTablesStateCopyWith<$Res> {
  factory $MyTablesStateCopyWith(
          MyTablesState value, $Res Function(MyTablesState) then) =
      _$MyTablesStateCopyWithImpl<$Res>;
  $Res call(
      {List<RoundTable> tables, List<Optin> optins, List<Meeting> meetings});
}

/// @nodoc
class _$MyTablesStateCopyWithImpl<$Res>
    implements $MyTablesStateCopyWith<$Res> {
  _$MyTablesStateCopyWithImpl(this._value, this._then);

  final MyTablesState _value;
  // ignore: unused_field
  final $Res Function(MyTablesState) _then;

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
abstract class _$MyTablesStateCopyWith<$Res>
    implements $MyTablesStateCopyWith<$Res> {
  factory _$MyTablesStateCopyWith(
          _MyTablesState value, $Res Function(_MyTablesState) then) =
      __$MyTablesStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<RoundTable> tables, List<Optin> optins, List<Meeting> meetings});
}

/// @nodoc
class __$MyTablesStateCopyWithImpl<$Res>
    extends _$MyTablesStateCopyWithImpl<$Res>
    implements _$MyTablesStateCopyWith<$Res> {
  __$MyTablesStateCopyWithImpl(
      _MyTablesState _value, $Res Function(_MyTablesState) _then)
      : super(_value, (v) => _then(v as _MyTablesState));

  @override
  _MyTablesState get _value => super._value as _MyTablesState;

  @override
  $Res call({
    Object tables = freezed,
    Object optins = freezed,
    Object meetings = freezed,
  }) {
    return _then(_MyTablesState(
      tables: tables == freezed ? _value.tables : tables as List<RoundTable>,
      optins: optins == freezed ? _value.optins : optins as List<Optin>,
      meetings:
          meetings == freezed ? _value.meetings : meetings as List<Meeting>,
    ));
  }
}

/// @nodoc
class _$_MyTablesState implements _MyTablesState {
  _$_MyTablesState({this.tables, this.optins, this.meetings});

  @override
  final List<RoundTable> tables;
  @override
  final List<Optin> optins;
  @override
  final List<Meeting> meetings;

  @override
  String toString() {
    return 'MyTablesState(tables: $tables, optins: $optins, meetings: $meetings)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MyTablesState &&
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
  _$MyTablesStateCopyWith<_MyTablesState> get copyWith =>
      __$MyTablesStateCopyWithImpl<_MyTablesState>(this, _$identity);
}

abstract class _MyTablesState implements MyTablesState {
  factory _MyTablesState(
      {List<RoundTable> tables,
      List<Optin> optins,
      List<Meeting> meetings}) = _$_MyTablesState;

  @override
  List<RoundTable> get tables;
  @override
  List<Optin> get optins;
  @override
  List<Meeting> get meetings;
  @override
  @JsonKey(ignore: true)
  _$MyTablesStateCopyWith<_MyTablesState> get copyWith;
}

/// @nodoc
class _$RoundTableTabStateTearOff {
  const _$RoundTableTabStateTearOff();

// ignore: unused_element
  _RoundTableTabState call(
      {List<RoundTable> allTables, MyTablesState myTables}) {
    return _RoundTableTabState(
      allTables: allTables,
      myTables: myTables,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $RoundTableTabState = _$RoundTableTabStateTearOff();

/// @nodoc
mixin _$RoundTableTabState {
  List<RoundTable> get allTables;
  MyTablesState get myTables;

  @JsonKey(ignore: true)
  $RoundTableTabStateCopyWith<RoundTableTabState> get copyWith;
}

/// @nodoc
abstract class $RoundTableTabStateCopyWith<$Res> {
  factory $RoundTableTabStateCopyWith(
          RoundTableTabState value, $Res Function(RoundTableTabState) then) =
      _$RoundTableTabStateCopyWithImpl<$Res>;
  $Res call({List<RoundTable> allTables, MyTablesState myTables});

  $MyTablesStateCopyWith<$Res> get myTables;
}

/// @nodoc
class _$RoundTableTabStateCopyWithImpl<$Res>
    implements $RoundTableTabStateCopyWith<$Res> {
  _$RoundTableTabStateCopyWithImpl(this._value, this._then);

  final RoundTableTabState _value;
  // ignore: unused_field
  final $Res Function(RoundTableTabState) _then;

  @override
  $Res call({
    Object allTables = freezed,
    Object myTables = freezed,
  }) {
    return _then(_value.copyWith(
      allTables: allTables == freezed
          ? _value.allTables
          : allTables as List<RoundTable>,
      myTables:
          myTables == freezed ? _value.myTables : myTables as MyTablesState,
    ));
  }

  @override
  $MyTablesStateCopyWith<$Res> get myTables {
    if (_value.myTables == null) {
      return null;
    }
    return $MyTablesStateCopyWith<$Res>(_value.myTables, (value) {
      return _then(_value.copyWith(myTables: value));
    });
  }
}

/// @nodoc
abstract class _$RoundTableTabStateCopyWith<$Res>
    implements $RoundTableTabStateCopyWith<$Res> {
  factory _$RoundTableTabStateCopyWith(
          _RoundTableTabState value, $Res Function(_RoundTableTabState) then) =
      __$RoundTableTabStateCopyWithImpl<$Res>;
  @override
  $Res call({List<RoundTable> allTables, MyTablesState myTables});

  @override
  $MyTablesStateCopyWith<$Res> get myTables;
}

/// @nodoc
class __$RoundTableTabStateCopyWithImpl<$Res>
    extends _$RoundTableTabStateCopyWithImpl<$Res>
    implements _$RoundTableTabStateCopyWith<$Res> {
  __$RoundTableTabStateCopyWithImpl(
      _RoundTableTabState _value, $Res Function(_RoundTableTabState) _then)
      : super(_value, (v) => _then(v as _RoundTableTabState));

  @override
  _RoundTableTabState get _value => super._value as _RoundTableTabState;

  @override
  $Res call({
    Object allTables = freezed,
    Object myTables = freezed,
  }) {
    return _then(_RoundTableTabState(
      allTables: allTables == freezed
          ? _value.allTables
          : allTables as List<RoundTable>,
      myTables:
          myTables == freezed ? _value.myTables : myTables as MyTablesState,
    ));
  }
}

/// @nodoc
class _$_RoundTableTabState implements _RoundTableTabState {
  _$_RoundTableTabState({this.allTables, this.myTables});

  @override
  final List<RoundTable> allTables;
  @override
  final MyTablesState myTables;

  @override
  String toString() {
    return 'RoundTableTabState(allTables: $allTables, myTables: $myTables)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RoundTableTabState &&
            (identical(other.allTables, allTables) ||
                const DeepCollectionEquality()
                    .equals(other.allTables, allTables)) &&
            (identical(other.myTables, myTables) ||
                const DeepCollectionEquality()
                    .equals(other.myTables, myTables)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(allTables) ^
      const DeepCollectionEquality().hash(myTables);

  @JsonKey(ignore: true)
  @override
  _$RoundTableTabStateCopyWith<_RoundTableTabState> get copyWith =>
      __$RoundTableTabStateCopyWithImpl<_RoundTableTabState>(this, _$identity);
}

abstract class _RoundTableTabState implements RoundTableTabState {
  factory _RoundTableTabState(
      {List<RoundTable> allTables,
      MyTablesState myTables}) = _$_RoundTableTabState;

  @override
  List<RoundTable> get allTables;
  @override
  MyTablesState get myTables;
  @override
  @JsonKey(ignore: true)
  _$RoundTableTabStateCopyWith<_RoundTableTabState> get copyWith;
}
