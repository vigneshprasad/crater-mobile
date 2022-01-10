import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/analytics/analytics.dart';
import '../../../../core/analytics/anlytics_events.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../../domain/entity/package_entity.dart';
import '../../domain/entity/package_request_entity.dart';
import '../../domain/usecases/get_package_usecase.dart';
import '../../domain/usecases/get_packages_list_usecase.dart';
import '../../domain/usecases/post_package_request_usecase.dart';

part 'rewards_event.dart';
part 'rewards_state.dart';

class RewardsBloc extends Bloc<RewardsEvent, RewardsState> {
  final Analytics analytics;
  final UCGetPackagesList getPackagesList;
  final UCGetPackage getPackage;
  final UCPostPackageRequest packageRequest;

  RewardsBloc({
    required this.getPackagesList,
    required this.getPackage,
    required this.packageRequest,
    required this.analytics,
  }) : super(const RewardsInitial());

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
        analytics.trackEvent(
          eventName: AnalyticsEvents.packageDetailViewed,
          properties: {
            'title': package.title,
            'max_discount': package.maxDiscount,
            'pk': package.pk,
            'points_conversion': package.pointsConversion,
            'provider': {
              'name': package.provider!.name,
            }
          },
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
