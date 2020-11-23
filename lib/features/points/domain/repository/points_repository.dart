import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entity/points_entity.dart';
import '../entity/points_faq_entity.dart';
import '../entity/points_rule_entity.dart';

abstract class PointsRepository {
  Future<Either<Failure, Points>> getSelfUserPoints();
  Future<Either<Failure, List<PointsFaq>>> getPointsFaqList();
  Future<Either<Failure, List<PointsRule>>> getPointsRuleList();
}
