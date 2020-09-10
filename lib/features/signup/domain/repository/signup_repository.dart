import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entity/user_objective_entity.dart';

abstract class SignupRepository {
  Future<Either<Failure, List<UserObjective>>> getUserObjectives();
}
