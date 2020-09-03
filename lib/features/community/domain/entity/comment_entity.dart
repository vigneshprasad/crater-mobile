import 'package:hive/hive.dart';

class Comment extends HiveObject {
  final int pk;
  final String message;
  final String creatorId;
  final String creatorName;
  final String creatorPhoto;
  final String created;

  Comment({
    this.pk,
    this.message,
    this.creatorId,
    this.creatorName,
    this.creatorPhoto,
    this.created,
  });
}
