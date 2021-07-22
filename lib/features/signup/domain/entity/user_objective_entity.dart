import 'package:hive/hive.dart';

class UserObjective extends HiveObject {
  final int pk;
  final String? icon;
  final String? name;

  UserObjective({
    required this.pk,
    this.icon,
    this.name,
  });
}
