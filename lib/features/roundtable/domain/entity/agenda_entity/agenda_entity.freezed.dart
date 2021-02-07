// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'agenda_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Agenda _$AgendaFromJson(Map<String, dynamic> json) {
  return _Agenda.fromJson(json);
}

/// @nodoc
class _$AgendaTearOff {
  const _$AgendaTearOff();

// ignore: unused_element
  _Agenda call(
      {String name,
      String creator,
      Category category,
      @JsonKey(name: 'is_approved') bool isApproved,
      @JsonKey(name: 'is_active') bool isActive}) {
    return _Agenda(
      name: name,
      creator: creator,
      category: category,
      isApproved: isApproved,
      isActive: isActive,
    );
  }

// ignore: unused_element
  Agenda fromJson(Map<String, Object> json) {
    return Agenda.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Agenda = _$AgendaTearOff();

/// @nodoc
mixin _$Agenda {
  String get name;
  String get creator;
  Category get category;
  @JsonKey(name: 'is_approved')
  bool get isApproved;
  @JsonKey(name: 'is_active')
  bool get isActive;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $AgendaCopyWith<Agenda> get copyWith;
}

/// @nodoc
abstract class $AgendaCopyWith<$Res> {
  factory $AgendaCopyWith(Agenda value, $Res Function(Agenda) then) =
      _$AgendaCopyWithImpl<$Res>;
  $Res call(
      {String name,
      String creator,
      Category category,
      @JsonKey(name: 'is_approved') bool isApproved,
      @JsonKey(name: 'is_active') bool isActive});

  $CategoryCopyWith<$Res> get category;
}

/// @nodoc
class _$AgendaCopyWithImpl<$Res> implements $AgendaCopyWith<$Res> {
  _$AgendaCopyWithImpl(this._value, this._then);

  final Agenda _value;
  // ignore: unused_field
  final $Res Function(Agenda) _then;

  @override
  $Res call({
    Object name = freezed,
    Object creator = freezed,
    Object category = freezed,
    Object isApproved = freezed,
    Object isActive = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed ? _value.name : name as String,
      creator: creator == freezed ? _value.creator : creator as String,
      category: category == freezed ? _value.category : category as Category,
      isApproved:
          isApproved == freezed ? _value.isApproved : isApproved as bool,
      isActive: isActive == freezed ? _value.isActive : isActive as bool,
    ));
  }

  @override
  $CategoryCopyWith<$Res> get category {
    if (_value.category == null) {
      return null;
    }
    return $CategoryCopyWith<$Res>(_value.category, (value) {
      return _then(_value.copyWith(category: value));
    });
  }
}

/// @nodoc
abstract class _$AgendaCopyWith<$Res> implements $AgendaCopyWith<$Res> {
  factory _$AgendaCopyWith(_Agenda value, $Res Function(_Agenda) then) =
      __$AgendaCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      String creator,
      Category category,
      @JsonKey(name: 'is_approved') bool isApproved,
      @JsonKey(name: 'is_active') bool isActive});

  @override
  $CategoryCopyWith<$Res> get category;
}

/// @nodoc
class __$AgendaCopyWithImpl<$Res> extends _$AgendaCopyWithImpl<$Res>
    implements _$AgendaCopyWith<$Res> {
  __$AgendaCopyWithImpl(_Agenda _value, $Res Function(_Agenda) _then)
      : super(_value, (v) => _then(v as _Agenda));

  @override
  _Agenda get _value => super._value as _Agenda;

  @override
  $Res call({
    Object name = freezed,
    Object creator = freezed,
    Object category = freezed,
    Object isApproved = freezed,
    Object isActive = freezed,
  }) {
    return _then(_Agenda(
      name: name == freezed ? _value.name : name as String,
      creator: creator == freezed ? _value.creator : creator as String,
      category: category == freezed ? _value.category : category as Category,
      isApproved:
          isApproved == freezed ? _value.isApproved : isApproved as bool,
      isActive: isActive == freezed ? _value.isActive : isActive as bool,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Agenda implements _Agenda {
  _$_Agenda(
      {this.name,
      this.creator,
      this.category,
      @JsonKey(name: 'is_approved') this.isApproved,
      @JsonKey(name: 'is_active') this.isActive});

  factory _$_Agenda.fromJson(Map<String, dynamic> json) =>
      _$_$_AgendaFromJson(json);

  @override
  final String name;
  @override
  final String creator;
  @override
  final Category category;
  @override
  @JsonKey(name: 'is_approved')
  final bool isApproved;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;

  @override
  String toString() {
    return 'Agenda(name: $name, creator: $creator, category: $category, isApproved: $isApproved, isActive: $isActive)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Agenda &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.creator, creator) ||
                const DeepCollectionEquality()
                    .equals(other.creator, creator)) &&
            (identical(other.category, category) ||
                const DeepCollectionEquality()
                    .equals(other.category, category)) &&
            (identical(other.isApproved, isApproved) ||
                const DeepCollectionEquality()
                    .equals(other.isApproved, isApproved)) &&
            (identical(other.isActive, isActive) ||
                const DeepCollectionEquality()
                    .equals(other.isActive, isActive)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(creator) ^
      const DeepCollectionEquality().hash(category) ^
      const DeepCollectionEquality().hash(isApproved) ^
      const DeepCollectionEquality().hash(isActive);

  @JsonKey(ignore: true)
  @override
  _$AgendaCopyWith<_Agenda> get copyWith =>
      __$AgendaCopyWithImpl<_Agenda>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_AgendaToJson(this);
  }
}

abstract class _Agenda implements Agenda {
  factory _Agenda(
      {String name,
      String creator,
      Category category,
      @JsonKey(name: 'is_approved') bool isApproved,
      @JsonKey(name: 'is_active') bool isActive}) = _$_Agenda;

  factory _Agenda.fromJson(Map<String, dynamic> json) = _$_Agenda.fromJson;

  @override
  String get name;
  @override
  String get creator;
  @override
  Category get category;
  @override
  @JsonKey(name: 'is_approved')
  bool get isApproved;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(ignore: true)
  _$AgendaCopyWith<_Agenda> get copyWith;
}
