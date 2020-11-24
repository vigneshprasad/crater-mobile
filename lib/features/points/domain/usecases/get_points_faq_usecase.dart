import 'package:worknetwork/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:worknetwork/core/usecase/aysnc_usecase.dart';
import 'package:worknetwork/features/points/domain/entity/points_faq_entity.dart';
import 'package:worknetwork/features/points/domain/repository/points_repository.dart';

class UCGetPointsFaq implements AsyncUseCase<List<PointsFaq>, NoParams> {
  final PointsRepository repository;

  UCGetPointsFaq(this.repository);

  @override
  Future<Either<Failure, List<PointsFaq>>> call(NoParams params) {
    return repository.getPointsFaqList();
  }
}
