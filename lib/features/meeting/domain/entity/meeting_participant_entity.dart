import 'package:hive/hive.dart';

class MeetingParticipant extends HiveObject {
  final String pk;
  final String name;
  final String introduction;
  final String photo;

  MeetingParticipant({
    this.pk,
    this.name,
    this.introduction,
    this.photo,
  });
}
