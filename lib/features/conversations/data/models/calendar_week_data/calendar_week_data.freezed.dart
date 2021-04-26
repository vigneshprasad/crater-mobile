// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'calendar_week_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$CalendarWeekDataTearOff {
  const _$CalendarWeekDataTearOff();

// ignore: unused_element
  _CalendarWeekData call(
      {bool future,
      DateTime start,
      DateTime end,
      List<ConversationByDate> conversations = const [],
      List<OptinsByDate> optins = const []}) {
    return _CalendarWeekData(
      future: future,
      start: start,
      end: end,
      conversations: conversations,
      optins: optins,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $CalendarWeekData = _$CalendarWeekDataTearOff();

/// @nodoc
mixin _$CalendarWeekData {
  bool get future;
  DateTime get start;
  DateTime get end;
  List<ConversationByDate> get conversations;
  List<OptinsByDate> get optins;

  @JsonKey(ignore: true)
  $CalendarWeekDataCopyWith<CalendarWeekData> get copyWith;
}

/// @nodoc
abstract class $CalendarWeekDataCopyWith<$Res> {
  factory $CalendarWeekDataCopyWith(
          CalendarWeekData value, $Res Function(CalendarWeekData) then) =
      _$CalendarWeekDataCopyWithImpl<$Res>;
  $Res call(
      {bool future,
      DateTime start,
      DateTime end,
      List<ConversationByDate> conversations,
      List<OptinsByDate> optins});
}

/// @nodoc
class _$CalendarWeekDataCopyWithImpl<$Res>
    implements $CalendarWeekDataCopyWith<$Res> {
  _$CalendarWeekDataCopyWithImpl(this._value, this._then);

  final CalendarWeekData _value;
  // ignore: unused_field
  final $Res Function(CalendarWeekData) _then;

  @override
  $Res call({
    Object future = freezed,
    Object start = freezed,
    Object end = freezed,
    Object conversations = freezed,
    Object optins = freezed,
  }) {
    return _then(_value.copyWith(
      future: future == freezed ? _value.future : future as bool,
      start: start == freezed ? _value.start : start as DateTime,
      end: end == freezed ? _value.end : end as DateTime,
      conversations: conversations == freezed
          ? _value.conversations
          : conversations as List<ConversationByDate>,
      optins: optins == freezed ? _value.optins : optins as List<OptinsByDate>,
    ));
  }
}

/// @nodoc
abstract class _$CalendarWeekDataCopyWith<$Res>
    implements $CalendarWeekDataCopyWith<$Res> {
  factory _$CalendarWeekDataCopyWith(
          _CalendarWeekData value, $Res Function(_CalendarWeekData) then) =
      __$CalendarWeekDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool future,
      DateTime start,
      DateTime end,
      List<ConversationByDate> conversations,
      List<OptinsByDate> optins});
}

/// @nodoc
class __$CalendarWeekDataCopyWithImpl<$Res>
    extends _$CalendarWeekDataCopyWithImpl<$Res>
    implements _$CalendarWeekDataCopyWith<$Res> {
  __$CalendarWeekDataCopyWithImpl(
      _CalendarWeekData _value, $Res Function(_CalendarWeekData) _then)
      : super(_value, (v) => _then(v as _CalendarWeekData));

  @override
  _CalendarWeekData get _value => super._value as _CalendarWeekData;

  @override
  $Res call({
    Object future = freezed,
    Object start = freezed,
    Object end = freezed,
    Object conversations = freezed,
    Object optins = freezed,
  }) {
    return _then(_CalendarWeekData(
      future: future == freezed ? _value.future : future as bool,
      start: start == freezed ? _value.start : start as DateTime,
      end: end == freezed ? _value.end : end as DateTime,
      conversations: conversations == freezed
          ? _value.conversations
          : conversations as List<ConversationByDate>,
      optins: optins == freezed ? _value.optins : optins as List<OptinsByDate>,
    ));
  }
}

/// @nodoc
class _$_CalendarWeekData implements _CalendarWeekData {
  _$_CalendarWeekData(
      {this.future,
      this.start,
      this.end,
      this.conversations = const [],
      this.optins = const []})
      : assert(conversations != null),
        assert(optins != null);

  @override
  final bool future;
  @override
  final DateTime start;
  @override
  final DateTime end;
  @JsonKey(defaultValue: const [])
  @override
  final List<ConversationByDate> conversations;
  @JsonKey(defaultValue: const [])
  @override
  final List<OptinsByDate> optins;

  @override
  String toString() {
    return 'CalendarWeekData(future: $future, start: $start, end: $end, conversations: $conversations, optins: $optins)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CalendarWeekData &&
            (identical(other.future, future) ||
                const DeepCollectionEquality().equals(other.future, future)) &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.end, end) ||
                const DeepCollectionEquality().equals(other.end, end)) &&
            (identical(other.conversations, conversations) ||
                const DeepCollectionEquality()
                    .equals(other.conversations, conversations)) &&
            (identical(other.optins, optins) ||
                const DeepCollectionEquality().equals(other.optins, optins)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(future) ^
      const DeepCollectionEquality().hash(start) ^
      const DeepCollectionEquality().hash(end) ^
      const DeepCollectionEquality().hash(conversations) ^
      const DeepCollectionEquality().hash(optins);

  @JsonKey(ignore: true)
  @override
  _$CalendarWeekDataCopyWith<_CalendarWeekData> get copyWith =>
      __$CalendarWeekDataCopyWithImpl<_CalendarWeekData>(this, _$identity);
}

abstract class _CalendarWeekData implements CalendarWeekData {
  factory _CalendarWeekData(
      {bool future,
      DateTime start,
      DateTime end,
      List<ConversationByDate> conversations,
      List<OptinsByDate> optins}) = _$_CalendarWeekData;

  @override
  bool get future;
  @override
  DateTime get start;
  @override
  DateTime get end;
  @override
  List<ConversationByDate> get conversations;
  @override
  List<OptinsByDate> get optins;
  @override
  @JsonKey(ignore: true)
  _$CalendarWeekDataCopyWith<_CalendarWeekData> get copyWith;
}
