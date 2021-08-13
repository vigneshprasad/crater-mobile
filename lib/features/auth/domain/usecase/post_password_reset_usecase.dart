import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../repository/auth_repository.dart';

class UCPostPasswordReset
    implements AsyncUseCase<String, PostPasswordResetParams> {
  final AuthRepository repository;

  UCPostPasswordReset(this.repository);

  @override
  Future<Either<Failure, String>> call(PostPasswordResetParams params) {
    return repository.postPasswordReset(params.email);
  }
}

class PostPasswordResetParams extends Equatable {
  final String email;

  const PostPasswordResetParams({
    required this.email,
  });

  @override
  List<Object> get props => [email];
}
