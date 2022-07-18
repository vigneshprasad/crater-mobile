import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/error/exceptions.dart';
import 'package:worknetwork/core/error/failures/failures.dart';
import 'package:worknetwork/features/signup/data/datasources/signup_remote_datasource.dart';
import 'package:worknetwork/features/signup/data/models/api_models.dart';
import 'package:worknetwork/features/signup/domain/repository/signup_repository.dart';

final signupRepositoryProvider = Provider<SignupRepository>((ref) {
  final remoteDataSource = ref.read(signupRemoteDatasourceProvider);
  return SignupRepositoryImpl(remoteDataSource);
});

class SignupRepositoryImpl implements SignupRepository {
  final SignupRemoteDatasource remoteDatasource;

  SignupRepositoryImpl(this.remoteDatasource);

  @override
  Future<Either<Failure, PostPhoneNumberResponse>> postNewPhoneNumber(
    String phoneNumber,
  ) async {
    try {
      final response = await remoteDatasource.postNewPhoneNumber(phoneNumber);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, PostPhoneNumberResponse>> postSmsCode(
    String smsCode,
  ) async {
    try {
      final response = await remoteDatasource.postSmsCode(smsCode);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }
}
