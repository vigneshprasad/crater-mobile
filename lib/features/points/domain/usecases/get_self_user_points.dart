import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/points_entity.dart';
import '../repository/points_repository.dart';

class UCGetSelfUserPoints implements AsyncUseCase<Points, NoParams> {
  final PointsRepository repository;

  UCGetSelfUserPoints({
    required this.repository,
  });

  @override
  Future<Either<Failure, Points>> call(NoParams params) {
    return repository.getSelfUserPoints();
  }
}
