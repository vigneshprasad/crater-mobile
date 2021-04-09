// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'create_conversation_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$TableMetaStateTearOff {
  const _$TableMetaStateTearOff();

// ignore: unused_element
  _TableMetaStateLoading loading() {
    return _TableMetaStateLoading();
  }

// ignore: unused_element
  _TableMetaStateData data(CreateTableMeta meta) {
    return _TableMetaStateData(
      meta,
    );
  }

// ignore: unused_element
  _TableMetaStateError error(Failure error, [StackTrace stackTrace]) {
    return _TableMetaStateError(
      error,
      stackTrace,
    );
  }

// ignore: unused_element
  _TableMetaStateNoConfig emptyConfig() {
    return _TableMetaStateNoConfig();
  }
}

/// @nodoc
// ignore: unused_element
const $TableMetaState = _$TableMetaStateTearOff();

/// @nodoc
mixin _$TableMetaState {
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult loading(),
    @required TResult data(CreateTableMeta meta),
    @required TResult error(Failure error, StackTrace stackTrace),
    @required TResult emptyConfig(),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult loading(),
    TResult data(CreateTableMeta meta),
    TResult error(Failure error, StackTrace stackTrace),
    TResult emptyConfig(),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult loading(_TableMetaStateLoading value),
    @required TResult data(_TableMetaStateData value),
    @required TResult error(_TableMetaStateError value),
    @required TResult emptyConfig(_TableMetaStateNoConfig value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult loading(_TableMetaStateLoading value),
    TResult data(_TableMetaStateData value),
    TResult error(_TableMetaStateError value),
    TResult emptyConfig(_TableMetaStateNoConfig value),
    @required TResult orElse(),
  });
}

/// @nodoc
abstract class $TableMetaStateCopyWith<$Res> {
  factory $TableMetaStateCopyWith(
          TableMetaState value, $Res Function(TableMetaState) then) =
      _$TableMetaStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$TableMetaStateCopyWithImpl<$Res>
    implements $TableMetaStateCopyWith<$Res> {
  _$TableMetaStateCopyWithImpl(this._value, this._then);

  final TableMetaState _value;
  // ignore: unused_field
  final $Res Function(TableMetaState) _then;
}

/// @nodoc
abstract class _$TableMetaStateLoadingCopyWith<$Res> {
  factory _$TableMetaStateLoadingCopyWith(_TableMetaStateLoading value,
          $Res Function(_TableMetaStateLoading) then) =
      __$TableMetaStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$TableMetaStateLoadingCopyWithImpl<$Res>
    extends _$TableMetaStateCopyWithImpl<$Res>
    implements _$TableMetaStateLoadingCopyWith<$Res> {
  __$TableMetaStateLoadingCopyWithImpl(_TableMetaStateLoading _value,
      $Res Function(_TableMetaStateLoading) _then)
      : super(_value, (v) => _then(v as _TableMetaStateLoading));

  @override
  _TableMetaStateLoading get _value => super._value as _TableMetaStateLoading;
}

/// @nodoc
class _$_TableMetaStateLoading implements _TableMetaStateLoading {
  _$_TableMetaStateLoading();

  @override
  String toString() {
    return 'TableMetaState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _TableMetaStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult loading(),
    @required TResult data(CreateTableMeta meta),
    @required TResult error(Failure error, StackTrace stackTrace),
    @required TResult emptyConfig(),
  }) {
    assert(loading != null);
    assert(data != null);
    assert(error != null);
    assert(emptyConfig != null);
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult loading(),
    TResult data(CreateTableMeta meta),
    TResult error(Failure error, StackTrace stackTrace),
    TResult emptyConfig(),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult loading(_TableMetaStateLoading value),
    @required TResult data(_TableMetaStateData value),
    @required TResult error(_TableMetaStateError value),
    @required TResult emptyConfig(_TableMetaStateNoConfig value),
  }) {
    assert(loading != null);
    assert(data != null);
    assert(error != null);
    assert(emptyConfig != null);
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult loading(_TableMetaStateLoading value),
    TResult data(_TableMetaStateData value),
    TResult error(_TableMetaStateError value),
    TResult emptyConfig(_TableMetaStateNoConfig value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _TableMetaStateLoading implements TableMetaState {
  factory _TableMetaStateLoading() = _$_TableMetaStateLoading;
}

/// @nodoc
abstract class _$TableMetaStateDataCopyWith<$Res> {
  factory _$TableMetaStateDataCopyWith(
          _TableMetaStateData value, $Res Function(_TableMetaStateData) then) =
      __$TableMetaStateDataCopyWithImpl<$Res>;
  $Res call({CreateTableMeta meta});

  $CreateTableMetaCopyWith<$Res> get meta;
}

/// @nodoc
class __$TableMetaStateDataCopyWithImpl<$Res>
    extends _$TableMetaStateCopyWithImpl<$Res>
    implements _$TableMetaStateDataCopyWith<$Res> {
  __$TableMetaStateDataCopyWithImpl(
      _TableMetaStateData _value, $Res Function(_TableMetaStateData) _then)
      : super(_value, (v) => _then(v as _TableMetaStateData));

  @override
  _TableMetaStateData get _value => super._value as _TableMetaStateData;

  @override
  $Res call({
    Object meta = freezed,
  }) {
    return _then(_TableMetaStateData(
      meta == freezed ? _value.meta : meta as CreateTableMeta,
    ));
  }

  @override
  $CreateTableMetaCopyWith<$Res> get meta {
    if (_value.meta == null) {
      return null;
    }
    return $CreateTableMetaCopyWith<$Res>(_value.meta, (value) {
      return _then(_value.copyWith(meta: value));
    });
  }
}

/// @nodoc
class _$_TableMetaStateData implements _TableMetaStateData {
  _$_TableMetaStateData(this.meta) : assert(meta != null);

  @override
  final CreateTableMeta meta;

  @override
  String toString() {
    return 'TableMetaState.data(meta: $meta)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _TableMetaStateData &&
            (identical(other.meta, meta) ||
                const DeepCollectionEquality().equals(other.meta, meta)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(meta);

  @JsonKey(ignore: true)
  @override
  _$TableMetaStateDataCopyWith<_TableMetaStateData> get copyWith =>
      __$TableMetaStateDataCopyWithImpl<_TableMetaStateData>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult loading(),
    @required TResult data(CreateTableMeta meta),
    @required TResult error(Failure error, StackTrace stackTrace),
    @required TResult emptyConfig(),
  }) {
    assert(loading != null);
    assert(data != null);
    assert(error != null);
    assert(emptyConfig != null);
    return data(meta);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult loading(),
    TResult data(CreateTableMeta meta),
    TResult error(Failure error, StackTrace stackTrace),
    TResult emptyConfig(),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (data != null) {
      return data(meta);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult loading(_TableMetaStateLoading value),
    @required TResult data(_TableMetaStateData value),
    @required TResult error(_TableMetaStateError value),
    @required TResult emptyConfig(_TableMetaStateNoConfig value),
  }) {
    assert(loading != null);
    assert(data != null);
    assert(error != null);
    assert(emptyConfig != null);
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult loading(_TableMetaStateLoading value),
    TResult data(_TableMetaStateData value),
    TResult error(_TableMetaStateError value),
    TResult emptyConfig(_TableMetaStateNoConfig value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _TableMetaStateData implements TableMetaState {
  factory _TableMetaStateData(CreateTableMeta meta) = _$_TableMetaStateData;

  CreateTableMeta get meta;
  @JsonKey(ignore: true)
  _$TableMetaStateDataCopyWith<_TableMetaStateData> get copyWith;
}

/// @nodoc
abstract class _$TableMetaStateErrorCopyWith<$Res> {
  factory _$TableMetaStateErrorCopyWith(_TableMetaStateError value,
          $Res Function(_TableMetaStateError) then) =
      __$TableMetaStateErrorCopyWithImpl<$Res>;
  $Res call({Failure error, StackTrace stackTrace});
}

/// @nodoc
class __$TableMetaStateErrorCopyWithImpl<$Res>
    extends _$TableMetaStateCopyWithImpl<$Res>
    implements _$TableMetaStateErrorCopyWith<$Res> {
  __$TableMetaStateErrorCopyWithImpl(
      _TableMetaStateError _value, $Res Function(_TableMetaStateError) _then)
      : super(_value, (v) => _then(v as _TableMetaStateError));

  @override
  _TableMetaStateError get _value => super._value as _TableMetaStateError;

  @override
  $Res call({
    Object error = freezed,
    Object stackTrace = freezed,
  }) {
    return _then(_TableMetaStateError(
      error == freezed ? _value.error : error as Failure,
      stackTrace == freezed ? _value.stackTrace : stackTrace as StackTrace,
    ));
  }
}

/// @nodoc
class _$_TableMetaStateError implements _TableMetaStateError {
  _$_TableMetaStateError(this.error, [this.stackTrace]) : assert(error != null);

  @override
  final Failure error;
  @override
  final StackTrace stackTrace;

  @override
  String toString() {
    return 'TableMetaState.error(error: $error, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _TableMetaStateError &&
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
  _$TableMetaStateErrorCopyWith<_TableMetaStateError> get copyWith =>
      __$TableMetaStateErrorCopyWithImpl<_TableMetaStateError>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult loading(),
    @required TResult data(CreateTableMeta meta),
    @required TResult error(Failure error, StackTrace stackTrace),
    @required TResult emptyConfig(),
  }) {
    assert(loading != null);
    assert(data != null);
    assert(error != null);
    assert(emptyConfig != null);
    return error(this.error, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult loading(),
    TResult data(CreateTableMeta meta),
    TResult error(Failure error, StackTrace stackTrace),
    TResult emptyConfig(),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(this.error, stackTrace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult loading(_TableMetaStateLoading value),
    @required TResult data(_TableMetaStateData value),
    @required TResult error(_TableMetaStateError value),
    @required TResult emptyConfig(_TableMetaStateNoConfig value),
  }) {
    assert(loading != null);
    assert(data != null);
    assert(error != null);
    assert(emptyConfig != null);
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult loading(_TableMetaStateLoading value),
    TResult data(_TableMetaStateData value),
    TResult error(_TableMetaStateError value),
    TResult emptyConfig(_TableMetaStateNoConfig value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _TableMetaStateError implements TableMetaState {
  factory _TableMetaStateError(Failure error, [StackTrace stackTrace]) =
      _$_TableMetaStateError;

  Failure get error;
  StackTrace get stackTrace;
  @JsonKey(ignore: true)
  _$TableMetaStateErrorCopyWith<_TableMetaStateError> get copyWith;
}

/// @nodoc
abstract class _$TableMetaStateNoConfigCopyWith<$Res> {
  factory _$TableMetaStateNoConfigCopyWith(_TableMetaStateNoConfig value,
          $Res Function(_TableMetaStateNoConfig) then) =
      __$TableMetaStateNoConfigCopyWithImpl<$Res>;
}

/// @nodoc
class __$TableMetaStateNoConfigCopyWithImpl<$Res>
    extends _$TableMetaStateCopyWithImpl<$Res>
    implements _$TableMetaStateNoConfigCopyWith<$Res> {
  __$TableMetaStateNoConfigCopyWithImpl(_TableMetaStateNoConfig _value,
      $Res Function(_TableMetaStateNoConfig) _then)
      : super(_value, (v) => _then(v as _TableMetaStateNoConfig));

  @override
  _TableMetaStateNoConfig get _value => super._value as _TableMetaStateNoConfig;
}

/// @nodoc
class _$_TableMetaStateNoConfig implements _TableMetaStateNoConfig {
  _$_TableMetaStateNoConfig();

  @override
  String toString() {
    return 'TableMetaState.emptyConfig()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _TableMetaStateNoConfig);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult loading(),
    @required TResult data(CreateTableMeta meta),
    @required TResult error(Failure error, StackTrace stackTrace),
    @required TResult emptyConfig(),
  }) {
    assert(loading != null);
    assert(data != null);
    assert(error != null);
    assert(emptyConfig != null);
    return emptyConfig();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult loading(),
    TResult data(CreateTableMeta meta),
    TResult error(Failure error, StackTrace stackTrace),
    TResult emptyConfig(),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (emptyConfig != null) {
      return emptyConfig();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult loading(_TableMetaStateLoading value),
    @required TResult data(_TableMetaStateData value),
    @required TResult error(_TableMetaStateError value),
    @required TResult emptyConfig(_TableMetaStateNoConfig value),
  }) {
    assert(loading != null);
    assert(data != null);
    assert(error != null);
    assert(emptyConfig != null);
    return emptyConfig(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult loading(_TableMetaStateLoading value),
    TResult data(_TableMetaStateData value),
    TResult error(_TableMetaStateError value),
    TResult emptyConfig(_TableMetaStateNoConfig value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (emptyConfig != null) {
      return emptyConfig(this);
    }
    return orElse();
  }
}

abstract class _TableMetaStateNoConfig implements TableMetaState {
  factory _TableMetaStateNoConfig() = _$_TableMetaStateNoConfig;
}
