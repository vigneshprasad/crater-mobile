// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ws_requests.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllUserRequestOptions _$AllUserRequestOptionsFromJson(
    Map<String, dynamic> json) {
  return AllUserRequestOptions(
    filter: json['filter'] as String,
    page: json['page'] as int,
    search: json['search'] as String,
    allPages: json['allPages'] as int,
    strict: json['strict'] as bool,
  );
}

Map<String, dynamic> _$AllUserRequestOptionsToJson(
        AllUserRequestOptions instance) =>
    <String, dynamic>{
      'filter': instance.filter,
      'page': instance.page,
      'search': instance.search,
      'allPages': instance.allPages,
      'strict': instance.strict,
    };

WSAllUsersRequest _$WSAllUsersRequestFromJson(Map<String, dynamic> json) {
  return WSAllUsersRequest(
    type: _$enumDecodeNullable(_$WSRequestTypeEnumMap, json['type']),
    message: json['message'] == null
        ? null
        : AllUserRequestOptions.fromJson(
            json['message'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$WSAllUsersRequestToJson(WSAllUsersRequest instance) =>
    <String, dynamic>{
      'message': instance.message,
      'type': _$WSRequestTypeEnumMap[instance.type],
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
  WSRequestType.getAllUsers: 'get_all_users',
  WSRequestType.setUserChat: 'set_user_chat',
  WSRequestType.sendMessageToUser: 'send_user_message_to_user',
};

SetChatRequestOptions _$SetChatRequestOptionsFromJson(
    Map<String, dynamic> json) {
  return SetChatRequestOptions(
    user: json['user'] as String,
    page: json['page'] as int,
  );
}

Map<String, dynamic> _$SetChatRequestOptionsToJson(
        SetChatRequestOptions instance) =>
    <String, dynamic>{
      'user': instance.user,
      'page': instance.page,
    };

WSSetChatUserRequest _$WSSetChatUserRequestFromJson(Map<String, dynamic> json) {
  return WSSetChatUserRequest(
    type: _$enumDecodeNullable(_$WSRequestTypeEnumMap, json['type']),
    message: json['message'] == null
        ? null
        : SetChatRequestOptions.fromJson(
            json['message'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$WSSetChatUserRequestToJson(
        WSSetChatUserRequest instance) =>
    <String, dynamic>{
      'message': instance.message,
      'type': _$WSRequestTypeEnumMap[instance.type],
    };

WSSendMessageToUserRequest _$WSSendMessageToUserFromJson(
    Map<String, dynamic> json) {
  return WSSendMessageToUserRequest(
    type: _$enumDecodeNullable(_$WSRequestTypeEnumMap, json['type']),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$WSSendMessageToUserToJson(
        WSSendMessageToUserRequest instance) =>
    <String, dynamic>{
      'message': instance.message,
      'type': _$WSRequestTypeEnumMap[instance.type],
    };
