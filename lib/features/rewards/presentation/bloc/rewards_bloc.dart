import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:worknetwork/core/analytics/analytics.dart';
import 'package:worknetwork/core/analytics/anlytics_events.dart';
import 'package:worknetwork/core/usecase/aysnc_usecase.dart';
import 'package:worknetwork/features/rewards/data/models/package_model.dart';
import 'package:worknetwork/features/rewards/data/models/package_request_model.dart';
import 'package:worknetwork/features/rewards/domain/entity/package_request_entity.dart';
import 'package:worknetwork/features/rewards/domain/usecases/get_package_usecase.dart';
import 'package:worknetwork/features/rewards/domain/usecases/post_package_request_usecase.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entity/package_entity.dart';
import '../../domain/usecases/get_packages_list_usecase.dart';

part 'rewards_event.dart';
part 'rewards_state.dart';

class RewardsBloc extends Bloc<RewardsEvent, RewardsState> {
  final Analytics analytics;
  final UCGetPackagesList getPackagesList;
  final UCGetPackage getPackage;
  final UCPostPackageRequest packageRequest;

  RewardsBloc({
    @required this.getPackagesList,
    @required this.getPackage,
    @required this.packageRequest,
    @required this.analytics,
  })  : assert(getPackagesList != null),
        assert(getPackage != null),
        assert(packageRequest != null),
        assert(analytics != null),
        super(const RewardsInitial());

  @override
  Stream<RewardsState> mapEventToState(
    RewardsEvent event,
  ) async* {
    if (event is RewardsGetPackageListStarted) {
      yield* _mapGetPackageListToState(event);
    } else if (event is RewardsGetPackageStarted) {
      yield* _mapGetPackageToState(event);
    } else if (event is RewardsPostPackageRequestStarted) {
      yield* _mapPostPackageRequestToState(event);
    }
  }

  Stream<RewardsState> _mapGetPackageListToState(
      RewardsGetPackageListStarted event) async* {
    yield const RewardsGetPackageListLoading();
    final responseOrerror = await getPackagesList(NoParams());

    yield responseOrerror.fold(
      (failure) => RewardsRequestError(error: failure),
      (packages) => RewardsPackageListLoaded(packages: packages),
    );
  }

  Stream<RewardsState> _mapGetPackageToState(
      RewardsGetPackageStarted event) async* {
    yield const RewardsGetPackageLoading();
    final responseOrError =
        await getPackage(GetPackageParams(packageId: event.packageId));

    yield responseOrError.fold(
      (failure) => RewardsRequestError(error: failure),
      (package) {
        final model = package as PackageModel;
        analytics.trackEvent(
          eventName: AnalyticsEvents.packageDetailViewed,
          properties: model.toJson(),
        );
        return RewardsGetPackageLoaded(package: package);
      },
    );
  }

  Stream<RewardsState> _mapPostPackageRequestToState(
      RewardsPostPackageRequestStarted event) async* {
    yield const RewardsPostPackageRequstLoading();

    final responseOrError = await packageRequest(
      PostPackageRequestParams(
        package: event.package,
        quantity: event.quantity,
        pointsApplied: event.pointsApplied,
        requestedBy: event.requestedBy,
      ),
    );

    yield responseOrError.fold(
      (failure) => RewardsRequestError(error: failure),
      (packageRequest) {
        analytics.trackEvent(
          eventName: AnalyticsEvents.packagePurchased,
          properties: {
            'package': event.package,
            'points_applied': packageRequest.pointsApplied,
          },
        );
        return RewardsPostPackageRequestLoaded(packageRequest: packageRequest);
      },
    );
  }
}
