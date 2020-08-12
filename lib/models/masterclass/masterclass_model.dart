import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'masterclass_model.g.dart';

@HiveType(typeId: 5)
@JsonSerializable()
class MasterClass {
  @HiveField(0)
  final int pk;

  @HiveField(1)
  final String author;

  @HiveField(2)
  @JsonKey(nullable: true)
  final String cover;

  @HiveField(3)
  final String created;

  @HiveField(4)
  final String description;

  @HiveField(5)
  final String position;

  @HiveField(6)
  @JsonKey(nullable: true)
  final String thumbnail;

  @HiveField(7)
  final List<VideoTag> tags;

  MasterClass({
    this.pk,
    this.author,
    this.cover,
    this.created,
    this.description,
    this.position,
    this.thumbnail,
    this.tags,
  });

  factory MasterClass.fromJson(Map<String, dynamic> json) =>
      _$MasterClassFromJson(json);
  Map<String, dynamic> toJson() => _$MasterClassToJson(this);
}

@JsonSerializable()
class VideoTag {
  final int pk;
  final String name;

  VideoTag({
    this.pk,
    this.name,
  });

  factory VideoTag.fromJson(Map<String, dynamic> json) =>
      _$VideoTagFromJson(json);
  Map<String, dynamic> toJson() => _$VideoTagToJson(this);
}
