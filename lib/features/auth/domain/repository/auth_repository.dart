import 'package:dartz/dartz.dart';
import 'package:worknetwork/core/error/failures.dart';
import 'package:worknetwork/features/auth/domain/entity/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> loginwithEmail(
      String email, String password, String osId);
  Future<Either<Failure, User>> registerwithEmail(
      String name, String email, String password, String osId);
  Future<Either<Failure, User>> authWithGoogle(String token, String osId);
  Future<Either<Failure, User>> authWithFacebook(String token, String osId);
  Future<Either<Failure, User>> authWithLinkedIn(String token, String osId);
  Future<Either<Failure, User>> authWithApple(String token, String osId);
  Future<Either<Failure, User>> getPersistedUser();
  Future<Either<Failure, User>> patchUser(User user);
}
