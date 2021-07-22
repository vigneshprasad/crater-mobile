// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'profile_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return _Profile.fromJson(json);
}

/// @nodoc
class _$ProfileTearOff {
  const _$ProfileTearOff();

  _Profile call(
      {required int pk,
      String? uuid,
      String? name,
      String? introduction,
      @JsonKey(name: 'generated_introduction') String? generatedIntroduction,
      @JsonKey(name: "tag_list") List<Tag>? tag,
      @JsonKey(name: "linkedin_url") String? linkedIn,
      String? photo}) {
    return _Profile(
      pk: pk,
      uuid: uuid,
      name: name,
      introduction: introduction,
      generatedIntroduction: generatedIntroduction,
      tag: tag,
      linkedIn: linkedIn,
      photo: photo,
    );
  }

  Profile fromJson(Map<String, Object> json) {
    return Profile.fromJson(json);
  }
}

/// @nodoc
const $Profile = _$ProfileTearOff();

/// @nodoc
mixin _$Profile {
  int get pk => throw _privateConstructorUsedError;
  String? get uuid => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get introduction => throw _privateConstructorUsedError;
  @JsonKey(name: 'generated_introduction')
  String? get generatedIntroduction => throw _privateConstructorUsedError;
  @JsonKey(name: "tag_list")
  List<Tag>? get tag => throw _privateConstructorUsedError;
  @JsonKey(name: "linkedin_url")
  String? get linkedIn => throw _privateConstructorUsedError;
  String? get photo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProfileCopyWith<Profile> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileCopyWith<$Res> {
  factory $ProfileCopyWith(Profile value, $Res Function(Profile) then) =
      _$ProfileCopyWithImpl<$Res>;
  $Res call(
      {int pk,
      String? uuid,
      String? name,
      String? introduction,
      @JsonKey(name: 'generated_introduction') String? generatedIntroduction,
      @JsonKey(name: "tag_list") List<Tag>? tag,
      @JsonKey(name: "linkedin_url") String? linkedIn,
      String? photo});
}

/// @nodoc
class _$ProfileCopyWithImpl<$Res> implements $ProfileCopyWith<$Res> {
  _$ProfileCopyWithImpl(this._value, this._then);

  final Profile _value;
  // ignore: unused_field
  final $Res Function(Profile) _then;

  @override
  $Res call({
    Object? pk = freezed,
    Object? uuid = freezed,
    Object? name = freezed,
    Object? introduction = freezed,
    Object? generatedIntroduction = freezed,
    Object? tag = freezed,
    Object? linkedIn = freezed,
    Object? photo = freezed,
  }) {
    return _then(_value.copyWith(
      pk: pk == freezed
          ? _value.pk
          : pk // ignore: cast_nullable_to_non_nullable
              as int,
      uuid: uuid == freezed
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      introduction: introduction == freezed
          ? _value.introduction
          : introduction // ignore: cast_nullable_to_non_nullable
              as String?,
      generatedIntroduction: generatedIntroduction == freezed
          ? _value.generatedIntroduction
          : generatedIntroduction // ignore: cast_nullable_to_non_nullable
              as String?,
      tag: tag == freezed
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as List<Tag>?,
      linkedIn: linkedIn == freezed
          ? _value.linkedIn
          : linkedIn // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: photo == freezed
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$ProfileCopyWith<$Res> implements $ProfileCopyWith<$Res> {
  factory _$ProfileCopyWith(_Profile value, $Res Function(_Profile) then) =
      __$ProfileCopyWithImpl<$Res>;
  @override
  $Res call(
      {int pk,
      String? uuid,
      String? name,
      String? introduction,
      @JsonKey(name: 'generated_introduction') String? generatedIntroduction,
      @JsonKey(name: "tag_list") List<Tag>? tag,
      @JsonKey(name: "linkedin_url") String? linkedIn,
      String? photo});
}

/// @nodoc
class __$ProfileCopyWithImpl<$Res> extends _$ProfileCopyWithImpl<$Res>
    implements _$ProfileCopyWith<$Res> {
  __$ProfileCopyWithImpl(_Profile _value, $Res Function(_Profile) _then)
      : super(_value, (v) => _then(v as _Profile));

  @override
  _Profile get _value => super._value as _Profile;

  @override
  $Res call({
    Object? pk = freezed,
    Object? uuid = freezed,
    Object? name = freezed,
    Object? introduction = freezed,
    Object? generatedIntroduction = freezed,
    Object? tag = freezed,
    Object? linkedIn = freezed,
    Object? photo = freezed,
  }) {
    return _then(_Profile(
      pk: pk == freezed
          ? _value.pk
          : pk // ignore: cast_nullable_to_non_nullable
              as int,
      uuid: uuid == freezed
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      introduction: introduction == freezed
          ? _value.introduction
          : introduction // ignore: cast_nullable_to_non_nullable
              as String?,
      generatedIntroduction: generatedIntroduction == freezed
          ? _value.generatedIntroduction
          : generatedIntroduction // ignore: cast_nullable_to_non_nullable
              as String?,
      tag: tag == freezed
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as List<Tag>?,
      linkedIn: linkedIn == freezed
          ? _value.linkedIn
          : linkedIn // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: photo == freezed
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Profile implements _Profile {
  _$_Profile(
      {required this.pk,
      this.uuid,
      this.name,
      this.introduction,
      @JsonKey(name: 'generated_introduction') this.generatedIntroduction,
      @JsonKey(name: "tag_list") this.tag,
      @JsonKey(name: "linkedin_url") this.linkedIn,
      this.photo});

  factory _$_Profile.fromJson(Map<String, dynamic> json) =>
      _$_$_ProfileFromJson(json);

  @override
  final int pk;
  @override
  final String? uuid;
  @override
  final String? name;
  @override
  final String? introduction;
  @override
  @JsonKey(name: 'generated_introduction')
  final String? generatedIntroduction;
  @override
  @JsonKey(name: "tag_list")
  final List<Tag>? tag;
  @override
  @JsonKey(name: "linkedin_url")
  final String? linkedIn;
  @override
  final String? photo;

  @override
  String toString() {
    return 'Profile(pk: $pk, uuid: $uuid, name: $name, introduction: $introduction, generatedIntroduction: $generatedIntroduction, tag: $tag, linkedIn: $linkedIn, photo: $photo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Profile &&
            (identical(other.pk, pk) ||
                const DeepCollectionEquality().equals(other.pk, pk)) &&
            (identical(other.uuid, uuid) ||
                const DeepCollectionEquality().equals(other.uuid, uuid)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.introduction, introduction) ||
                const DeepCollectionEquality()
                    .equals(other.introduction, introduction)) &&
            (identical(other.generatedIntroduction, generatedIntroduction) ||
                const DeepCollectionEquality().equals(
                    other.generatedIntroduction, generatedIntroduction)) &&
            (identical(other.tag, tag) ||
                const DeepCollectionEquality().equals(other.tag, tag)) &&
            (identical(other.linkedIn, linkedIn) ||
                const DeepCollectionEquality()
                    .equals(other.linkedIn, linkedIn)) &&
            (identical(other.photo, photo) ||
                const DeepCollectionEquality().equals(other.photo, photo)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(pk) ^
      const DeepCollectionEquality().hash(uuid) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(introduction) ^
      const DeepCollectionEquality().hash(generatedIntroduction) ^
      const DeepCollectionEquality().hash(tag) ^
      const DeepCollectionEquality().hash(linkedIn) ^
      const DeepCollectionEquality().hash(photo);

  @JsonKey(ignore: true)
  @override
  _$ProfileCopyWith<_Profile> get copyWith =>
      __$ProfileCopyWithImpl<_Profile>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ProfileToJson(this);
  }
}

abstract class _Profile implements Profile {
  factory _Profile(
      {required int pk,
      String? uuid,
      String? name,
      String? introduction,
      @JsonKey(name: 'generated_introduction') String? generatedIntroduction,
      @JsonKey(name: "tag_list") List<Tag>? tag,
      @JsonKey(name: "linkedin_url") String? linkedIn,
      String? photo}) = _$_Profile;

  factory _Profile.fromJson(Map<String, dynamic> json) = _$_Profile.fromJson;

  @override
  int get pk => throw _privateConstructorUsedError;
  @override
  String? get uuid => throw _privateConstructorUsedError;
  @override
  String? get name => throw _privateConstructorUsedError;
  @override
  String? get introduction => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'generated_introduction')
  String? get generatedIntroduction => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "tag_list")
  List<Tag>? get tag => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "linkedin_url")
  String? get linkedIn => throw _privateConstructorUsedError;
  @override
  String? get photo => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ProfileCopyWith<_Profile> get copyWith =>
      throw _privateConstructorUsedError;
}
