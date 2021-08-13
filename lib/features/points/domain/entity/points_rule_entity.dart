import 'package:hive/hive.dart';

class PointsRule extends HiveObject {
  final int? pointsKey;
  final String? desc;
  final int? pointsValue;

  PointsRule({
    this.pointsKey,
    this.desc,
    this.pointsValue,
  });
}
