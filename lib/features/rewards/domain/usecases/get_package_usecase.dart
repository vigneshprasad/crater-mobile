import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/package_entity.dart';
import '../repository/rewards_repository.dart';

class UCGetPackage implements AsyncUseCase<Package, GetPackageParams> {
  final RewardsRepository repository;

  UCGetPackage(this.repository);

  @override
  Future<Either<Failure, Package>> call(GetPackageParams params) {
    return repository.getPackage(params.packageId);
  }
}

class GetPackageParams extends Equatable {
  final int packageId;

  const GetPackageParams({
    @required this.packageId,
  });

  @override
  List<Object> get props => [packageId];
}
