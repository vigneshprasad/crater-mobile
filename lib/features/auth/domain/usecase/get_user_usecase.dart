import 'package:worknetwork/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:worknetwork/core/usecase/aysnc_usecase.dart';
import 'package:worknetwork/features/auth/domain/entity/user_entity.dart';
import 'package:worknetwork/features/auth/domain/repository/auth_repository.dart';

class UCGetUser implements AsyncUseCase<User, NoParams> {
  final AuthRepository repository;

  UCGetUser(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) {
    return repository.getUser();
  }
}
