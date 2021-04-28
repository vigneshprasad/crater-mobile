// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'article_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Article _$ArticleFromJson(Map<String, dynamic> json) {
  return _Article.fromJson(json);
}

/// @nodoc
class _$ArticleTearOff {
  const _$ArticleTearOff();

// ignore: unused_element
  _Article call(
      {int pk,
      String title,
      String description,
      String image,
      String tag,
      @JsonKey(name: 'website_tag')
          String websiteTag,
      @JsonKey(name: 'website_url')
          String websiteUrl,
      @JsonKey(name: 'website_tag_detail')
          ArticleWebsiteSource articleSourceDetail}) {
    return _Article(
      pk: pk,
      title: title,
      description: description,
      image: image,
      tag: tag,
      websiteTag: websiteTag,
      websiteUrl: websiteUrl,
      articleSourceDetail: articleSourceDetail,
    );
  }

// ignore: unused_element
  Article fromJson(Map<String, Object> json) {
    return Article.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Article = _$ArticleTearOff();

/// @nodoc
mixin _$Article {
  int get pk;
  String get title;
  String get description;
  String get image;
  String get tag;
  @JsonKey(name: 'website_tag')
  String get websiteTag;
  @JsonKey(name: 'website_url')
  String get websiteUrl;
  @JsonKey(name: 'website_tag_detail')
  ArticleWebsiteSource get articleSourceDetail;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $ArticleCopyWith<Article> get copyWith;
}

/// @nodoc
abstract class $ArticleCopyWith<$Res> {
  factory $ArticleCopyWith(Article value, $Res Function(Article) then) =
      _$ArticleCopyWithImpl<$Res>;
  $Res call(
      {int pk,
      String title,
      String description,
      String image,
      String tag,
      @JsonKey(name: 'website_tag')
          String websiteTag,
      @JsonKey(name: 'website_url')
          String websiteUrl,
      @JsonKey(name: 'website_tag_detail')
          ArticleWebsiteSource articleSourceDetail});

  $ArticleWebsiteSourceCopyWith<$Res> get articleSourceDetail;
}

/// @nodoc
class _$ArticleCopyWithImpl<$Res> implements $ArticleCopyWith<$Res> {
  _$ArticleCopyWithImpl(this._value, this._then);

  final Article _value;
  // ignore: unused_field
  final $Res Function(Article) _then;

  @override
  $Res call({
    Object pk = freezed,
    Object title = freezed,
    Object description = freezed,
    Object image = freezed,
    Object tag = freezed,
    Object websiteTag = freezed,
    Object websiteUrl = freezed,
    Object articleSourceDetail = freezed,
  }) {
    return _then(_value.copyWith(
      pk: pk == freezed ? _value.pk : pk as int,
      title: title == freezed ? _value.title : title as String,
      description:
          description == freezed ? _value.description : description as String,
      image: image == freezed ? _value.image : image as String,
      tag: tag == freezed ? _value.tag : tag as String,
      websiteTag:
          websiteTag == freezed ? _value.websiteTag : websiteTag as String,
      websiteUrl:
          websiteUrl == freezed ? _value.websiteUrl : websiteUrl as String,
      articleSourceDetail: articleSourceDetail == freezed
          ? _value.articleSourceDetail
          : articleSourceDetail as ArticleWebsiteSource,
    ));
  }

  @override
  $ArticleWebsiteSourceCopyWith<$Res> get articleSourceDetail {
    if (_value.articleSourceDetail == null) {
      return null;
    }
    return $ArticleWebsiteSourceCopyWith<$Res>(_value.articleSourceDetail,
        (value) {
      return _then(_value.copyWith(articleSourceDetail: value));
    });
  }
}

/// @nodoc
abstract class _$ArticleCopyWith<$Res> implements $ArticleCopyWith<$Res> {
  factory _$ArticleCopyWith(_Article value, $Res Function(_Article) then) =
      __$ArticleCopyWithImpl<$Res>;
  @override
  $Res call(
      {int pk,
      String title,
      String description,
      String image,
      String tag,
      @JsonKey(name: 'website_tag')
          String websiteTag,
      @JsonKey(name: 'website_url')
          String websiteUrl,
      @JsonKey(name: 'website_tag_detail')
          ArticleWebsiteSource articleSourceDetail});

  @override
  $ArticleWebsiteSourceCopyWith<$Res> get articleSourceDetail;
}

/// @nodoc
class __$ArticleCopyWithImpl<$Res> extends _$ArticleCopyWithImpl<$Res>
    implements _$ArticleCopyWith<$Res> {
  __$ArticleCopyWithImpl(_Article _value, $Res Function(_Article) _then)
      : super(_value, (v) => _then(v as _Article));

  @override
  _Article get _value => super._value as _Article;

  @override
  $Res call({
    Object pk = freezed,
    Object title = freezed,
    Object description = freezed,
    Object image = freezed,
    Object tag = freezed,
    Object websiteTag = freezed,
    Object websiteUrl = freezed,
    Object articleSourceDetail = freezed,
  }) {
    return _then(_Article(
      pk: pk == freezed ? _value.pk : pk as int,
      title: title == freezed ? _value.title : title as String,
      description:
          description == freezed ? _value.description : description as String,
      image: image == freezed ? _value.image : image as String,
      tag: tag == freezed ? _value.tag : tag as String,
      websiteTag:
          websiteTag == freezed ? _value.websiteTag : websiteTag as String,
      websiteUrl:
          websiteUrl == freezed ? _value.websiteUrl : websiteUrl as String,
      articleSourceDetail: articleSourceDetail == freezed
          ? _value.articleSourceDetail
          : articleSourceDetail as ArticleWebsiteSource,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Article implements _Article {
  _$_Article(
      {this.pk,
      this.title,
      this.description,
      this.image,
      this.tag,
      @JsonKey(name: 'website_tag') this.websiteTag,
      @JsonKey(name: 'website_url') this.websiteUrl,
      @JsonKey(name: 'website_tag_detail') this.articleSourceDetail});

  factory _$_Article.fromJson(Map<String, dynamic> json) =>
      _$_$_ArticleFromJson(json);

  @override
  final int pk;
  @override
  final String title;
  @override
  final String description;
  @override
  final String image;
  @override
  final String tag;
  @override
  @JsonKey(name: 'website_tag')
  final String websiteTag;
  @override
  @JsonKey(name: 'website_url')
  final String websiteUrl;
  @override
  @JsonKey(name: 'website_tag_detail')
  final ArticleWebsiteSource articleSourceDetail;

  @override
  String toString() {
    return 'Article(pk: $pk, title: $title, description: $description, image: $image, tag: $tag, websiteTag: $websiteTag, websiteUrl: $websiteUrl, articleSourceDetail: $articleSourceDetail)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Article &&
            (identical(other.pk, pk) ||
                const DeepCollectionEquality().equals(other.pk, pk)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.image, image) ||
                const DeepCollectionEquality().equals(other.image, image)) &&
            (identical(other.tag, tag) ||
                const DeepCollectionEquality().equals(other.tag, tag)) &&
            (identical(other.websiteTag, websiteTag) ||
                const DeepCollectionEquality()
                    .equals(other.websiteTag, websiteTag)) &&
            (identical(other.websiteUrl, websiteUrl) ||
                const DeepCollectionEquality()
                    .equals(other.websiteUrl, websiteUrl)) &&
            (identical(other.articleSourceDetail, articleSourceDetail) ||
                const DeepCollectionEquality()
                    .equals(other.articleSourceDetail, articleSourceDetail)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(pk) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(image) ^
      const DeepCollectionEquality().hash(tag) ^
      const DeepCollectionEquality().hash(websiteTag) ^
      const DeepCollectionEquality().hash(websiteUrl) ^
      const DeepCollectionEquality().hash(articleSourceDetail);

  @JsonKey(ignore: true)
  @override
  _$ArticleCopyWith<_Article> get copyWith =>
      __$ArticleCopyWithImpl<_Article>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ArticleToJson(this);
  }
}

abstract class _Article implements Article {
  factory _Article(
      {int pk,
      String title,
      String description,
      String image,
      String tag,
      @JsonKey(name: 'website_tag')
          String websiteTag,
      @JsonKey(name: 'website_url')
          String websiteUrl,
      @JsonKey(name: 'website_tag_detail')
          ArticleWebsiteSource articleSourceDetail}) = _$_Article;

  factory _Article.fromJson(Map<String, dynamic> json) = _$_Article.fromJson;

  @override
  int get pk;
  @override
  String get title;
  @override
  String get description;
  @override
  String get image;
  @override
  String get tag;
  @override
  @JsonKey(name: 'website_tag')
  String get websiteTag;
  @override
  @JsonKey(name: 'website_url')
  String get websiteUrl;
  @override
  @JsonKey(name: 'website_tag_detail')
  ArticleWebsiteSource get articleSourceDetail;
  @override
  @JsonKey(ignore: true)
  _$ArticleCopyWith<_Article> get copyWith;
}
