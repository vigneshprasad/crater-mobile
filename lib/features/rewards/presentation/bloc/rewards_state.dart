part of 'rewards_bloc.dart';

abstract class RewardsState extends Equatable {
  final bool loading;
  final List<Package>? packages;
  final Failure? error;
  final Package? package;
  final PackageRequest? packageRequest;

  const RewardsState({
    required this.loading,
    this.packages,
    this.error,
    this.package,
    this.packageRequest,
  });

  @override
  List<Object> get props {
    final List<Object> temp = [
      loading,
    ];

    if (packages != null) temp.add(packages!);
    if (error != null) temp.add(error!);
    if (package != null) temp.add(package!);
    if (packageRequest != null) temp.add(packageRequest!);

    return temp;
  }
}

class RewardsInitial extends RewardsState {
  const RewardsInitial()
      : super(
          loading: false,
          packages: const [],
          error: null,
          package: null,
          packageRequest: null,
        );
}

class RewardsGetPackageListLoading extends RewardsState {
  const RewardsGetPackageListLoading()
      : super(
          loading: true,
          error: null,
        );
}

class RewardsGetPackageLoading extends RewardsState {
  const RewardsGetPackageLoading()
      : super(
          loading: true,
          error: null,
        );
}

class RewardsPostPackageRequstLoading extends RewardsState {
  const RewardsPostPackageRequstLoading()
      : super(
          loading: true,
          error: null,
        );
}

class RewardsRequestError extends RewardsState {
  const RewardsRequestError({
    required Failure error,
  }) : super(
          loading: false,
          error: error,
        );
}

class RewardsPackageListLoaded extends RewardsState {
  const RewardsPackageListLoaded({
    required List<Package> packages,
  }) : super(
          loading: false,
          error: null,
          packages: packages,
        );
}

class RewardsGetPackageLoaded extends RewardsState {
  const RewardsGetPackageLoaded({
    required Package package,
  }) : super(
          loading: false,
          error: null,
          package: package,
        );
}

class RewardsPostPackageRequestLoaded extends RewardsState {
  const RewardsPostPackageRequestLoaded({
    required PackageRequest packageRequest,
  }) : super(
          loading: false,
          error: null,
          packageRequest: packageRequest,
        );
}
