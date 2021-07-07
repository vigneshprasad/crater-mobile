// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'profile_extra_meta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Option _$OptionFromJson(Map<String, dynamic> json) {
  return _Option.fromJson(json);
}

/// @nodoc
class _$OptionTearOff {
  const _$OptionTearOff();

// ignore: unused_element
  _Option call({String name, int value}) {
    return _Option(
      name: name,
      value: value,
    );
  }

// ignore: unused_element
  Option fromJson(Map<String, Object> json) {
    return Option.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Option = _$OptionTearOff();

/// @nodoc
mixin _$Option {
  String get name;
  int get value;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $OptionCopyWith<Option> get copyWith;
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
    Object name = freezed,
    Object value = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed ? _value.name : name as String,
      value: value == freezed ? _value.value : value as int,
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
    Object name = freezed,
    Object value = freezed,
  }) {
    return _then(_Option(
      name: name == freezed ? _value.name : name as String,
      value: value == freezed ? _value.value : value as int,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Option implements _Option {
  _$_Option({this.name, this.value});

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
  factory _Option({String name, int value}) = _$_Option;

  factory _Option.fromJson(Map<String, dynamic> json) = _$_Option.fromJson;

  @override
  String get name;
  @override
  int get value;
  @override
  @JsonKey(ignore: true)
  _$OptionCopyWith<_Option> get copyWith;
}

FormFieldData _$FormFieldDataFromJson(Map<String, dynamic> json) {
  return _FormFieldData.fromJson(json);
}

/// @nodoc
class _$FormFieldDataTearOff {
  const _$FormFieldDataTearOff();

// ignore: unused_element
  _FormFieldData call(
      {FieldType type, List<Option> options, String label, bool blank}) {
    return _FormFieldData(
      type: type,
      options: options,
      label: label,
      blank: blank,
    );
  }

// ignore: unused_element
  FormFieldData fromJson(Map<String, Object> json) {
    return FormFieldData.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $FormFieldData = _$FormFieldDataTearOff();

/// @nodoc
mixin _$FormFieldData {
  FieldType get type;
  List<Option> get options;
  String get label;
  bool get blank;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $FormFieldDataCopyWith<FormFieldData> get copyWith;
}

/// @nodoc
abstract class $FormFieldDataCopyWith<$Res> {
  factory $FormFieldDataCopyWith(
          FormFieldData value, $Res Function(FormFieldData) then) =
      _$FormFieldDataCopyWithImpl<$Res>;
  $Res call({FieldType type, List<Option> options, String label, bool blank});
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
    Object type = freezed,
    Object options = freezed,
    Object label = freezed,
    Object blank = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed ? _value.type : type as FieldType,
      options: options == freezed ? _value.options : options as List<Option>,
      label: label == freezed ? _value.label : label as String,
      blank: blank == freezed ? _value.blank : blank as bool,
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
  $Res call({FieldType type, List<Option> options, String label, bool blank});
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
    Object type = freezed,
    Object options = freezed,
    Object label = freezed,
    Object blank = freezed,
  }) {
    return _then(_FormFieldData(
      type: type == freezed ? _value.type : type as FieldType,
      options: options == freezed ? _value.options : options as List<Option>,
      label: label == freezed ? _value.label : label as String,
      blank: blank == freezed ? _value.blank : blank as bool,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_FormFieldData implements _FormFieldData {
  _$_FormFieldData({this.type, this.options, this.label, this.blank});

  factory _$_FormFieldData.fromJson(Map<String, dynamic> json) =>
      _$_$_FormFieldDataFromJson(json);

  @override
  final FieldType type;
  @override
  final List<Option> options;
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
      {FieldType type,
      List<Option> options,
      String label,
      bool blank}) = _$_FormFieldData;

  factory _FormFieldData.fromJson(Map<String, dynamic> json) =
      _$_FormFieldData.fromJson;

  @override
  FieldType get type;
  @override
  List<Option> get options;
  @override
  String get label;
  @override
  bool get blank;
  @override
  @JsonKey(ignore: true)
  _$FormFieldDataCopyWith<_FormFieldData> get copyWith;
}

ProfileExtraMeta _$ProfileExtraMetaFromJson(Map<String, dynamic> json) {
  return _ProfileExtraMeta.fromJson(json);
}

/// @nodoc
class _$ProfileExtraMetaTearOff {
  const _$ProfileExtraMetaTearOff();

// ignore: unused_element
  _ProfileExtraMeta call({String question, Map<String, FormFieldData> meta}) {
    return _ProfileExtraMeta(
      question: question,
      meta: meta,
    );
  }

// ignore: unused_element
  ProfileExtraMeta fromJson(Map<String, Object> json) {
    return ProfileExtraMeta.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $ProfileExtraMeta = _$ProfileExtraMetaTearOff();

/// @nodoc
mixin _$ProfileExtraMeta {
  String get question;
  Map<String, FormFieldData> get meta;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $ProfileExtraMetaCopyWith<ProfileExtraMeta> get copyWith;
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
    Object question = freezed,
    Object meta = freezed,
  }) {
    return _then(_value.copyWith(
      question: question == freezed ? _value.question : question as String,
      meta: meta == freezed ? _value.meta : meta as Map<String, FormFieldData>,
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
    Object question = freezed,
    Object meta = freezed,
  }) {
    return _then(_ProfileExtraMeta(
      question: question == freezed ? _value.question : question as String,
      meta: meta == freezed ? _value.meta : meta as Map<String, FormFieldData>,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_ProfileExtraMeta implements _ProfileExtraMeta {
  _$_ProfileExtraMeta({this.question, this.meta});

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
      {String question, Map<String, FormFieldData> meta}) = _$_ProfileExtraMeta;

  factory _ProfileExtraMeta.fromJson(Map<String, dynamic> json) =
      _$_ProfileExtraMeta.fromJson;

  @override
  String get question;
  @override
  Map<String, FormFieldData> get meta;
  @override
  @JsonKey(ignore: true)
  _$ProfileExtraMetaCopyWith<_ProfileExtraMeta> get copyWith;
}
