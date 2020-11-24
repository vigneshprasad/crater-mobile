import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

enum PackageRequestStatus {
  @JsonValue("requested")
  requested,
  @JsonValue("in_progress")
  inProgress,
  @JsonValue("rejected")
  rejected,
  @JsonValue("completed")
  completed,
}

class PackageRequest extends Equatable {
  final int quantity;
  final String requestedBy;
  final int package;
  final int pointsApplied;
  final PackageRequestStatus status;

  const PackageRequest({
    this.quantity,
    this.requestedBy,
    this.package,
    this.pointsApplied,
    this.status,
  });

  @override
  List<Object> get props => [
        quantity,
        requestedBy,
        package,
        pointsApplied,
        status,
      ];
}
