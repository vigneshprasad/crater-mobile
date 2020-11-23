import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/points_rule_entity.dart';
import '../repository/points_repository.dart';

class UCGetPointsRules implements AsyncUseCase<List<PointsRule>, NoParams> {
  final PointsRepository repository;

  UCGetPointsRules(this.repository);

  @override
  Future<Either<Failure, List<PointsRule>>> call(NoParams params) {
    return repository.getPointsRuleList();
  }
}
