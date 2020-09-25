import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/user_objective_entity.dart';
import '../repository/signup_repository.dart';

class UCGetUserObjectives
    implements AsyncUseCase<List<UserObjective>, NoParams> {
  final SignupRepository repository;

  UCGetUserObjectives(this.repository);

  @override
  Future<Either<Failure, List<UserObjective>>> call(NoParams params) {
    return repository.getUserObjectives();
  }
}
