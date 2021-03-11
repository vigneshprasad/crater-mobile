import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:worknetwork/core/error/failures.dart';
import 'package:worknetwork/features/auth/domain/entity/user_profile_entity.dart';
import 'package:worknetwork/features/signup/domain/entity/profile_intro_meta.dart';

abstract class ProfileIntroRepository {
  Future<Either<Failure, List<String>>> getProfileIntroQuestions();
  Future<Either<Failure, List<ProfileIntroMeta>>> getCompanies();
  Future<Either<Failure, List<ProfileIntroMeta>>> getSectors();
  Future<Either<Failure, List<ProfileIntroMeta>>> getExperiences();
  Future<Either<Failure, List<ProfileIntroMeta>>> getEducations();
  Future<Either<Failure, UserProfile>> postUserProfileIntro(
      Map<String, dynamic> body, File photo);
}
