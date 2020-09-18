// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requests.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllUsersRequestParams _$GetAllUsersRequestParamsFromJson(
    Map<String, dynamic> json) {
  return GetAllUsersRequestParams(
    filter: json['filter'] as String,
    page: json['page'] as int,
    search: json['search'] as String,
    strict: json['strict'] as bool,
    latestMessages: json['latest_messages'] as String,
  );
}

Map<String, dynamic> _$GetAllUsersRequestParamsToJson(
        GetAllUsersRequestParams instance) =>
    <String, dynamic>{
      'filter': instance.filter,
      'page': instance.page,
      'search': instance.search,
      'latest_messages': instance.latestMessages,
      'strict': instance.strict,
    };

GetAllChatUsersRequest _$GetAllChatUsersRequestFromJson(
    Map<String, dynamic> json) {
  return GetAllChatUsersRequest(
    type: _$enumDecodeNullable(_$WSRequestTypeEnumMap, json['type'],
        unknownValue: WSRequestType.unknownValue),
    message: json['message'] == null
        ? null
        : GetAllUsersRequestParams.fromJson(
            json['message'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GetAllChatUsersRequestToJson(
        GetAllChatUsersRequest instance) =>
    <String, dynamic>{
      'type': _$WSRequestTypeEnumMap[instance.type],
      'message': instance.message,
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

const _$WSRequestTypeEnumMap = {
  WSRequestType.setUserChat: 'set_user_chat',
  WSRequestType.sendMessageToUser: 'send_user_message_to_user',
  WSRequestType.userIsTyping: 'user_is_typing',
  WSRequestType.readUserMessages: 'user_read_user_messages',
  WSRequestType.getAllUsers: 'get_all_users',
  WSRequestType.starChatUser: 'star_user',
  WSRequestType.unStarChatUser: 'unstar_user',
  WSRequestType.unknownValue: 'unknownValue',
};

StarChatUserRequestParams _$StarChatUserRequestParamsFromJson(
    Map<String, dynamic> json) {
  return StarChatUserRequestParams(
    user: json['user'] as String,
  );
}

Map<String, dynamic> _$StarChatUserRequestParamsToJson(
        StarChatUserRequestParams instance) =>
    <String, dynamic>{
      'user': instance.user,
    };

StarChatUserRequest _$StarChatUserRequestFromJson(Map<String, dynamic> json) {
  return StarChatUserRequest(
    type: _$enumDecodeNullable(_$WSRequestTypeEnumMap, json['type'],
        unknownValue: WSRequestType.unknownValue),
    message: json['message'] == null
        ? null
        : StarChatUserRequestParams.fromJson(
            json['message'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$StarChatUserRequestToJson(
        StarChatUserRequest instance) =>
    <String, dynamic>{
      'type': _$WSRequestTypeEnumMap[instance.type],
      'message': instance.message,
    };

UnStarChatUserRequest _$UnStarChatUserRequestFromJson(
    Map<String, dynamic> json) {
  return UnStarChatUserRequest(
    type: _$enumDecodeNullable(_$WSRequestTypeEnumMap, json['type'],
        unknownValue: WSRequestType.unknownValue),
    message: json['message'] == null
        ? null
        : StarChatUserRequestParams.fromJson(
            json['message'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UnStarChatUserRequestToJson(
        UnStarChatUserRequest instance) =>
    <String, dynamic>{
      'type': _$WSRequestTypeEnumMap[instance.type],
      'message': instance.message,
    };
