import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../auth/domain/entity/user_tag_entity.dart';
import '../entity/user_objective_entity.dart';

abstract class SignupRepository {
  Future<Either<Failure, List<UserObjective>>> getUserObjectives();
  Future<Either<Failure, List<UserTag>>> getUserTags();
}
