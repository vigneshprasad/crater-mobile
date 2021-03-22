import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entity/profile_entity/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile>> retrieveProfile(String profileId);
}
