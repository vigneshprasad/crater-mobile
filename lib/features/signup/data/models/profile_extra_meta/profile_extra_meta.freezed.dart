// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'profile_extra_meta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Option _$OptionFromJson(Map<String, dynamic> json) {
  return _Option.fromJson(json);
}

/// @nodoc
mixin _$Option {
  String get name => throw _privateConstructorUsedError;
  int get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OptionCopyWith<Option> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OptionCopyWith<$Res> {
  factory $OptionCopyWith(Option value, $Res Function(Option) then) =
      _$OptionCopyWithImpl<$Res>;
  $Res call({String name, int value});
}

/// @nodoc
class _$OptionCopyWithImpl<$Res> implements $OptionCopyWith<$Res> {
  _$OptionCopyWithImpl(this._value, this._then);

  final Option _value;
  // ignore: unused_field
  final $Res Function(Option) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_OptionCopyWith<$Res> implements $OptionCopyWith<$Res> {
  factory _$$_OptionCopyWith(_$_Option value, $Res Function(_$_Option) then) =
      __$$_OptionCopyWithImpl<$Res>;
  @override
  $Res call({String name, int value});
}

/// @nodoc
class __$$_OptionCopyWithImpl<$Res> extends _$OptionCopyWithImpl<$Res>
    implements _$$_OptionCopyWith<$Res> {
  __$$_OptionCopyWithImpl(_$_Option _value, $Res Function(_$_Option) _then)
      : super(_value, (v) => _then(v as _$_Option));

  @override
  _$_Option get _value => super._value as _$_Option;

  @override
  $Res call({
    Object? name = freezed,
    Object? value = freezed,
  }) {
    return _then(_$_Option(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Option implements _Option {
  _$_Option({required this.name, required this.value});

  factory _$_Option.fromJson(Map<String, dynamic> json) =>
      _$$_OptionFromJson(json);

  @override
  final String name;
  @override
  final int value;

  @override
  String toString() {
    return 'Option(name: $name, value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Option &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(value));

  @JsonKey(ignore: true)
  @override
  _$$_OptionCopyWith<_$_Option> get copyWith =>
      __$$_OptionCopyWithImpl<_$_Option>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OptionToJson(this);
  }
}

abstract class _Option implements Option {
  factory _Option({required final String name, required final int value}) =
      _$_Option;

  factory _Option.fromJson(Map<String, dynamic> json) = _$_Option.fromJson;

  @override
  String get name;
  @override
  int get value;
  @override
  @JsonKey(ignore: true)
  _$$_OptionCopyWith<_$_Option> get copyWith =>
      throw _privateConstructorUsedError;
}

FormFieldData _$FormFieldDataFromJson(Map<String, dynamic> json) {
  return _FormFieldData.fromJson(json);
}

/// @nodoc
mixin _$FormFieldData {
  FieldType get type => throw _privateConstructorUsedError;
  List<Option>? get options => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  bool get blank => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FormFieldDataCopyWith<FormFieldData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FormFieldDataCopyWith<$Res> {
  factory $FormFieldDataCopyWith(
          FormFieldData value, $Res Function(FormFieldData) then) =
      _$FormFieldDataCopyWithImpl<$Res>;
  $Res call({FieldType type, List<Option>? options, String label, bool blank});
}

/// @nodoc
class _$FormFieldDataCopyWithImpl<$Res>
    implements $FormFieldDataCopyWith<$Res> {
  _$FormFieldDataCopyWithImpl(this._value, this._then);

  final FormFieldData _value;
  // ignore: unused_field
  final $Res Function(FormFieldData) _then;

  @override
  $Res call({
    Object? type = freezed,
    Object? options = freezed,
    Object? label = freezed,
    Object? blank = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as FieldType,
      options: options == freezed
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<Option>?,
      label: label == freezed
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      blank: blank == freezed
          ? _value.blank
          : blank // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_FormFieldDataCopyWith<$Res>
    implements $FormFieldDataCopyWith<$Res> {
  factory _$$_FormFieldDataCopyWith(
          _$_FormFieldData value, $Res Function(_$_FormFieldData) then) =
      __$$_FormFieldDataCopyWithImpl<$Res>;
  @override
  $Res call({FieldType type, List<Option>? options, String label, bool blank});
}

/// @nodoc
class __$$_FormFieldDataCopyWithImpl<$Res>
    extends _$FormFieldDataCopyWithImpl<$Res>
    implements _$$_FormFieldDataCopyWith<$Res> {
  __$$_FormFieldDataCopyWithImpl(
      _$_FormFieldData _value, $Res Function(_$_FormFieldData) _then)
      : super(_value, (v) => _then(v as _$_FormFieldData));

  @override
  _$_FormFieldData get _value => super._value as _$_FormFieldData;

  @override
  $Res call({
    Object? type = freezed,
    Object? options = freezed,
    Object? label = freezed,
    Object? blank = freezed,
  }) {
    return _then(_$_FormFieldData(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as FieldType,
      options: options == freezed
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<Option>?,
      label: label == freezed
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      blank: blank == freezed
          ? _value.blank
          : blank // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FormFieldData implements _FormFieldData {
  _$_FormFieldData(
      {required this.type,
      final List<Option>? options,
      required this.label,
      required this.blank})
      : _options = options;

  factory _$_FormFieldData.fromJson(Map<String, dynamic> json) =>
      _$$_FormFieldDataFromJson(json);

  @override
  final FieldType type;
  final List<Option>? _options;
  @override
  List<Option>? get options {
    final value = _options;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String label;
  @override
  final bool blank;

  @override
  String toString() {
    return 'FormFieldData(type: $type, options: $options, label: $label, blank: $blank)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FormFieldData &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            const DeepCollectionEquality().equals(other.label, label) &&
            const DeepCollectionEquality().equals(other.blank, blank));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(_options),
      const DeepCollectionEquality().hash(label),
      const DeepCollectionEquality().hash(blank));

  @JsonKey(ignore: true)
  @override
  _$$_FormFieldDataCopyWith<_$_FormFieldData> get copyWith =>
      __$$_FormFieldDataCopyWithImpl<_$_FormFieldData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FormFieldDataToJson(this);
  }
}

abstract class _FormFieldData implements FormFieldData {
  factory _FormFieldData(
      {required final FieldType type,
      final List<Option>? options,
      required final String label,
      required final bool blank}) = _$_FormFieldData;

  factory _FormFieldData.fromJson(Map<String, dynamic> json) =
      _$_FormFieldData.fromJson;

  @override
  FieldType get type;
  @override
  List<Option>? get options;
  @override
  String get label;
  @override
  bool get blank;
  @override
  @JsonKey(ignore: true)
  _$$_FormFieldDataCopyWith<_$_FormFieldData> get copyWith =>
      throw _privateConstructorUsedError;
}

ProfileExtraMeta _$ProfileExtraMetaFromJson(Map<String, dynamic> json) {
  return _ProfileExtraMeta.fromJson(json);
}

/// @nodoc
mixin _$ProfileExtraMeta {
  String get question => throw _privateConstructorUsedError;
  Map<String, FormFieldData> get meta => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProfileExtraMetaCopyWith<ProfileExtraMeta> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileExtraMetaCopyWith<$Res> {
  factory $ProfileExtraMetaCopyWith(
          ProfileExtraMeta value, $Res Function(ProfileExtraMeta) then) =
      _$ProfileExtraMetaCopyWithImpl<$Res>;
  $Res call({String question, Map<String, FormFieldData> meta});
}

/// @nodoc
class _$ProfileExtraMetaCopyWithImpl<$Res>
    implements $ProfileExtraMetaCopyWith<$Res> {
  _$ProfileExtraMetaCopyWithImpl(this._value, this._then);

  final ProfileExtraMeta _value;
  // ignore: unused_field
  final $Res Function(ProfileExtraMeta) _then;

  @override
  $Res call({
    Object? question = freezed,
    Object? meta = freezed,
  }) {
    return _then(_value.copyWith(
      question: question == freezed
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      meta: meta == freezed
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as Map<String, FormFieldData>,
    ));
  }
}

/// @nodoc
abstract class _$$_ProfileExtraMetaCopyWith<$Res>
    implements $ProfileExtraMetaCopyWith<$Res> {
  factory _$$_ProfileExtraMetaCopyWith(
          _$_ProfileExtraMeta value, $Res Function(_$_ProfileExtraMeta) then) =
      __$$_ProfileExtraMetaCopyWithImpl<$Res>;
  @override
  $Res call({String question, Map<String, FormFieldData> meta});
}

/// @nodoc
class __$$_ProfileExtraMetaCopyWithImpl<$Res>
    extends _$ProfileExtraMetaCopyWithImpl<$Res>
    implements _$$_ProfileExtraMetaCopyWith<$Res> {
  __$$_ProfileExtraMetaCopyWithImpl(
      _$_ProfileExtraMeta _value, $Res Function(_$_ProfileExtraMeta) _then)
      : super(_value, (v) => _then(v as _$_ProfileExtraMeta));

  @override
  _$_ProfileExtraMeta get _value => super._value as _$_ProfileExtraMeta;

  @override
  $Res call({
    Object? question = freezed,
    Object? meta = freezed,
  }) {
    return _then(_$_ProfileExtraMeta(
      question: question == freezed
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      meta: meta == freezed
          ? _value._meta
          : meta // ignore: cast_nullable_to_non_nullable
              as Map<String, FormFieldData>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ProfileExtraMeta implements _ProfileExtraMeta {
  _$_ProfileExtraMeta(
      {required this.question, required final Map<String, FormFieldData> meta})
      : _meta = meta;

  factory _$_ProfileExtraMeta.fromJson(Map<String, dynamic> json) =>
      _$$_ProfileExtraMetaFromJson(json);

  @override
  final String question;
  final Map<String, FormFieldData> _meta;
  @override
  Map<String, FormFieldData> get meta {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_meta);
  }

  @override
  String toString() {
    return 'ProfileExtraMeta(question: $question, meta: $meta)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProfileExtraMeta &&
            const DeepCollectionEquality().equals(other.question, question) &&
            const DeepCollectionEquality().equals(other._meta, _meta));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(question),
      const DeepCollectionEquality().hash(_meta));

  @JsonKey(ignore: true)
  @override
  _$$_ProfileExtraMetaCopyWith<_$_ProfileExtraMeta> get copyWith =>
      __$$_ProfileExtraMetaCopyWithImpl<_$_ProfileExtraMeta>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProfileExtraMetaToJson(this);
  }
}

abstract class _ProfileExtraMeta implements ProfileExtraMeta {
  factory _ProfileExtraMeta(
      {required final String question,
      required final Map<String, FormFieldData> meta}) = _$_ProfileExtraMeta;

  factory _ProfileExtraMeta.fromJson(Map<String, dynamic> json) =
      _$_ProfileExtraMeta.fromJson;

  @override
  String get question;
  @override
  Map<String, FormFieldData> get meta;
  @override
  @JsonKey(ignore: true)
  _$$_ProfileExtraMetaCopyWith<_$_ProfileExtraMeta> get copyWith =>
      throw _privateConstructorUsedError;
}
