// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'group_request_enitity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
GroupRequest _$GroupRequestFromJson(Map<String, dynamic> json) {
  return _GroupRequest.fromJson(json);
}

/// @nodoc
class _$GroupRequestTearOff {
  const _$GroupRequestTearOff();

// ignore: unused_element
  _GroupRequest call(
      {int pk,
      int group,
      @JsonKey(name: 'group_detail') RoundTable groupDetail}) {
    return _GroupRequest(
      pk: pk,
      group: group,
      groupDetail: groupDetail,
    );
  }

// ignore: unused_element
  GroupRequest fromJson(Map<String, Object> json) {
    return GroupRequest.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $GroupRequest = _$GroupRequestTearOff();

/// @nodoc
mixin _$GroupRequest {
  int get pk;
  int get group;
  @JsonKey(name: 'group_detail')
  RoundTable get groupDetail;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $GroupRequestCopyWith<GroupRequest> get copyWith;
}

/// @nodoc
abstract class $GroupRequestCopyWith<$Res> {
  factory $GroupRequestCopyWith(
          GroupRequest value, $Res Function(GroupRequest) then) =
      _$GroupRequestCopyWithImpl<$Res>;
  $Res call(
      {int pk,
      int group,
      @JsonKey(name: 'group_detail') RoundTable groupDetail});

  $RoundTableCopyWith<$Res> get groupDetail;
}

/// @nodoc
class _$GroupRequestCopyWithImpl<$Res> implements $GroupRequestCopyWith<$Res> {
  _$GroupRequestCopyWithImpl(this._value, this._then);

  final GroupRequest _value;
  // ignore: unused_field
  final $Res Function(GroupRequest) _then;

  @override
  $Res call({
    Object pk = freezed,
    Object group = freezed,
    Object groupDetail = freezed,
  }) {
    return _then(_value.copyWith(
      pk: pk == freezed ? _value.pk : pk as int,
      group: group == freezed ? _value.group : group as int,
      groupDetail: groupDetail == freezed
          ? _value.groupDetail
          : groupDetail as RoundTable,
    ));
  }

  @override
  $RoundTableCopyWith<$Res> get groupDetail {
    if (_value.groupDetail == null) {
      return null;
    }
    return $RoundTableCopyWith<$Res>(_value.groupDetail, (value) {
      return _then(_value.copyWith(groupDetail: value));
    });
  }
}

/// @nodoc
abstract class _$GroupRequestCopyWith<$Res>
    implements $GroupRequestCopyWith<$Res> {
  factory _$GroupRequestCopyWith(
          _GroupRequest value, $Res Function(_GroupRequest) then) =
      __$GroupRequestCopyWithImpl<$Res>;
  @override
  $Res call(
      {int pk,
      int group,
      @JsonKey(name: 'group_detail') RoundTable groupDetail});

  @override
  $RoundTableCopyWith<$Res> get groupDetail;
}

/// @nodoc
class __$GroupRequestCopyWithImpl<$Res> extends _$GroupRequestCopyWithImpl<$Res>
    implements _$GroupRequestCopyWith<$Res> {
  __$GroupRequestCopyWithImpl(
      _GroupRequest _value, $Res Function(_GroupRequest) _then)
      : super(_value, (v) => _then(v as _GroupRequest));

  @override
  _GroupRequest get _value => super._value as _GroupRequest;

  @override
  $Res call({
    Object pk = freezed,
    Object group = freezed,
    Object groupDetail = freezed,
  }) {
    return _then(_GroupRequest(
      pk: pk == freezed ? _value.pk : pk as int,
      group: group == freezed ? _value.group : group as int,
      groupDetail: groupDetail == freezed
          ? _value.groupDetail
          : groupDetail as RoundTable,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_GroupRequest implements _GroupRequest {
  _$_GroupRequest(
      {this.pk, this.group, @JsonKey(name: 'group_detail') this.groupDetail});

  factory _$_GroupRequest.fromJson(Map<String, dynamic> json) =>
      _$_$_GroupRequestFromJson(json);

  @override
  final int pk;
  @override
  final int group;
  @override
  @JsonKey(name: 'group_detail')
  final RoundTable groupDetail;

  @override
  String toString() {
    return 'GroupRequest(pk: $pk, group: $group, groupDetail: $groupDetail)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _GroupRequest &&
            (identical(other.pk, pk) ||
                const DeepCollectionEquality().equals(other.pk, pk)) &&
            (identical(other.group, group) ||
                const DeepCollectionEquality().equals(other.group, group)) &&
            (identical(other.groupDetail, groupDetail) ||
                const DeepCollectionEquality()
                    .equals(other.groupDetail, groupDetail)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(pk) ^
      const DeepCollectionEquality().hash(group) ^
      const DeepCollectionEquality().hash(groupDetail);

  @JsonKey(ignore: true)
  @override
  _$GroupRequestCopyWith<_GroupRequest> get copyWith =>
      __$GroupRequestCopyWithImpl<_GroupRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_GroupRequestToJson(this);
  }
}

abstract class _GroupRequest implements GroupRequest {
  factory _GroupRequest(
      {int pk,
      int group,
      @JsonKey(name: 'group_detail') RoundTable groupDetail}) = _$_GroupRequest;

  factory _GroupRequest.fromJson(Map<String, dynamic> json) =
      _$_GroupRequest.fromJson;

  @override
  int get pk;
  @override
  int get group;
  @override
  @JsonKey(name: 'group_detail')
  RoundTable get groupDetail;
  @override
  @JsonKey(ignore: true)
  _$GroupRequestCopyWith<_GroupRequest> get copyWith;
}
