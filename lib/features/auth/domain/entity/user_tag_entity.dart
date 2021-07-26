import 'package:hive/hive.dart';

class UserTag extends HiveObject {
  final String? name;
  final int? pk;

  UserTag({
    this.name,
    this.pk,
  });
}
