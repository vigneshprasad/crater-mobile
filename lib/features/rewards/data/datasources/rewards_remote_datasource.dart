import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../api/rewards/rewards_api_service.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entity/package_entity.dart';
import '../../domain/entity/package_request_entity.dart';
import '../models/package_model.dart';
import '../models/package_request_model.dart';

abstract class RewardsRemoteDatasource {
  Future<List<Package>> getPackageListFromRemote();
  Future<Package> getPackageFromRemote(int packageId);
  Future<PackageRequest> postPackageRequestToRemote(
    int quantity,
    String requestedBy,
    int package,
    int pointsApplied,
  );
}

class RewardsRemoteDatasourceImpl implements RewardsRemoteDatasource {
  final RewardsApiService apiService;

  RewardsRemoteDatasourceImpl({
    @required this.apiService,
  });

  @override
  Future<List<Package>> getPackageListFromRemote() async {
    final response = await apiService.getPackagesList();
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Iterable;
      return json
          .map((item) => PackageModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<Package> getPackageFromRemote(int packageId) async {
    final response = await apiService.getPackage(packageId);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return PackageModel.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<PackageRequest> postPackageRequestToRemote(
    int quantity,
    String requestedBy,
    int package,
    int pointsApplied,
  ) async {
    final body = {
      'quantity': quantity,
      'requested_by': requestedBy,
      'package': package,
      'point_applied': pointsApplied,
    };
    final response = await apiService.postPackageRequest(body);
    if (response.statusCode == 201) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return PackageRequestModel.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }
}
