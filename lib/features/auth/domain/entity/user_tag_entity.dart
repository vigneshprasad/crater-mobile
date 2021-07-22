import 'package:hive/hive.dart';

class UserTag extends HiveObject {
  final String name;
  final int? pk;

  UserTag({
    required this.name,
    this.pk,
  });
}
