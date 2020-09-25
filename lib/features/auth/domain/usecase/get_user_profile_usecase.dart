import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/user_profile_entity.dart';
import '../repository/auth_repository.dart';

class UCGetUserProfile implements AsyncUseCase<UserProfile, NoParams> {
  final AuthRepository repository;

  UCGetUserProfile(this.repository);

  @override
  Future<Either<Failure, UserProfile>> call(NoParams params) {
    return repository.getUserProfile();
  }
}
