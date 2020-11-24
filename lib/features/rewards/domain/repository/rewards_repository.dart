import 'package:dartz/dartz.dart';
import 'package:worknetwork/features/rewards/domain/entity/package_request_entity.dart';

import '../../../../core/error/failures.dart';
import '../entity/package_entity.dart';

abstract class RewardsRepository {
  Future<Either<Failure, List<Package>>> getPackagesList();
  Future<Either<Failure, Package>> getPackage(int packageId);
  Future<Either<Failure, PackageRequest>> postPackageRequest(
    int quantity,
    String requestedBy,
    int package,
    int pointsApplied,
  );
}
