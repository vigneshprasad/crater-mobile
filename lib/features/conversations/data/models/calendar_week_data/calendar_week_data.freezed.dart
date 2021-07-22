// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'calendar_week_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$CalendarWeekDataTearOff {
  const _$CalendarWeekDataTearOff();

  _CalendarWeekData call(
      {bool? future,
      DateTime? start,
      DateTime? end,
      List<ConversationByDate> conversations = const [],
      List<OptinsByDate> optins = const [],
      List<MeetingsByDate> meetings = const []}) {
    return _CalendarWeekData(
      future: future,
      start: start,
      end: end,
      conversations: conversations,
      optins: optins,
      meetings: meetings,
    );
  }
}

/// @nodoc
const $CalendarWeekData = _$CalendarWeekDataTearOff();

/// @nodoc
mixin _$CalendarWeekData {
  bool? get future => throw _privateConstructorUsedError;
  DateTime? get start => throw _privateConstructorUsedError;
  DateTime? get end => throw _privateConstructorUsedError;
  List<ConversationByDate> get conversations =>
      throw _privateConstructorUsedError;
  List<OptinsByDate> get optins => throw _privateConstructorUsedError;
  List<MeetingsByDate> get meetings => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CalendarWeekDataCopyWith<CalendarWeekData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarWeekDataCopyWith<$Res> {
  factory $CalendarWeekDataCopyWith(
          CalendarWeekData value, $Res Function(CalendarWeekData) then) =
      _$CalendarWeekDataCopyWithImpl<$Res>;
  $Res call(
      {bool? future,
      DateTime? start,
      DateTime? end,
      List<ConversationByDate> conversations,
      List<OptinsByDate> optins,
      List<MeetingsByDate> meetings});
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
    Object? future = freezed,
    Object? start = freezed,
    Object? end = freezed,
    Object? conversations = freezed,
    Object? optins = freezed,
    Object? meetings = freezed,
  }) {
    return _then(_value.copyWith(
      future: future == freezed
          ? _value.future
          : future // ignore: cast_nullable_to_non_nullable
              as bool?,
      start: start == freezed
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      end: end == freezed
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      conversations: conversations == freezed
          ? _value.conversations
          : conversations // ignore: cast_nullable_to_non_nullable
              as List<ConversationByDate>,
      optins: optins == freezed
          ? _value.optins
          : optins // ignore: cast_nullable_to_non_nullable
              as List<OptinsByDate>,
      meetings: meetings == freezed
          ? _value.meetings
          : meetings // ignore: cast_nullable_to_non_nullable
              as List<MeetingsByDate>,
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
      {bool? future,
      DateTime? start,
      DateTime? end,
      List<ConversationByDate> conversations,
      List<OptinsByDate> optins,
      List<MeetingsByDate> meetings});
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
    Object? future = freezed,
    Object? start = freezed,
    Object? end = freezed,
    Object? conversations = freezed,
    Object? optins = freezed,
    Object? meetings = freezed,
  }) {
    return _then(_CalendarWeekData(
      future: future == freezed
          ? _value.future
          : future // ignore: cast_nullable_to_non_nullable
              as bool?,
      start: start == freezed
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      end: end == freezed
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      conversations: conversations == freezed
          ? _value.conversations
          : conversations // ignore: cast_nullable_to_non_nullable
              as List<ConversationByDate>,
      optins: optins == freezed
          ? _value.optins
          : optins // ignore: cast_nullable_to_non_nullable
              as List<OptinsByDate>,
      meetings: meetings == freezed
          ? _value.meetings
          : meetings // ignore: cast_nullable_to_non_nullable
              as List<MeetingsByDate>,
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
      this.optins = const [],
      this.meetings = const []});

  @override
  final bool? future;
  @override
  final DateTime? start;
  @override
  final DateTime? end;
  @JsonKey(defaultValue: const [])
  @override
  final List<ConversationByDate> conversations;
  @JsonKey(defaultValue: const [])
  @override
  final List<OptinsByDate> optins;
  @JsonKey(defaultValue: const [])
  @override
  final List<MeetingsByDate> meetings;

  @override
  String toString() {
    return 'CalendarWeekData(future: $future, start: $start, end: $end, conversations: $conversations, optins: $optins, meetings: $meetings)';
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
                const DeepCollectionEquality().equals(other.optins, optins)) &&
            (identical(other.meetings, meetings) ||
                const DeepCollectionEquality()
                    .equals(other.meetings, meetings)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(future) ^
      const DeepCollectionEquality().hash(start) ^
      const DeepCollectionEquality().hash(end) ^
      const DeepCollectionEquality().hash(conversations) ^
      const DeepCollectionEquality().hash(optins) ^
      const DeepCollectionEquality().hash(meetings);

  @JsonKey(ignore: true)
  @override
  _$CalendarWeekDataCopyWith<_CalendarWeekData> get copyWith =>
      __$CalendarWeekDataCopyWithImpl<_CalendarWeekData>(this, _$identity);
}

abstract class _CalendarWeekData implements CalendarWeekData {
  factory _CalendarWeekData(
      {bool? future,
      DateTime? start,
      DateTime? end,
      List<ConversationByDate> conversations,
      List<OptinsByDate> optins,
      List<MeetingsByDate> meetings}) = _$_CalendarWeekData;

  @override
  bool? get future => throw _privateConstructorUsedError;
  @override
  DateTime? get start => throw _privateConstructorUsedError;
  @override
  DateTime? get end => throw _privateConstructorUsedError;
  @override
  List<ConversationByDate> get conversations =>
      throw _privateConstructorUsedError;
  @override
  List<OptinsByDate> get optins => throw _privateConstructorUsedError;
  @override
  List<MeetingsByDate> get meetings => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CalendarWeekDataCopyWith<_CalendarWeekData> get copyWith =>
      throw _privateConstructorUsedError;
}
