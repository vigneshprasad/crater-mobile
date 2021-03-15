import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/profile_intro_meta.dart';
import '../repository/profile_intro_repository.dart';

class UCGetProfileIntroCompanies
    implements AsyncUseCase<List<ProfileIntroMeta>, NoParams> {
  final ProfileIntroRepository repository;

  UCGetProfileIntroCompanies(this.repository);

  @override
  Future<Either<Failure, List<ProfileIntroMeta>>> call(NoParams params) {
    return repository.getCompanies();
  }
}
