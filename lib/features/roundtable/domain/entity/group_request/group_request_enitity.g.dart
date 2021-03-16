// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_request_enitity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GroupRequest _$_$_GroupRequestFromJson(Map<String, dynamic> json) {
  return _$_GroupRequest(
    pk: json['pk'] as int,
    group: json['group'] as int,
    groupDetail: json['group_detail'] == null
        ? null
        : RoundTable.fromJson(json['group_detail'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_GroupRequestToJson(_$_GroupRequest instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'group': instance.group,
      'group_detail': instance.groupDetail,
    };
