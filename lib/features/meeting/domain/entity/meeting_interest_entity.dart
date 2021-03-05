import 'package:hive/hive.dart';

class MeetingInterest extends HiveObject {
  final int pk;
  final String name;
  final String icon;

  MeetingInterest({
    this.pk,
    this.name,
    this.icon,
  });
}
