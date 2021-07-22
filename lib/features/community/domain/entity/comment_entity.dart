import 'package:hive/hive.dart';

class Comment extends HiveObject {
  final int pk;
  final String? message;
  final String? creatorId;
  final String? creatorName;
  final String? creatorPhoto;
  final DateTime? created;

  Comment({
    required this.pk,
    this.message,
    this.creatorId,
    this.creatorName,
    this.creatorPhoto,
    this.created,
  });
}
