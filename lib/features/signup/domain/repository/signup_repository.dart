import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../auth/domain/entity/user_tag_entity.dart';
import '../../data/models/api_models.dart';
import '../entity/user_objective_entity.dart';

abstract class SignupRepository {
  Future<Either<Failure, List<UserObjective>>> getUserObjectives();
  Future<Either<Failure, List<UserTag>>> getUserTags();
  Future<Either<Failure, PostPhoneNumberResponse>> postNewPhoneNumber(
      String phoneNumber);
  Future<Either<Failure, PostPhoneNumberResponse>> postSmsCode(String smsCode);
}
