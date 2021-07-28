// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'article_website_source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ArticleWebsiteSource _$ArticleWebsiteSourceFromJson(Map<String, dynamic> json) {
  return _ArticleWebsiteSource.fromJson(json);
}

/// @nodoc
class _$ArticleWebsiteSourceTearOff {
  const _$ArticleWebsiteSourceTearOff();

  _ArticleWebsiteSource call(
      {int? pk, String? name, String? url, String? image}) {
    return _ArticleWebsiteSource(
      pk: pk,
      name: name,
      url: url,
      image: image,
    );
  }

  ArticleWebsiteSource fromJson(Map<String, Object> json) {
    return ArticleWebsiteSource.fromJson(json);
  }
}

/// @nodoc
const $ArticleWebsiteSource = _$ArticleWebsiteSourceTearOff();

/// @nodoc
mixin _$ArticleWebsiteSource {
  int? get pk => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArticleWebsiteSourceCopyWith<ArticleWebsiteSource> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArticleWebsiteSourceCopyWith<$Res> {
  factory $ArticleWebsiteSourceCopyWith(ArticleWebsiteSource value,
          $Res Function(ArticleWebsiteSource) then) =
      _$ArticleWebsiteSourceCopyWithImpl<$Res>;
  $Res call({int? pk, String? name, String? url, String? image});
}

/// @nodoc
class _$ArticleWebsiteSourceCopyWithImpl<$Res>
    implements $ArticleWebsiteSourceCopyWith<$Res> {
  _$ArticleWebsiteSourceCopyWithImpl(this._value, this._then);

  final ArticleWebsiteSource _value;
  // ignore: unused_field
  final $Res Function(ArticleWebsiteSource) _then;

  @override
  $Res call({
    Object? pk = freezed,
    Object? name = freezed,
    Object? url = freezed,
    Object? image = freezed,
  }) {
    return _then(_value.copyWith(
      pk: pk == freezed
          ? _value.pk
          : pk // ignore: cast_nullable_to_non_nullable
              as int?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$ArticleWebsiteSourceCopyWith<$Res>
    implements $ArticleWebsiteSourceCopyWith<$Res> {
  factory _$ArticleWebsiteSourceCopyWith(_ArticleWebsiteSource value,
          $Res Function(_ArticleWebsiteSource) then) =
      __$ArticleWebsiteSourceCopyWithImpl<$Res>;
  @override
  $Res call({int? pk, String? name, String? url, String? image});
}

/// @nodoc
class __$ArticleWebsiteSourceCopyWithImpl<$Res>
    extends _$ArticleWebsiteSourceCopyWithImpl<$Res>
    implements _$ArticleWebsiteSourceCopyWith<$Res> {
  __$ArticleWebsiteSourceCopyWithImpl(
      _ArticleWebsiteSource _value, $Res Function(_ArticleWebsiteSource) _then)
      : super(_value, (v) => _then(v as _ArticleWebsiteSource));

  @override
  _ArticleWebsiteSource get _value => super._value as _ArticleWebsiteSource;

  @override
  $Res call({
    Object? pk = freezed,
    Object? name = freezed,
    Object? url = freezed,
    Object? image = freezed,
  }) {
    return _then(_ArticleWebsiteSource(
      pk: pk == freezed
          ? _value.pk
          : pk // ignore: cast_nullable_to_non_nullable
              as int?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ArticleWebsiteSource implements _ArticleWebsiteSource {
  _$_ArticleWebsiteSource({this.pk, this.name, this.url, this.image});

  factory _$_ArticleWebsiteSource.fromJson(Map<String, dynamic> json) =>
      _$_$_ArticleWebsiteSourceFromJson(json);

  @override
  final int? pk;
  @override
  final String? name;
  @override
  final String? url;
  @override
  final String? image;

  @override
  String toString() {
    return 'ArticleWebsiteSource(pk: $pk, name: $name, url: $url, image: $image)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ArticleWebsiteSource &&
            (identical(other.pk, pk) ||
                const DeepCollectionEquality().equals(other.pk, pk)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.image, image) ||
                const DeepCollectionEquality().equals(other.image, image)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(pk) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(image);

  @JsonKey(ignore: true)
  @override
  _$ArticleWebsiteSourceCopyWith<_ArticleWebsiteSource> get copyWith =>
      __$ArticleWebsiteSourceCopyWithImpl<_ArticleWebsiteSource>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ArticleWebsiteSourceToJson(this);
  }
}

abstract class _ArticleWebsiteSource implements ArticleWebsiteSource {
  factory _ArticleWebsiteSource(
      {int? pk,
      String? name,
      String? url,
      String? image}) = _$_ArticleWebsiteSource;

  factory _ArticleWebsiteSource.fromJson(Map<String, dynamic> json) =
      _$_ArticleWebsiteSource.fromJson;

  @override
  int? get pk => throw _privateConstructorUsedError;
  @override
  String? get name => throw _privateConstructorUsedError;
  @override
  String? get url => throw _privateConstructorUsedError;
  @override
  String? get image => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ArticleWebsiteSourceCopyWith<_ArticleWebsiteSource> get copyWith =>
      throw _privateConstructorUsedError;
}
