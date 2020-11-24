part of 'rewards_bloc.dart';

abstract class RewardsEvent extends Equatable {
  const RewardsEvent();

  @override
  List<Object> get props => [];
}

class RewardsGetPackageListStarted extends RewardsEvent {
  const RewardsGetPackageListStarted();
}

class RewardsGetPackageStarted extends RewardsEvent {
  final int packageId;

  const RewardsGetPackageStarted({
    @required this.packageId,
  });

  @override
  List<Object> get props => [packageId];
}

class RewardsPostPackageRequestStarted extends RewardsEvent {
  final int quantity;
  final String requestedBy;
  final int package;
  final int pointsApplied;

  const RewardsPostPackageRequestStarted({
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
