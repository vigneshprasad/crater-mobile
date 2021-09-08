// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'timeslots_screen_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$TimeSlotsStateTearOff {
  const _$TimeSlotsStateTearOff();

  _TimeSlotsStateLoading loading() {
    return _TimeSlotsStateLoading();
  }

  _TimeSlotsStateData data(List<TimeSlot> timeslots) {
    return _TimeSlotsStateData(
      timeslots,
    );
  }

  _TimeSlotsStateError error(Failure error, [StackTrace? stackTrace]) {
    return _TimeSlotsStateError(
      error,
      stackTrace,
    );
  }
}

/// @nodoc
const $TimeSlotsState = _$TimeSlotsStateTearOff();

/// @nodoc
mixin _$TimeSlotsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<TimeSlot> timeslots) data,
    required TResult Function(Failure error, StackTrace? stackTrace) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<TimeSlot> timeslots)? data,
    TResult Function(Failure error, StackTrace? stackTrace)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TimeSlotsStateLoading value) loading,
    required TResult Function(_TimeSlotsStateData value) data,
    required TResult Function(_TimeSlotsStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TimeSlotsStateLoading value)? loading,
    TResult Function(_TimeSlotsStateData value)? data,
    TResult Function(_TimeSlotsStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeSlotsStateCopyWith<$Res> {
  factory $TimeSlotsStateCopyWith(
          TimeSlotsState value, $Res Function(TimeSlotsState) then) =
      _$TimeSlotsStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$TimeSlotsStateCopyWithImpl<$Res>
    implements $TimeSlotsStateCopyWith<$Res> {
  _$TimeSlotsStateCopyWithImpl(this._value, this._then);

  final TimeSlotsState _value;
  // ignore: unused_field
  final $Res Function(TimeSlotsState) _then;
}

/// @nodoc
abstract class _$TimeSlotsStateLoadingCopyWith<$Res> {
  factory _$TimeSlotsStateLoadingCopyWith(_TimeSlotsStateLoading value,
          $Res Function(_TimeSlotsStateLoading) then) =
      __$TimeSlotsStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$TimeSlotsStateLoadingCopyWithImpl<$Res>
    extends _$TimeSlotsStateCopyWithImpl<$Res>
    implements _$TimeSlotsStateLoadingCopyWith<$Res> {
  __$TimeSlotsStateLoadingCopyWithImpl(_TimeSlotsStateLoading _value,
      $Res Function(_TimeSlotsStateLoading) _then)
      : super(_value, (v) => _then(v as _TimeSlotsStateLoading));

  @override
  _TimeSlotsStateLoading get _value => super._value as _TimeSlotsStateLoading;
}

/// @nodoc

class _$_TimeSlotsStateLoading implements _TimeSlotsStateLoading {
  _$_TimeSlotsStateLoading();

  @override
  String toString() {
    return 'TimeSlotsState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _TimeSlotsStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<TimeSlot> timeslots) data,
    required TResult Function(Failure error, StackTrace? stackTrace) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<TimeSlot> timeslots)? data,
    TResult Function(Failure error, StackTrace? stackTrace)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TimeSlotsStateLoading value) loading,
    required TResult Function(_TimeSlotsStateData value) data,
    required TResult Function(_TimeSlotsStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TimeSlotsStateLoading value)? loading,
    TResult Function(_TimeSlotsStateData value)? data,
    TResult Function(_TimeSlotsStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _TimeSlotsStateLoading implements TimeSlotsState {
  factory _TimeSlotsStateLoading() = _$_TimeSlotsStateLoading;
}

/// @nodoc
abstract class _$TimeSlotsStateDataCopyWith<$Res> {
  factory _$TimeSlotsStateDataCopyWith(
          _TimeSlotsStateData value, $Res Function(_TimeSlotsStateData) then) =
      __$TimeSlotsStateDataCopyWithImpl<$Res>;
  $Res call({List<TimeSlot> timeslots});
}

/// @nodoc
class __$TimeSlotsStateDataCopyWithImpl<$Res>
    extends _$TimeSlotsStateCopyWithImpl<$Res>
    implements _$TimeSlotsStateDataCopyWith<$Res> {
  __$TimeSlotsStateDataCopyWithImpl(
      _TimeSlotsStateData _value, $Res Function(_TimeSlotsStateData) _then)
      : super(_value, (v) => _then(v as _TimeSlotsStateData));

  @override
  _TimeSlotsStateData get _value => super._value as _TimeSlotsStateData;

  @override
  $Res call({
    Object? timeslots = freezed,
  }) {
    return _then(_TimeSlotsStateData(
      timeslots == freezed
          ? _value.timeslots
          : timeslots // ignore: cast_nullable_to_non_nullable
              as List<TimeSlot>,
    ));
  }
}

/// @nodoc

class _$_TimeSlotsStateData implements _TimeSlotsStateData {
  _$_TimeSlotsStateData(this.timeslots);

  @override
  final List<TimeSlot> timeslots;

  @override
  String toString() {
    return 'TimeSlotsState.data(timeslots: $timeslots)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _TimeSlotsStateData &&
            (identical(other.timeslots, timeslots) ||
                const DeepCollectionEquality()
                    .equals(other.timeslots, timeslots)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(timeslots);

  @JsonKey(ignore: true)
  @override
  _$TimeSlotsStateDataCopyWith<_TimeSlotsStateData> get copyWith =>
      __$TimeSlotsStateDataCopyWithImpl<_TimeSlotsStateData>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<TimeSlot> timeslots) data,
    required TResult Function(Failure error, StackTrace? stackTrace) error,
  }) {
    return data(timeslots);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<TimeSlot> timeslots)? data,
    TResult Function(Failure error, StackTrace? stackTrace)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(timeslots);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TimeSlotsStateLoading value) loading,
    required TResult Function(_TimeSlotsStateData value) data,
    required TResult Function(_TimeSlotsStateError value) error,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TimeSlotsStateLoading value)? loading,
    TResult Function(_TimeSlotsStateData value)? data,
    TResult Function(_TimeSlotsStateError value)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _TimeSlotsStateData implements TimeSlotsState {
  factory _TimeSlotsStateData(List<TimeSlot> timeslots) = _$_TimeSlotsStateData;

  List<TimeSlot> get timeslots => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$TimeSlotsStateDataCopyWith<_TimeSlotsStateData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$TimeSlotsStateErrorCopyWith<$Res> {
  factory _$TimeSlotsStateErrorCopyWith(_TimeSlotsStateError value,
          $Res Function(_TimeSlotsStateError) then) =
      __$TimeSlotsStateErrorCopyWithImpl<$Res>;
  $Res call({Failure error, StackTrace? stackTrace});
}

/// @nodoc
class __$TimeSlotsStateErrorCopyWithImpl<$Res>
    extends _$TimeSlotsStateCopyWithImpl<$Res>
    implements _$TimeSlotsStateErrorCopyWith<$Res> {
  __$TimeSlotsStateErrorCopyWithImpl(
      _TimeSlotsStateError _value, $Res Function(_TimeSlotsStateError) _then)
      : super(_value, (v) => _then(v as _TimeSlotsStateError));

  @override
  _TimeSlotsStateError get _value => super._value as _TimeSlotsStateError;

  @override
  $Res call({
    Object? error = freezed,
    Object? stackTrace = freezed,
  }) {
    return _then(_TimeSlotsStateError(
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Failure,
      stackTrace == freezed
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ));
  }
}

/// @nodoc

class _$_TimeSlotsStateError implements _TimeSlotsStateError {
  _$_TimeSlotsStateError(this.error, [this.stackTrace]);

  @override
  final Failure error;
  @override
  final StackTrace? stackTrace;

  @override
  String toString() {
    return 'TimeSlotsState.error(error: $error, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _TimeSlotsStateError &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)) &&
            (identical(other.stackTrace, stackTrace) ||
                const DeepCollectionEquality()
                    .equals(other.stackTrace, stackTrace)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(error) ^
      const DeepCollectionEquality().hash(stackTrace);

  @JsonKey(ignore: true)
  @override
  _$TimeSlotsStateErrorCopyWith<_TimeSlotsStateError> get copyWith =>
      __$TimeSlotsStateErrorCopyWithImpl<_TimeSlotsStateError>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<TimeSlot> timeslots) data,
    required TResult Function(Failure error, StackTrace? stackTrace) error,
  }) {
    return error(this.error, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<TimeSlot> timeslots)? data,
    TResult Function(Failure error, StackTrace? stackTrace)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error, stackTrace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TimeSlotsStateLoading value) loading,
    required TResult Function(_TimeSlotsStateData value) data,
    required TResult Function(_TimeSlotsStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TimeSlotsStateLoading value)? loading,
    TResult Function(_TimeSlotsStateData value)? data,
    TResult Function(_TimeSlotsStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _TimeSlotsStateError implements TimeSlotsState {
  factory _TimeSlotsStateError(Failure error, [StackTrace? stackTrace]) =
      _$_TimeSlotsStateError;

  Failure get error => throw _privateConstructorUsedError;
  StackTrace? get stackTrace => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$TimeSlotsStateErrorCopyWith<_TimeSlotsStateError> get copyWith =>
      throw _privateConstructorUsedError;
}
