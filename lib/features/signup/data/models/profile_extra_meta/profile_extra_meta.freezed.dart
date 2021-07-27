// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'profile_extra_meta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Option _$OptionFromJson(Map<String, dynamic> json) {
  return _Option.fromJson(json);
}

/// @nodoc
class _$OptionTearOff {
  const _$OptionTearOff();

  _Option call({required String name, required int value}) {
    return _Option(
      name: name,
      value: value,
    );
  }

  Option fromJson(Map<String, Object> json) {
    return Option.fromJson(json);
  }
}

/// @nodoc
const $Option = _$OptionTearOff();

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
abstract class _$OptionCopyWith<$Res> implements $OptionCopyWith<$Res> {
  factory _$OptionCopyWith(_Option value, $Res Function(_Option) then) =
      __$OptionCopyWithImpl<$Res>;
  @override
  $Res call({String name, int value});
}

/// @nodoc
class __$OptionCopyWithImpl<$Res> extends _$OptionCopyWithImpl<$Res>
    implements _$OptionCopyWith<$Res> {
  __$OptionCopyWithImpl(_Option _value, $Res Function(_Option) _then)
      : super(_value, (v) => _then(v as _Option));

  @override
  _Option get _value => super._value as _Option;

  @override
  $Res call({
    Object? name = freezed,
    Object? value = freezed,
  }) {
    return _then(_Option(
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
      _$_$_OptionFromJson(json);

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
        (other is _Option &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(value);

  @JsonKey(ignore: true)
  @override
  _$OptionCopyWith<_Option> get copyWith =>
      __$OptionCopyWithImpl<_Option>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_OptionToJson(this);
  }
}

abstract class _Option implements Option {
  factory _Option({required String name, required int value}) = _$_Option;

  factory _Option.fromJson(Map<String, dynamic> json) = _$_Option.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  int get value => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$OptionCopyWith<_Option> get copyWith => throw _privateConstructorUsedError;
}

FormFieldData _$FormFieldDataFromJson(Map<String, dynamic> json) {
  return _FormFieldData.fromJson(json);
}

/// @nodoc
class _$FormFieldDataTearOff {
  const _$FormFieldDataTearOff();

  _FormFieldData call(
      {required FieldType type,
      List<Option>? options,
      required String label,
      required bool blank}) {
    return _FormFieldData(
      type: type,
      options: options,
      label: label,
      blank: blank,
    );
  }

  FormFieldData fromJson(Map<String, Object> json) {
    return FormFieldData.fromJson(json);
  }
}

/// @nodoc
const $FormFieldData = _$FormFieldDataTearOff();

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
abstract class _$FormFieldDataCopyWith<$Res>
    implements $FormFieldDataCopyWith<$Res> {
  factory _$FormFieldDataCopyWith(
          _FormFieldData value, $Res Function(_FormFieldData) then) =
      __$FormFieldDataCopyWithImpl<$Res>;
  @override
  $Res call({FieldType type, List<Option>? options, String label, bool blank});
}

/// @nodoc
class __$FormFieldDataCopyWithImpl<$Res>
    extends _$FormFieldDataCopyWithImpl<$Res>
    implements _$FormFieldDataCopyWith<$Res> {
  __$FormFieldDataCopyWithImpl(
      _FormFieldData _value, $Res Function(_FormFieldData) _then)
      : super(_value, (v) => _then(v as _FormFieldData));

  @override
  _FormFieldData get _value => super._value as _FormFieldData;

  @override
  $Res call({
    Object? type = freezed,
    Object? options = freezed,
    Object? label = freezed,
    Object? blank = freezed,
  }) {
    return _then(_FormFieldData(
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
@JsonSerializable()
class _$_FormFieldData implements _FormFieldData {
  _$_FormFieldData(
      {required this.type,
      this.options,
      required this.label,
      required this.blank});

  factory _$_FormFieldData.fromJson(Map<String, dynamic> json) =>
      _$_$_FormFieldDataFromJson(json);

  @override
  final FieldType type;
  @override
  final List<Option>? options;
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
        (other is _FormFieldData &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.options, options) ||
                const DeepCollectionEquality()
                    .equals(other.options, options)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.blank, blank) ||
                const DeepCollectionEquality().equals(other.blank, blank)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(options) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(blank);

  @JsonKey(ignore: true)
  @override
  _$FormFieldDataCopyWith<_FormFieldData> get copyWith =>
      __$FormFieldDataCopyWithImpl<_FormFieldData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_FormFieldDataToJson(this);
  }
}

abstract class _FormFieldData implements FormFieldData {
  factory _FormFieldData(
      {required FieldType type,
      List<Option>? options,
      required String label,
      required bool blank}) = _$_FormFieldData;

  factory _FormFieldData.fromJson(Map<String, dynamic> json) =
      _$_FormFieldData.fromJson;

  @override
  FieldType get type => throw _privateConstructorUsedError;
  @override
  List<Option>? get options => throw _privateConstructorUsedError;
  @override
  String get label => throw _privateConstructorUsedError;
  @override
  bool get blank => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$FormFieldDataCopyWith<_FormFieldData> get copyWith =>
      throw _privateConstructorUsedError;
}

ProfileExtraMeta _$ProfileExtraMetaFromJson(Map<String, dynamic> json) {
  return _ProfileExtraMeta.fromJson(json);
}

/// @nodoc
class _$ProfileExtraMetaTearOff {
  const _$ProfileExtraMetaTearOff();

  _ProfileExtraMeta call(
      {required String question, required Map<String, FormFieldData> meta}) {
    return _ProfileExtraMeta(
      question: question,
      meta: meta,
    );
  }

  ProfileExtraMeta fromJson(Map<String, Object> json) {
    return ProfileExtraMeta.fromJson(json);
  }
}

/// @nodoc
const $ProfileExtraMeta = _$ProfileExtraMetaTearOff();

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
abstract class _$ProfileExtraMetaCopyWith<$Res>
    implements $ProfileExtraMetaCopyWith<$Res> {
  factory _$ProfileExtraMetaCopyWith(
          _ProfileExtraMeta value, $Res Function(_ProfileExtraMeta) then) =
      __$ProfileExtraMetaCopyWithImpl<$Res>;
  @override
  $Res call({String question, Map<String, FormFieldData> meta});
}

/// @nodoc
class __$ProfileExtraMetaCopyWithImpl<$Res>
    extends _$ProfileExtraMetaCopyWithImpl<$Res>
    implements _$ProfileExtraMetaCopyWith<$Res> {
  __$ProfileExtraMetaCopyWithImpl(
      _ProfileExtraMeta _value, $Res Function(_ProfileExtraMeta) _then)
      : super(_value, (v) => _then(v as _ProfileExtraMeta));

  @override
  _ProfileExtraMeta get _value => super._value as _ProfileExtraMeta;

  @override
  $Res call({
    Object? question = freezed,
    Object? meta = freezed,
  }) {
    return _then(_ProfileExtraMeta(
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
@JsonSerializable()
class _$_ProfileExtraMeta implements _ProfileExtraMeta {
  _$_ProfileExtraMeta({required this.question, required this.meta});

  factory _$_ProfileExtraMeta.fromJson(Map<String, dynamic> json) =>
      _$_$_ProfileExtraMetaFromJson(json);

  @override
  final String question;
  @override
  final Map<String, FormFieldData> meta;

  @override
  String toString() {
    return 'ProfileExtraMeta(question: $question, meta: $meta)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ProfileExtraMeta &&
            (identical(other.question, question) ||
                const DeepCollectionEquality()
                    .equals(other.question, question)) &&
            (identical(other.meta, meta) ||
                const DeepCollectionEquality().equals(other.meta, meta)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(question) ^
      const DeepCollectionEquality().hash(meta);

  @JsonKey(ignore: true)
  @override
  _$ProfileExtraMetaCopyWith<_ProfileExtraMeta> get copyWith =>
      __$ProfileExtraMetaCopyWithImpl<_ProfileExtraMeta>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ProfileExtraMetaToJson(this);
  }
}

abstract class _ProfileExtraMeta implements ProfileExtraMeta {
  factory _ProfileExtraMeta(
      {required String question,
      required Map<String, FormFieldData> meta}) = _$_ProfileExtraMeta;

  factory _ProfileExtraMeta.fromJson(Map<String, dynamic> json) =
      _$_ProfileExtraMeta.fromJson;

  @override
  String get question => throw _privateConstructorUsedError;
  @override
  Map<String, FormFieldData> get meta => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ProfileExtraMetaCopyWith<_ProfileExtraMeta> get copyWith =>
      throw _privateConstructorUsedError;
}
