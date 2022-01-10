import 'package:hive/hive.dart';

class Points extends HiveObject {
  final int? points;
  final double? moneyValue;

  Points({
    this.points,
    this.moneyValue,
  });
}
