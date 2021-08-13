import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/package_entity.dart';
import '../repository/rewards_repository.dart';

class UCGetPackagesList implements AsyncUseCase<List<Package>, NoParams> {
  final RewardsRepository repository;

  UCGetPackagesList({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<Package>>> call(NoParams params) {
    return repository.getPackagesList();
  }
}
