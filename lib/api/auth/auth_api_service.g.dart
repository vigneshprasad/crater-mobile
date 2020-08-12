// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthEmailResponse _$AuthEmailResponseFromJson(Map<String, dynamic> json) {
  return AuthEmailResponse(
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    token: json['token'] as String,
  );
}

Map<String, dynamic> _$AuthEmailResponseToJson(AuthEmailResponse instance) =>
    <String, dynamic>{
      'user': instance.user,
      'token': instance.token,
    };
