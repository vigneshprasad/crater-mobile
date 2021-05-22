import 'package:dartz/dartz.dart';
import 'package:worknetwork/features/auth/domain/usecase/patch_user_usecase.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../repository/profile_intro_repository.dart';

class UCGetProfileIntroQuestions
    implements AsyncUseCase<List<String>, PatchUserParams> {
  final ProfileIntroRepository repository;

  UCGetProfileIntroQuestions(this.repository);

  @override
  Future<Either<Failure, List<String>>> call(PatchUserParams params) {
    return repository.getProfileIntroQuestions(params.user);
  }
}
