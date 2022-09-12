import 'package:dartz/dartz.dart';
import 'package:worknetwork/core/error/failures/failures.dart';
import 'package:worknetwork/features/auth/domain/entity/user_profile_entity.dart';
import 'package:worknetwork/features/profile/domain/entity/profile_entity/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserProfile>> retrieveProfile(String profileId);
  Future<Either<Failure, List<Profile>>> retrieveProfiles(
    String tags,
    int page,
    int pageSize,
    String userId,
  );
  Future<Either<Failure, List<Profile>>> retrieveConnections(String profileId);
}
