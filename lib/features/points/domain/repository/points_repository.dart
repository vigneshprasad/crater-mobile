import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entity/points_entity.dart';

abstract class PointsRepository {
  Future<Either<Failure, Points>> getSelfUserPoints();
}
