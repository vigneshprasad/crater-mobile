import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:worknetwork/core/error/failures.dart';
import 'package:worknetwork/features/rewards/domain/repository/rewards_repository.dart';

import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/package_request_entity.dart';

class UCPostPackageRequest
    implements AsyncUseCase<PackageRequest, PostPackageRequestParams> {
  final RewardsRepository repository;

  UCPostPackageRequest(this.repository);

  @override
  Future<Either<Failure, PackageRequest>> call(
      PostPackageRequestParams params) {
    return repository.postPackageRequest(
      params.quantity,
      params.requestedBy,
      params.package,
      params.pointsApplied,
    );
  }
}

class PostPackageRequestParams extends Equatable {
  final int quantity;
  final String requestedBy;
  final int package;
  final int pointsApplied;

  const PostPackageRequestParams({
    @required this.quantity,
    @required this.requestedBy,
    @required this.package,
    @required this.pointsApplied,
  });

  @override
  List<Object> get props => [
        quantity,
        requestedBy,
        package,
        pointsApplied,
      ];
}
