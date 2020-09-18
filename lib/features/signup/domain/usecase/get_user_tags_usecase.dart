import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../../../auth/domain/entity/user_tag_entity.dart';
import '../repository/signup_repository.dart';

class UCGetUserTags implements AsyncUseCase<List<UserTag>, NoParams> {
  final SignupRepository repository;

  UCGetUserTags(this.repository);

  @override
  Future<Either<Failure, List<UserTag>>> call(NoParams params) {
    return repository.getUserTags();
  }
}
