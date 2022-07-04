// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllUsersResponse _$GetAllUsersResponseFromJson(Map<String, dynamic> json) {
  return GetAllUsersResponse(
    type: _$enumDecode(_$WSResponseTypeEnumMap, json['type'],
        unknownValue: WSResponseType.unknowType),
    errors: json['errors'],
    page: json['page'] as int?,
    pages: json['pages'] as int?,
    results: (json['results'] as List<dynamic>?)
        ?.map((e) => ChatUserModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$GetAllUsersResponseToJson(
        GetAllUsersResponse instance) =>
    <String, dynamic>{
      'type': _$WSResponseTypeEnumMap[instance.type],
      'errors': instance.errors,
      'page': instance.page,
      'pages': instance.pages,
      'results': instance.results,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$WSResponseTypeEnumMap = {
  WSResponseType.groupMessagesReceived: 'group_messages_received',
  WSResponseType.newGroupMessage: 'new_group_message',
  WSResponseType.loadAllUsers: 'all_users',
  WSResponseType.loadChatMessages: 'get_user_messages',
  WSResponseType.getUserNotification: 'user_notification',
  WSResponseType.getUserMessage: 'user_message',
  WSResponseType.getSearchAllUsers: 'search_all_users',
  WSResponseType.starUser: 'star_user',
  WSResponseType.unstarUser: 'unstar_user',
  WSResponseType.unknowType: 'unknown_type',
};

GetSearchAllUsersResponse _$GetSearchAllUsersResponseFromJson(
    Map<String, dynamic> json) {
  return GetSearchAllUsersResponse(
    type: _$enumDecode(_$WSResponseTypeEnumMap, json['type'],
        unknownValue: WSResponseType.unknowType),
    errors: json['errors'],
    page: json['page'] as int?,
    pages: json['pages'] as int?,
    results: (json['results'] as List<dynamic>?)
        ?.map((e) => ChatUserModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$GetSearchAllUsersResponseToJson(
        GetSearchAllUsersResponse instance) =>
    <String, dynamic>{
      'type': _$WSResponseTypeEnumMap[instance.type],
      'errors': instance.errors,
      'page': instance.page,
      'pages': instance.pages,
      'results': instance.results,
    };
