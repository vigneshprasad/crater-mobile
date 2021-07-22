import 'package:hive/hive.dart';

class ProfileIntroMeta extends HiveObject {
  final int? value;
  final String? name;

  ProfileIntroMeta({
    this.value,
    this.name,
  });
}
