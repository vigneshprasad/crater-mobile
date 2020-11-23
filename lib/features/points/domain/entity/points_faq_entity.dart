import 'package:hive/hive.dart';

class PointsFaq extends HiveObject {
  final int pk;
  final String category;
  final String question;
  final String answer;
  final int order;

  PointsFaq({
    this.pk,
    this.category,
    this.question,
    this.answer,
    this.order,
  });
}
