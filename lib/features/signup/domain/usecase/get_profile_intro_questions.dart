import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../repository/profile_intro_repository.dart';

class UCGetProfileIntroQuestions
    implements AsyncUseCase<List<String>, NoParams> {
  final ProfileIntroRepository repository;

  UCGetProfileIntroQuestions(this.repository);

  @override
  Future<Either<Failure, List<String>>> call(NoParams params) {
    return repository.getProfileIntroQuestions();
  }
}
