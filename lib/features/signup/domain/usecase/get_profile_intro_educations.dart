import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/profile_intro_meta.dart';
import '../repository/profile_intro_repository.dart';

class UCGetProfileIntroEducations
    implements AsyncUseCase<List<ProfileIntroMeta>, NoParams> {
  final ProfileIntroRepository repository;

  UCGetProfileIntroEducations(this.repository);

  @override
  Future<Either<Failure, List<ProfileIntroMeta>>> call(NoParams params) {
    return repository.getEducations();
  }
}
