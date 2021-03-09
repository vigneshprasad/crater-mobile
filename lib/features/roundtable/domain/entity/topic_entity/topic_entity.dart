import 'package:freezed_annotation/freezed_annotation.dart';

part 'topic_entity.freezed.dart';
part 'topic_entity.g.dart';

@freezed
abstract class Topic with _$Topic {
  factory Topic({
    int id,
    String name,
    String image,
    @JsonKey(name: "is_active") bool active,
    int parent,
    String description,
    @JsonKey(name: "is_approved") bool approved,
    String creator,
    Topic root,
  }) = _Topic;

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);
}
