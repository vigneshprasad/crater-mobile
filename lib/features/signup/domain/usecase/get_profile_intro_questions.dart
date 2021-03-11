import 'package:dartz/dartz.dart';
import 'package:worknetwork/features/signup/domain/repository/profile_intro_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';

class UCGetProfileIntroQuestions
    implements AsyncUseCase<List<String>, NoParams> {
  final ProfileIntroRepository repository;

  UCGetProfileIntroQuestions(this.repository);

  @override
  Future<Either<Failure, List<String>>> call(NoParams params) {
    return repository.getProfileIntroQuestions();
  }
}
