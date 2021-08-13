import 'package:hive/hive.dart';

import 'video_tag_entity.dart';

class Video extends HiveObject {
  final int? pk;
  final String? author;
  final String? cover;
  final String? created;
  final String? description;
  final String? position;
  final String? thumbnail;
  final List<VideoTag>? tags;

  Video({
    this.pk,
    this.author,
    this.cover,
    this.created,
    this.description,
    this.position,
    this.thumbnail,
    this.tags,
  });
}
