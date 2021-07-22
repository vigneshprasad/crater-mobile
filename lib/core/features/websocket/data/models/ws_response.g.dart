// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ws_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WSResponse _$WSResponseFromJson(Map<String, dynamic> json) {
  return WSResponse(
    type: _$enumDecode(_$WSResponseTypeEnumMap, json['type'],
        unknownValue: WSResponseType.unknowType),
  );
}

Map<String, dynamic> _$WSResponseToJson(WSResponse instance) =>
    <String, dynamic>{
      'type': _$WSResponseTypeEnumMap[instance.type],
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
  WSResponseType.loadAllUsers: 'all_users',
  WSResponseType.loadChatMessages: 'get_user_messages',
  WSResponseType.getUserNotification: 'user_notification',
  WSResponseType.getUserMessage: 'user_message',
  WSResponseType.getSearchAllUsers: 'search_all_users',
  WSResponseType.starUser: 'star_user',
  WSResponseType.unstarUser: 'unstar_user',
  WSResponseType.unknowType: 'unknown_type',
};
