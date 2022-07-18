// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'topic_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Topic _$TopicFromJson(Map<String, dynamic> json) {
  return _Topic.fromJson(json);
}

/// @nodoc
mixin _$Topic {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  @JsonKey(name: "is_active")
  bool? get active => throw _privateConstructorUsedError;
  int? get parent => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int? get article => throw _privateConstructorUsedError;
  @JsonKey(name: "is_approved")
  bool? get approved => throw _privateConstructorUsedError;
  String? get creator => throw _privateConstructorUsedError;
  Topic? get root => throw _privateConstructorUsedError;
  int? get groupCount => throw _privateConstructorUsedError;
  TopicType? get type => throw _privateConstructorUsedError;
  @JsonKey(name: "article_detail")
  Article? get articleDetail => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TopicCopyWith<Topic> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopicCopyWith<$Res> {
  factory $TopicCopyWith(Topic value, $Res Function(Topic) then) =
      _$TopicCopyWithImpl<$Res>;
  $Res call(
      {int? id,
      String? name,
      String? image,
      @JsonKey(name: "is_active") bool? active,
      int? parent,
      String? description,
      int? article,
      @JsonKey(name: "is_approved") bool? approved,
      String? creator,
      Topic? root,
      int? groupCount,
      TopicType? type,
      @JsonKey(name: "article_detail") Article? articleDetail});

  $TopicCopyWith<$Res>? get root;
  $ArticleCopyWith<$Res>? get articleDetail;
}

/// @nodoc
class _$TopicCopyWithImpl<$Res> implements $TopicCopyWith<$Res> {
  _$TopicCopyWithImpl(this._value, this._then);

  final Topic _value;
  // ignore: unused_field
  final $Res Function(Topic) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? image = freezed,
    Object? active = freezed,
    Object? parent = freezed,
    Object? description = freezed,
    Object? article = freezed,
    Object? approved = freezed,
    Object? creator = freezed,
    Object? root = freezed,
    Object? groupCount = freezed,
    Object? type = freezed,
    Object? articleDetail = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      active: active == freezed
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool?,
      parent: parent == freezed
          ? _value.parent
          : parent // ignore: cast_nullable_to_non_nullable
              as int?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      article: article == freezed
          ? _value.article
          : article // ignore: cast_nullable_to_non_nullable
              as int?,
      approved: approved == freezed
          ? _value.approved
          : approved // ignore: cast_nullable_to_non_nullable
              as bool?,
      creator: creator == freezed
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as String?,
      root: root == freezed
          ? _value.root
          : root // ignore: cast_nullable_to_non_nullable
              as Topic?,
      groupCount: groupCount == freezed
          ? _value.groupCount
          : groupCount // ignore: cast_nullable_to_non_nullable
              as int?,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TopicType?,
      articleDetail: articleDetail == freezed
          ? _value.articleDetail
          : articleDetail // ignore: cast_nullable_to_non_nullable
              as Article?,
    ));
  }

  @override
  $TopicCopyWith<$Res>? get root {
    if (_value.root == null) {
      return null;
    }

    return $TopicCopyWith<$Res>(_value.root!, (value) {
      return _then(_value.copyWith(root: value));
    });
  }

  @override
  $ArticleCopyWith<$Res>? get articleDetail {
    if (_value.articleDetail == null) {
      return null;
    }

    return $ArticleCopyWith<$Res>(_value.articleDetail!, (value) {
      return _then(_value.copyWith(articleDetail: value));
    });
  }
}

/// @nodoc
abstract class _$$_TopicCopyWith<$Res> implements $TopicCopyWith<$Res> {
  factory _$$_TopicCopyWith(_$_Topic value, $Res Function(_$_Topic) then) =
      __$$_TopicCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? id,
      String? name,
      String? image,
      @JsonKey(name: "is_active") bool? active,
      int? parent,
      String? description,
      int? article,
      @JsonKey(name: "is_approved") bool? approved,
      String? creator,
      Topic? root,
      int? groupCount,
      TopicType? type,
      @JsonKey(name: "article_detail") Article? articleDetail});

  @override
  $TopicCopyWith<$Res>? get root;
  @override
  $ArticleCopyWith<$Res>? get articleDetail;
}

/// @nodoc
class __$$_TopicCopyWithImpl<$Res> extends _$TopicCopyWithImpl<$Res>
    implements _$$_TopicCopyWith<$Res> {
  __$$_TopicCopyWithImpl(_$_Topic _value, $Res Function(_$_Topic) _then)
      : super(_value, (v) => _then(v as _$_Topic));

  @override
  _$_Topic get _value => super._value as _$_Topic;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? image = freezed,
    Object? active = freezed,
    Object? parent = freezed,
    Object? description = freezed,
    Object? article = freezed,
    Object? approved = freezed,
    Object? creator = freezed,
    Object? root = freezed,
    Object? groupCount = freezed,
    Object? type = freezed,
    Object? articleDetail = freezed,
  }) {
    return _then(_$_Topic(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      active: active == freezed
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool?,
      parent: parent == freezed
          ? _value.parent
          : parent // ignore: cast_nullable_to_non_nullable
              as int?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      article: article == freezed
          ? _value.article
          : article // ignore: cast_nullable_to_non_nullable
              as int?,
      approved: approved == freezed
          ? _value.approved
          : approved // ignore: cast_nullable_to_non_nullable
              as bool?,
      creator: creator == freezed
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as String?,
      root: root == freezed
          ? _value.root
          : root // ignore: cast_nullable_to_non_nullable
              as Topic?,
      groupCount: groupCount == freezed
          ? _value.groupCount
          : groupCount // ignore: cast_nullable_to_non_nullable
              as int?,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TopicType?,
      articleDetail: articleDetail == freezed
          ? _value.articleDetail
          : articleDetail // ignore: cast_nullable_to_non_nullable
              as Article?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Topic implements _Topic {
  _$_Topic(
      {this.id,
      this.name,
      this.image,
      @JsonKey(name: "is_active") this.active,
      this.parent,
      this.description,
      this.article,
      @JsonKey(name: "is_approved") this.approved,
      this.creator,
      this.root,
      this.groupCount,
      this.type,
      @JsonKey(name: "article_detail") this.articleDetail});

  factory _$_Topic.fromJson(Map<String, dynamic> json) =>
      _$$_TopicFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? image;
  @override
  @JsonKey(name: "is_active")
  final bool? active;
  @override
  final int? parent;
  @override
  final String? description;
  @override
  final int? article;
  @override
  @JsonKey(name: "is_approved")
  final bool? approved;
  @override
  final String? creator;
  @override
  final Topic? root;
  @override
  final int? groupCount;
  @override
  final TopicType? type;
  @override
  @JsonKey(name: "article_detail")
  final Article? articleDetail;

  @override
  String toString() {
    return 'Topic(id: $id, name: $name, image: $image, active: $active, parent: $parent, description: $description, article: $article, approved: $approved, creator: $creator, root: $root, groupCount: $groupCount, type: $type, articleDetail: $articleDetail)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Topic &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.image, image) &&
            const DeepCollectionEquality().equals(other.active, active) &&
            const DeepCollectionEquality().equals(other.parent, parent) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.article, article) &&
            const DeepCollectionEquality().equals(other.approved, approved) &&
            const DeepCollectionEquality().equals(other.creator, creator) &&
            const DeepCollectionEquality().equals(other.root, root) &&
            const DeepCollectionEquality()
                .equals(other.groupCount, groupCount) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality()
                .equals(other.articleDetail, articleDetail));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(image),
      const DeepCollectionEquality().hash(active),
      const DeepCollectionEquality().hash(parent),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(article),
      const DeepCollectionEquality().hash(approved),
      const DeepCollectionEquality().hash(creator),
      const DeepCollectionEquality().hash(root),
      const DeepCollectionEquality().hash(groupCount),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(articleDetail));

  @JsonKey(ignore: true)
  @override
  _$$_TopicCopyWith<_$_Topic> get copyWith =>
      __$$_TopicCopyWithImpl<_$_Topic>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TopicToJson(this);
  }
}

abstract class _Topic implements Topic {
  factory _Topic(
          {final int? id,
          final String? name,
          final String? image,
          @JsonKey(name: "is_active") final bool? active,
          final int? parent,
          final String? description,
          final int? article,
          @JsonKey(name: "is_approved") final bool? approved,
          final String? creator,
          final Topic? root,
          final int? groupCount,
          final TopicType? type,
          @JsonKey(name: "article_detail") final Article? articleDetail}) =
      _$_Topic;

  factory _Topic.fromJson(Map<String, dynamic> json) = _$_Topic.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get image;
  @override
  @JsonKey(name: "is_active")
  bool? get active;
  @override
  int? get parent;
  @override
  String? get description;
  @override
  int? get article;
  @override
  @JsonKey(name: "is_approved")
  bool? get approved;
  @override
  String? get creator;
  @override
  Topic? get root;
  @override
  int? get groupCount;
  @override
  TopicType? get type;
  @override
  @JsonKey(name: "article_detail")
  Article? get articleDetail;
  @override
  @JsonKey(ignore: true)
  _$$_TopicCopyWith<_$_Topic> get copyWith =>
      throw _privateConstructorUsedError;
}

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return _Article.fromJson(json);
}

/// @nodoc
mixin _$Article {
  int? get pk => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get tag => throw _privateConstructorUsedError;
  @JsonKey(name: "website_tag")
  String? get websiteTag => throw _privateConstructorUsedError;
  @JsonKey(name: "website_url")
  String? get websiteUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArticleCopyWith<Article> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArticleCopyWith<$Res> {
  factory $ArticleCopyWith(Article value, $Res Function(Article) then) =
      _$ArticleCopyWithImpl<$Res>;
  $Res call(
      {int? pk,
      String? title,
      String? description,
      String? image,
      String? tag,
      @JsonKey(name: "website_tag") String? websiteTag,
      @JsonKey(name: "website_url") String? websiteUrl});
}

/// @nodoc
class _$ArticleCopyWithImpl<$Res> implements $ArticleCopyWith<$Res> {
  _$ArticleCopyWithImpl(this._value, this._then);

  final Article _value;
  // ignore: unused_field
  final $Res Function(Article) _then;

  @override
  $Res call({
    Object? pk = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? image = freezed,
    Object? tag = freezed,
    Object? websiteTag = freezed,
    Object? websiteUrl = freezed,
  }) {
    return _then(_value.copyWith(
      pk: pk == freezed
          ? _value.pk
          : pk // ignore: cast_nullable_to_non_nullable
              as int?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      tag: tag == freezed
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String?,
      websiteTag: websiteTag == freezed
          ? _value.websiteTag
          : websiteTag // ignore: cast_nullable_to_non_nullable
              as String?,
      websiteUrl: websiteUrl == freezed
          ? _value.websiteUrl
          : websiteUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_ArticleCopyWith<$Res> implements $ArticleCopyWith<$Res> {
  factory _$$_ArticleCopyWith(
          _$_Article value, $Res Function(_$_Article) then) =
      __$$_ArticleCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? pk,
      String? title,
      String? description,
      String? image,
      String? tag,
      @JsonKey(name: "website_tag") String? websiteTag,
      @JsonKey(name: "website_url") String? websiteUrl});
}

/// @nodoc
class __$$_ArticleCopyWithImpl<$Res> extends _$ArticleCopyWithImpl<$Res>
    implements _$$_ArticleCopyWith<$Res> {
  __$$_ArticleCopyWithImpl(_$_Article _value, $Res Function(_$_Article) _then)
      : super(_value, (v) => _then(v as _$_Article));

  @override
  _$_Article get _value => super._value as _$_Article;

  @override
  $Res call({
    Object? pk = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? image = freezed,
    Object? tag = freezed,
    Object? websiteTag = freezed,
    Object? websiteUrl = freezed,
  }) {
    return _then(_$_Article(
      pk: pk == freezed
          ? _value.pk
          : pk // ignore: cast_nullable_to_non_nullable
              as int?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      tag: tag == freezed
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String?,
      websiteTag: websiteTag == freezed
          ? _value.websiteTag
          : websiteTag // ignore: cast_nullable_to_non_nullable
              as String?,
      websiteUrl: websiteUrl == freezed
          ? _value.websiteUrl
          : websiteUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Article implements _Article {
  _$_Article(
      {this.pk,
      this.title,
      this.description,
      this.image,
      this.tag,
      @JsonKey(name: "website_tag") this.websiteTag,
      @JsonKey(name: "website_url") this.websiteUrl});

  factory _$_Article.fromJson(Map<String, dynamic> json) =>
      _$$_ArticleFromJson(json);

  @override
  final int? pk;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final String? image;
  @override
  final String? tag;
  @override
  @JsonKey(name: "website_tag")
  final String? websiteTag;
  @override
  @JsonKey(name: "website_url")
  final String? websiteUrl;

  @override
  String toString() {
    return 'Article(pk: $pk, title: $title, description: $description, image: $image, tag: $tag, websiteTag: $websiteTag, websiteUrl: $websiteUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Article &&
            const DeepCollectionEquality().equals(other.pk, pk) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.image, image) &&
            const DeepCollectionEquality().equals(other.tag, tag) &&
            const DeepCollectionEquality()
                .equals(other.websiteTag, websiteTag) &&
            const DeepCollectionEquality()
                .equals(other.websiteUrl, websiteUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(pk),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(image),
      const DeepCollectionEquality().hash(tag),
      const DeepCollectionEquality().hash(websiteTag),
      const DeepCollectionEquality().hash(websiteUrl));

  @JsonKey(ignore: true)
  @override
  _$$_ArticleCopyWith<_$_Article> get copyWith =>
      __$$_ArticleCopyWithImpl<_$_Article>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ArticleToJson(this);
  }
}

abstract class _Article implements Article {
  factory _Article(
      {final int? pk,
      final String? title,
      final String? description,
      final String? image,
      final String? tag,
      @JsonKey(name: "website_tag") final String? websiteTag,
      @JsonKey(name: "website_url") final String? websiteUrl}) = _$_Article;

  factory _Article.fromJson(Map<String, dynamic> json) = _$_Article.fromJson;

  @override
  int? get pk;
  @override
  String? get title;
  @override
  String? get description;
  @override
  String? get image;
  @override
  String? get tag;
  @override
  @JsonKey(name: "website_tag")
  String? get websiteTag;
  @override
  @JsonKey(name: "website_url")
  String? get websiteUrl;
  @override
  @JsonKey(ignore: true)
  _$$_ArticleCopyWith<_$_Article> get copyWith =>
      throw _privateConstructorUsedError;
}
