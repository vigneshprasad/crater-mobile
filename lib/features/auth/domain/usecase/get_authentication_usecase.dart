import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../repository/auth_repository.dart';

class UCGetAuthentication implements AsyncUseCase<bool, NoParams> {
  final AuthRepository repository;

  UCGetAuthentication({
    required this.repository,
  });

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return repository.getAuthenticationState();
  }
}
