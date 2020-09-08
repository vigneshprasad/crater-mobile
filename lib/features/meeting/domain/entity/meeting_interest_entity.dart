import 'package:hive/hive.dart';

class MeetingInterest extends HiveObject {
  final int pk;
  final String name;

  MeetingInterest({
    this.pk,
    this.name,
  });
}
