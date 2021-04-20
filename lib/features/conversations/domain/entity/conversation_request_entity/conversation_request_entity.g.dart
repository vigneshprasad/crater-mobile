// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ConversationRequest _$_$_ConversationRequestFromJson(
    Map<String, dynamic> json) {
  return _$_ConversationRequest(
    pk: json['pk'] as int,
    group: json['group'] as int,
    groupDetail: json['group_detail'] == null
        ? null
        : Conversation.fromJson(json['group_detail'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_ConversationRequestToJson(
        _$_ConversationRequest instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'group': instance.group,
      'group_detail': instance.groupDetail,
    };
