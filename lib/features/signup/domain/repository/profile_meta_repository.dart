import 'package:dartz/dartz.dart';
import 'package:worknetwork/core/error/failures/failures.dart';
import 'package:worknetwork/features/auth/domain/entity/user_profile_entity.dart';
import 'package:worknetwork/features/signup/data/models/profile_extra_meta/profile_extra_meta.dart';

abstract class ProfileMetaRepository {
  Future<Either<Failure, ProfileExtraMeta>> getProfileExtraInfoMeta(int id);
  Future<Either<Failure, UserProfile>> postUserProfile(
      Map<String, dynamic> data);
}
