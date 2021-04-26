// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'topic_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Topic _$TopicFromJson(Map<String, dynamic> json) {
  return _Topic.fromJson(json);
}

/// @nodoc
class _$TopicTearOff {
  const _$TopicTearOff();

// ignore: unused_element
  _Topic call(
      {int id,
      String name,
      String image,
      @JsonKey(name: 'is_active') bool active,
      int parent,
      String description,
      @JsonKey(name: 'is_approved') bool approved,
      String creator,
      Topic root,
      int groupCount}) {
    return _Topic(
      id: id,
      name: name,
      image: image,
      active: active,
      parent: parent,
      description: description,
      approved: approved,
      creator: creator,
      root: root,
      groupCount: groupCount,
    );
  }

// ignore: unused_element
  Topic fromJson(Map<String, Object> json) {
    return Topic.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Topic = _$TopicTearOff();

/// @nodoc
mixin _$Topic {
  int get id;
  String get name;
  String get image;
  @JsonKey(name: 'is_active')
  bool get active;
  int get parent;
  String get description;
  @JsonKey(name: 'is_approved')
  bool get approved;
  String get creator;
  Topic get root;
  int get groupCount;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $TopicCopyWith<Topic> get copyWith;
}

/// @nodoc
abstract class $TopicCopyWith<$Res> {
  factory $TopicCopyWith(Topic value, $Res Function(Topic) then) =
      _$TopicCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String name,
      String image,
      @JsonKey(name: 'is_active') bool active,
      int parent,
      String description,
      @JsonKey(name: 'is_approved') bool approved,
      String creator,
      Topic root,
      int groupCount});

  $TopicCopyWith<$Res> get root;
}

/// @nodoc
class _$TopicCopyWithImpl<$Res> implements $TopicCopyWith<$Res> {
  _$TopicCopyWithImpl(this._value, this._then);

  final Topic _value;
  // ignore: unused_field
  final $Res Function(Topic) _then;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object image = freezed,
    Object active = freezed,
    Object parent = freezed,
    Object description = freezed,
    Object approved = freezed,
    Object creator = freezed,
    Object root = freezed,
    Object groupCount = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as int,
      name: name == freezed ? _value.name : name as String,
      image: image == freezed ? _value.image : image as String,
      active: active == freezed ? _value.active : active as bool,
      parent: parent == freezed ? _value.parent : parent as int,
      description:
          description == freezed ? _value.description : description as String,
      approved: approved == freezed ? _value.approved : approved as bool,
      creator: creator == freezed ? _value.creator : creator as String,
      root: root == freezed ? _value.root : root as Topic,
      groupCount: groupCount == freezed ? _value.groupCount : groupCount as int,
    ));
  }

  @override
  $TopicCopyWith<$Res> get root {
    if (_value.root == null) {
      return null;
    }
    return $TopicCopyWith<$Res>(_value.root, (value) {
      return _then(_value.copyWith(root: value));
    });
  }
}

/// @nodoc
abstract class _$TopicCopyWith<$Res> implements $TopicCopyWith<$Res> {
  factory _$TopicCopyWith(_Topic value, $Res Function(_Topic) then) =
      __$TopicCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String name,
      String image,
      @JsonKey(name: 'is_active') bool active,
      int parent,
      String description,
      @JsonKey(name: 'is_approved') bool approved,
      String creator,
      Topic root,
      int groupCount});

  @override
  $TopicCopyWith<$Res> get root;
}

/// @nodoc
class __$TopicCopyWithImpl<$Res> extends _$TopicCopyWithImpl<$Res>
    implements _$TopicCopyWith<$Res> {
  __$TopicCopyWithImpl(_Topic _value, $Res Function(_Topic) _then)
      : super(_value, (v) => _then(v as _Topic));

  @override
  _Topic get _value => super._value as _Topic;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object image = freezed,
    Object active = freezed,
    Object parent = freezed,
    Object description = freezed,
    Object approved = freezed,
    Object creator = freezed,
    Object root = freezed,
    Object groupCount = freezed,
  }) {
    return _then(_Topic(
      id: id == freezed ? _value.id : id as int,
      name: name == freezed ? _value.name : name as String,
      image: image == freezed ? _value.image : image as String,
      active: active == freezed ? _value.active : active as bool,
      parent: parent == freezed ? _value.parent : parent as int,
      description:
          description == freezed ? _value.description : description as String,
      approved: approved == freezed ? _value.approved : approved as bool,
      creator: creator == freezed ? _value.creator : creator as String,
      root: root == freezed ? _value.root : root as Topic,
      groupCount: groupCount == freezed ? _value.groupCount : groupCount as int,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Topic implements _Topic {
  _$_Topic(
      {this.id,
      this.name,
      this.image,
      @JsonKey(name: 'is_active') this.active,
      this.parent,
      this.description,
      @JsonKey(name: 'is_approved') this.approved,
      this.creator,
      this.root,
      this.groupCount});

  factory _$_Topic.fromJson(Map<String, dynamic> json) =>
      _$_$_TopicFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String image;
  @override
  @JsonKey(name: 'is_active')
  final bool active;
  @override
  final int parent;
  @override
  final String description;
  @override
  @JsonKey(name: 'is_approved')
  final bool approved;
  @override
  final String creator;
  @override
  final Topic root;
  @override
  final int groupCount;

  @override
  String toString() {
    return 'Topic(id: $id, name: $name, image: $image, active: $active, parent: $parent, description: $description, approved: $approved, creator: $creator, root: $root, groupCount: $groupCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Topic &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.image, image) ||
                const DeepCollectionEquality().equals(other.image, image)) &&
            (identical(other.active, active) ||
                const DeepCollectionEquality().equals(other.active, active)) &&
            (identical(other.parent, parent) ||
                const DeepCollectionEquality().equals(other.parent, parent)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.approved, approved) ||
                const DeepCollectionEquality()
                    .equals(other.approved, approved)) &&
            (identical(other.creator, creator) ||
                const DeepCollectionEquality()
                    .equals(other.creator, creator)) &&
            (identical(other.root, root) ||
                const DeepCollectionEquality().equals(other.root, root)) &&
            (identical(other.groupCount, groupCount) ||
                const DeepCollectionEquality()
                    .equals(other.groupCount, groupCount)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(image) ^
      const DeepCollectionEquality().hash(active) ^
      const DeepCollectionEquality().hash(parent) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(approved) ^
      const DeepCollectionEquality().hash(creator) ^
      const DeepCollectionEquality().hash(root) ^
      const DeepCollectionEquality().hash(groupCount);

  @JsonKey(ignore: true)
  @override
  _$TopicCopyWith<_Topic> get copyWith =>
      __$TopicCopyWithImpl<_Topic>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_TopicToJson(this);
  }
}

abstract class _Topic implements Topic {
  factory _Topic(
      {int id,
      String name,
      String image,
      @JsonKey(name: 'is_active') bool active,
      int parent,
      String description,
      @JsonKey(name: 'is_approved') bool approved,
      String creator,
      Topic root,
      int groupCount}) = _$_Topic;

  factory _Topic.fromJson(Map<String, dynamic> json) = _$_Topic.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get image;
  @override
  @JsonKey(name: 'is_active')
  bool get active;
  @override
  int get parent;
  @override
  String get description;
  @override
  @JsonKey(name: 'is_approved')
  bool get approved;
  @override
  String get creator;
  @override
  Topic get root;
  @override
  int get groupCount;
  @override
  @JsonKey(ignore: true)
  _$TopicCopyWith<_Topic> get copyWith;
}
