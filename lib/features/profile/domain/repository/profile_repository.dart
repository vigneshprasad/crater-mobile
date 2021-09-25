import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entity/profile_entity/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile>> retrieveProfile(String profileId);
  Future<Either<Failure, List<Profile>>> retrieveProfiles(
    String tags,
    int page,
    int pageSize,
    String userId,
  );
  Future<Either<Failure, List<Profile>>> retrieveConnections(String profileId);
}
