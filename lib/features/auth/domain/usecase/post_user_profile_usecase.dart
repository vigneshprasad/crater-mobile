import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:worknetwork/core/error/failures.dart';

import 'package:worknetwork/core/usecase/aysnc_usecase.dart';
import 'package:worknetwork/features/auth/domain/entity/user_profile_entity.dart';
import 'package:worknetwork/features/auth/domain/repository/auth_repository.dart';

class UCPostUserProfile
    implements AsyncUseCase<UserProfile, PostUserProfileParams> {
  final AuthRepository repository;

  UCPostUserProfile(this.repository);

  @override
  Future<Either<Failure, UserProfile>> call(PostUserProfileParams params) {
    return repository.postUserProfile(params.body);
  }
}

class PostUserProfileParams extends Equatable {
  final Map<String, dynamic> body;

  const PostUserProfileParams({
    this.body,
  });

  @override
  List<Object> get props => [body];
}
