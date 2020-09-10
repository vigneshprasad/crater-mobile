import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entity/user_objective_entity.dart';
import '../../domain/repository/signup_repository.dart';
import '../datasources/signup_remote_datasource.dart';

class SignupRepositoryImpl implements SignupRepository {
  final SignupRemoteDatasource remoteDatasource;

  SignupRepositoryImpl(this.remoteDatasource);

  @override
  Future<Either<Failure, List<UserObjective>>> getUserObjectives() async {
    try {
      final response = await remoteDatasource.getUserObjectivesFromRemote();
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }
}
