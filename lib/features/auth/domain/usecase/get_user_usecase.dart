import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

class UCGetUser implements AsyncUseCase<User, NoParams> {
  final AuthRepository repository;

  UCGetUser(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) {
    return repository.getUser();
  }
}
