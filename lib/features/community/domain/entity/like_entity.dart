import 'package:hive/hive.dart';

class Like extends HiveObject {
  final int likeCount;
  final int pk;
  final int post;
  final String user;

  Like({
    this.likeCount,
    this.pk,
    this.post,
    this.user,
  });
}
