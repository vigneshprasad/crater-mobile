import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/package_request_entity.dart';

part 'package_request_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

@JsonSerializable()
class PackageRequestModel extends PackageRequest {
  final int? quantity;
  final String? requestedBy;
  final int? package;
  final int? pointsApplied;
  final PackageRequestStatus? status;

  const PackageRequestModel({
    this.quantity,
    this.requestedBy,
    this.package,
    this.pointsApplied,
    this.status,
  }) : super(
          quantity: quantity,
          requestedBy: requestedBy,
          package: package,
          pointsApplied: pointsApplied,
          status: status,
        );

  factory PackageRequestModel.fromJson(Map<String, dynamic> json) =>
      _$PackageRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$PackageRequestModelToJson(this);
}
