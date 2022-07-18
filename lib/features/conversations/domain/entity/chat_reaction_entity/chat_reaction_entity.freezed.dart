// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'chat_reaction_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatReaction _$ChatReactionFromJson(Map<String, dynamic> json) {
  return _ChatReaction.fromJson(json);
}

/// @nodoc
mixin _$ChatReaction {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get file => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatReactionCopyWith<ChatReaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatReactionCopyWith<$Res> {
  factory $ChatReactionCopyWith(
          ChatReaction value, $Res Function(ChatReaction) then) =
      _$ChatReactionCopyWithImpl<$Res>;
  $Res call(
      {int? id, String? name, String? image, String? file, bool isActive});
}

/// @nodoc
class _$ChatReactionCopyWithImpl<$Res> implements $ChatReactionCopyWith<$Res> {
  _$ChatReactionCopyWithImpl(this._value, this._then);

  final ChatReaction _value;
  // ignore: unused_field
  final $Res Function(ChatReaction) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? image = freezed,
    Object? file = freezed,
    Object? isActive = freezed,
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
      file: file == freezed
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: isActive == freezed
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_ChatReactionCopyWith<$Res>
    implements $ChatReactionCopyWith<$Res> {
  factory _$$_ChatReactionCopyWith(
          _$_ChatReaction value, $Res Function(_$_ChatReaction) then) =
      __$$_ChatReactionCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? id, String? name, String? image, String? file, bool isActive});
}

/// @nodoc
class __$$_ChatReactionCopyWithImpl<$Res>
    extends _$ChatReactionCopyWithImpl<$Res>
    implements _$$_ChatReactionCopyWith<$Res> {
  __$$_ChatReactionCopyWithImpl(
      _$_ChatReaction _value, $Res Function(_$_ChatReaction) _then)
      : super(_value, (v) => _then(v as _$_ChatReaction));

  @override
  _$_ChatReaction get _value => super._value as _$_ChatReaction;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? image = freezed,
    Object? file = freezed,
    Object? isActive = freezed,
  }) {
    return _then(_$_ChatReaction(
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
      file: file == freezed
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: isActive == freezed
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChatReaction implements _ChatReaction {
  const _$_ChatReaction(
      {this.id, this.name, this.image, this.file, this.isActive = true});

  factory _$_ChatReaction.fromJson(Map<String, dynamic> json) =>
      _$$_ChatReactionFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? image;
  @override
  final String? file;
  @override
  @JsonKey()
  final bool isActive;

  @override
  String toString() {
    return 'ChatReaction(id: $id, name: $name, image: $image, file: $file, isActive: $isActive)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChatReaction &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.image, image) &&
            const DeepCollectionEquality().equals(other.file, file) &&
            const DeepCollectionEquality().equals(other.isActive, isActive));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(image),
      const DeepCollectionEquality().hash(file),
      const DeepCollectionEquality().hash(isActive));

  @JsonKey(ignore: true)
  @override
  _$$_ChatReactionCopyWith<_$_ChatReaction> get copyWith =>
      __$$_ChatReactionCopyWithImpl<_$_ChatReaction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChatReactionToJson(this);
  }
}

abstract class _ChatReaction implements ChatReaction {
  const factory _ChatReaction(
      {final int? id,
      final String? name,
      final String? image,
      final String? file,
      final bool isActive}) = _$_ChatReaction;

  factory _ChatReaction.fromJson(Map<String, dynamic> json) =
      _$_ChatReaction.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get image;
  @override
  String? get file;
  @override
  bool get isActive;
  @override
  @JsonKey(ignore: true)
  _$$_ChatReactionCopyWith<_$_ChatReaction> get copyWith =>
      throw _privateConstructorUsedError;
}
