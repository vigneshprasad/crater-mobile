// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'create_conversation_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$TableMetaStateTearOff {
  const _$TableMetaStateTearOff();

  _TableMetaStateLoading loading() {
    return _TableMetaStateLoading();
  }

  _TableMetaStateData data(CreateTableMeta meta) {
    return _TableMetaStateData(
      meta,
    );
  }

  _TableMetaStateError error(Failure error, [StackTrace? stackTrace]) {
    return _TableMetaStateError(
      error,
      stackTrace,
    );
  }

  _TableMetaStateNoConfig emptyConfig() {
    return _TableMetaStateNoConfig();
  }
}

/// @nodoc
const $TableMetaState = _$TableMetaStateTearOff();

/// @nodoc
mixin _$TableMetaState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(CreateTableMeta meta) data,
    required TResult Function(Failure error, StackTrace? stackTrace) error,
    required TResult Function() emptyConfig,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(CreateTableMeta meta)? data,
    TResult Function(Failure error, StackTrace? stackTrace)? error,
    TResult Function()? emptyConfig,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TableMetaStateLoading value) loading,
    required TResult Function(_TableMetaStateData value) data,
    required TResult Function(_TableMetaStateError value) error,
    required TResult Function(_TableMetaStateNoConfig value) emptyConfig,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TableMetaStateLoading value)? loading,
    TResult Function(_TableMetaStateData value)? data,
    TResult Function(_TableMetaStateError value)? error,
    TResult Function(_TableMetaStateNoConfig value)? emptyConfig,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
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
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(CreateTableMeta meta) data,
    required TResult Function(Failure error, StackTrace? stackTrace) error,
    required TResult Function() emptyConfig,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(CreateTableMeta meta)? data,
    TResult Function(Failure error, StackTrace? stackTrace)? error,
    TResult Function()? emptyConfig,
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
    required TResult Function(_TableMetaStateLoading value) loading,
    required TResult Function(_TableMetaStateData value) data,
    required TResult Function(_TableMetaStateError value) error,
    required TResult Function(_TableMetaStateNoConfig value) emptyConfig,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TableMetaStateLoading value)? loading,
    TResult Function(_TableMetaStateData value)? data,
    TResult Function(_TableMetaStateError value)? error,
    TResult Function(_TableMetaStateNoConfig value)? emptyConfig,
    required TResult orElse(),
  }) {
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
    Object? meta = freezed,
  }) {
    return _then(_TableMetaStateData(
      meta == freezed
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as CreateTableMeta,
    ));
  }

  @override
  $CreateTableMetaCopyWith<$Res> get meta {
    return $CreateTableMetaCopyWith<$Res>(_value.meta, (value) {
      return _then(_value.copyWith(meta: value));
    });
  }
}

/// @nodoc

class _$_TableMetaStateData implements _TableMetaStateData {
  _$_TableMetaStateData(this.meta);

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
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(CreateTableMeta meta) data,
    required TResult Function(Failure error, StackTrace? stackTrace) error,
    required TResult Function() emptyConfig,
  }) {
    return data(meta);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(CreateTableMeta meta)? data,
    TResult Function(Failure error, StackTrace? stackTrace)? error,
    TResult Function()? emptyConfig,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(meta);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TableMetaStateLoading value) loading,
    required TResult Function(_TableMetaStateData value) data,
    required TResult Function(_TableMetaStateError value) error,
    required TResult Function(_TableMetaStateNoConfig value) emptyConfig,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TableMetaStateLoading value)? loading,
    TResult Function(_TableMetaStateData value)? data,
    TResult Function(_TableMetaStateError value)? error,
    TResult Function(_TableMetaStateNoConfig value)? emptyConfig,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _TableMetaStateData implements TableMetaState {
  factory _TableMetaStateData(CreateTableMeta meta) = _$_TableMetaStateData;

  CreateTableMeta get meta => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$TableMetaStateDataCopyWith<_TableMetaStateData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$TableMetaStateErrorCopyWith<$Res> {
  factory _$TableMetaStateErrorCopyWith(_TableMetaStateError value,
          $Res Function(_TableMetaStateError) then) =
      __$TableMetaStateErrorCopyWithImpl<$Res>;
  $Res call({Failure error, StackTrace? stackTrace});
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
    Object? error = freezed,
    Object? stackTrace = freezed,
  }) {
    return _then(_TableMetaStateError(
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

class _$_TableMetaStateError implements _TableMetaStateError {
  _$_TableMetaStateError(this.error, [this.stackTrace]);

  @override
  final Failure error;
  @override
  final StackTrace? stackTrace;

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
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(CreateTableMeta meta) data,
    required TResult Function(Failure error, StackTrace? stackTrace) error,
    required TResult Function() emptyConfig,
  }) {
    return error(this.error, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(CreateTableMeta meta)? data,
    TResult Function(Failure error, StackTrace? stackTrace)? error,
    TResult Function()? emptyConfig,
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
    required TResult Function(_TableMetaStateLoading value) loading,
    required TResult Function(_TableMetaStateData value) data,
    required TResult Function(_TableMetaStateError value) error,
    required TResult Function(_TableMetaStateNoConfig value) emptyConfig,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TableMetaStateLoading value)? loading,
    TResult Function(_TableMetaStateData value)? data,
    TResult Function(_TableMetaStateError value)? error,
    TResult Function(_TableMetaStateNoConfig value)? emptyConfig,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _TableMetaStateError implements TableMetaState {
  factory _TableMetaStateError(Failure error, [StackTrace? stackTrace]) =
      _$_TableMetaStateError;

  Failure get error => throw _privateConstructorUsedError;
  StackTrace? get stackTrace => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$TableMetaStateErrorCopyWith<_TableMetaStateError> get copyWith =>
      throw _privateConstructorUsedError;
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
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(CreateTableMeta meta) data,
    required TResult Function(Failure error, StackTrace? stackTrace) error,
    required TResult Function() emptyConfig,
  }) {
    return emptyConfig();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(CreateTableMeta meta)? data,
    TResult Function(Failure error, StackTrace? stackTrace)? error,
    TResult Function()? emptyConfig,
    required TResult orElse(),
  }) {
    if (emptyConfig != null) {
      return emptyConfig();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TableMetaStateLoading value) loading,
    required TResult Function(_TableMetaStateData value) data,
    required TResult Function(_TableMetaStateError value) error,
    required TResult Function(_TableMetaStateNoConfig value) emptyConfig,
  }) {
    return emptyConfig(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TableMetaStateLoading value)? loading,
    TResult Function(_TableMetaStateData value)? data,
    TResult Function(_TableMetaStateError value)? error,
    TResult Function(_TableMetaStateNoConfig value)? emptyConfig,
    required TResult orElse(),
  }) {
    if (emptyConfig != null) {
      return emptyConfig(this);
    }
    return orElse();
  }
}

abstract class _TableMetaStateNoConfig implements TableMetaState {
  factory _TableMetaStateNoConfig() = _$_TableMetaStateNoConfig;
}
