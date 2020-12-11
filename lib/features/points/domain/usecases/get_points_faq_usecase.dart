import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/points_faq_entity.dart';
import '../repository/points_repository.dart';

class UCGetPointsFaq implements AsyncUseCase<List<PointsFaq>, NoParams> {
  final PointsRepository repository;

  UCGetPointsFaq(this.repository);

  @override
  Future<Either<Failure, List<PointsFaq>>> call(NoParams params) {
    return repository.getPointsFaqList();
  }
}
