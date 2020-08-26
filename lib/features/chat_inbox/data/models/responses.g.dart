// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllUsersResponse _$GetAllUsersResponseFromJson(Map<String, dynamic> json) {
  return GetAllUsersResponse(
    type: _$enumDecodeNullable(_$WSResponseTypeEnumMap, json['type'],
        unknownValue: WSResponseType.unknowType),
    errors: json['errors'],
    page: json['page'] as int,
    pages: json['pages'] as int,
    results: (json['results'] as List)
        ?.map((e) => e == null
            ? null
            : ChatUserModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
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

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$WSResponseTypeEnumMap = {
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
    type: _$enumDecodeNullable(_$WSResponseTypeEnumMap, json['type'],
        unknownValue: WSResponseType.unknowType),
    errors: json['errors'],
    page: json['page'] as int,
    pages: json['pages'] as int,
    results: (json['results'] as List)
        ?.map((e) => e == null
            ? null
            : ChatUserModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
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
