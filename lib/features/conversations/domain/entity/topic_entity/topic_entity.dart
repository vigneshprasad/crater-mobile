import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../article/domain/entity/article_entity/article_entity.dart';

part 'topic_entity.freezed.dart';
part 'topic_entity.g.dart';

enum TopicType { group, ama }

@freezed
abstract class Topic with _$Topic {
  factory Topic({
    int id,
    String name,
    String image,
    @JsonKey(name: "is_active") bool active,
    int parent,
    String description,
    int article,
    @JsonKey(name: "is_approved") bool approved,
    String creator,
    Topic root,
    int groupCount,
    TopicType type,
    @JsonKey(name: "article_detail") Article articleDetail,
  }) = _Topic;

  factory Topic.fromCountJson(Map<String, dynamic> json) {
    final topic = Topic.fromJson(json['topic'] as Map<String, dynamic>)
        .copyWith(groupCount: json['group_count'] as int);
    return topic;
  }

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);
}
