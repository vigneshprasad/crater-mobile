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
  final int? quantity;
  final String? requestedBy;
  final int? package;
  final int? pointsApplied;
  final PackageRequestStatus? status;

  const PackageRequest({
    this.quantity,
    this.requestedBy,
    this.package,
    this.pointsApplied,
    this.status,
  });

  @override
  List<Object> get props {
    final List<Object> temp = [];
    if (quantity != null) temp.add(quantity!);
    if (requestedBy != null) temp.add(requestedBy!);
    if (package != null) temp.add(package!);
    if (pointsApplied != null) temp.add(pointsApplied!);
    if (status != null) temp.add(status!);
    return temp;
  }
}
