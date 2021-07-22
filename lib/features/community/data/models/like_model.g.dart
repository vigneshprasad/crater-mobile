// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikeModel _$LikeModelFromJson(Map<String, dynamic> json) {
  return LikeModel(
    likeCount: json['like_count'] as int?,
    pk: json['pk'] as int,
    post: json['post'] as int?,
    user: json['user'] as String?,
  );
}

Map<String, dynamic> _$LikeModelToJson(LikeModel instance) => <String, dynamic>{
      'like_count': instance.likeCount,
      'pk': instance.pk,
      'post': instance.post,
      'user': instance.user,
    };
