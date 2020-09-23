import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/analytics/analytics.dart';
import '../../../../../core/analytics/anlytics_events.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/aysnc_usecase.dart';
import '../../../../auth/data/models/user_model.dart';
import '../../../../auth/domain/entity/user_entity.dart';
import '../../../../auth/domain/usecase/patch_user_usecase.dart';
import '../../../domain/entity/user_objective_entity.dart';
import '../../../domain/usecase/get_user_objectives.dart';

part 'objectives_event.dart';
part 'objectives_state.dart';

class ObjectivesBloc extends Bloc<ObjectivesEvent, ObjectivesState> {
  final UCGetUserObjectives getUserObjectives;
  final UCPatchUser patchUser;
  final Analytics analytics;

  ObjectivesBloc({
    @required this.getUserObjectives,
    @required this.patchUser,
    @required this.analytics,
  })  : assert(getUserObjectives != null),
        assert(patchUser != null),
        assert(analytics != null),
        super(const ObjectivesInitial());

  @override
  Stream<ObjectivesState> mapEventToState(
    ObjectivesEvent event,
  ) async* {
    if (event is GetObjectivesRequestStarted) {
      yield* _mapGetUserObjectivesToState(event);
    } else if (event is PostObjectivesRequestStarted) {
      yield* _mapPostObjectiveToState(event);
    }
  }

  Stream<ObjectivesState> _mapGetUserObjectivesToState(
      GetObjectivesRequestStarted event) async* {
    yield const ObjectivesRequestLoading();
    final objectivesOrError = await getUserObjectives(NoParams());

    yield objectivesOrError.fold(
      (failure) => ObjectivesRequestError(error: failure),
      (objectives) => ObjectivesRequestLoaded(objectives: objectives),
    );
  }

  Stream<ObjectivesState> _mapPostObjectiveToState(
      PostObjectivesRequestStarted event) async* {
    yield const ObjectivesRequestLoading();
    final user =
        UserModel(objectives: event.objectives.map((e) => e.pk).toList());
    final updateOrError = await patchUser(PatchUserParams(user: user));

    yield updateOrError.fold(
      (failure) => ObjectivesRequestError(error: failure),
      (updated) {
        final properties = {
          "objectives": event.objectives.map((e) => e.name).toList(),
        };
        analytics.identify(properties: properties);
        analytics.trackEvent(
            eventName: AnalyticsEvents.objectivesAdded, properties: properties);
        return PatchObjectivesRequestLoaded(user: updated);
      },
    );
  }
}
