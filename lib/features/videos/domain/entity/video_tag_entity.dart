import 'package:hive/hive.dart';

class VideoTag extends HiveObject {
  final int pk;
  final String name;

  VideoTag({
    this.pk,
    this.name,
  });
}
