import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../../../auth/domain/entity/user_profile_entity.dart';
import '../repository/profile_intro_repository.dart';

class UCPostUserProfileIntro
    implements AsyncUseCase<UserProfile, UCPostUserProfileIntroParams> {
  final ProfileIntroRepository repository;

  UCPostUserProfileIntro(this.repository);

  @override
  Future<Either<Failure, UserProfile>> call(
      UCPostUserProfileIntroParams params) {
    return repository.postUserProfileIntro(params.body, params.photo);
  }
}

class UCPostUserProfileIntroParams extends Equatable {
  final Map<String, dynamic> body;
  final File? photo;

  const UCPostUserProfileIntroParams({
    required this.body,
    this.photo,
  });

  @override
  List<Object> get props => photo != null ? [body, photo!] : [body];
}
