import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:worknetwork/features/auth/data/models/user_model.dart';
import 'package:worknetwork/features/auth/domain/entity/user_entity.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/aysnc_usecase.dart';
import '../../../../auth/domain/usecase/patch_user_usecase.dart';
import '../../../domain/entity/user_objective_entity.dart';
import '../../../domain/usecase/get_user_objectives.dart';

part 'objectives_event.dart';
part 'objectives_state.dart';

class ObjectivesBloc extends Bloc<ObjectivesEvent, ObjectivesState> {
  final UCGetUserObjectives getUserObjectives;
  final UCPatchUser patchUser;

  ObjectivesBloc({
    @required this.getUserObjectives,
    @required this.patchUser,
  })  : assert(getUserObjectives != null),
        assert(patchUser != null),
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
    final user = UserModel(objectives: event.objectives);
    final updateOrError = await patchUser(PatchUserParams(user: user));

    yield updateOrError.fold(
      (failure) => ObjectivesRequestError(error: failure),
      (updated) => PatchObjectivesRequestLoaded(user: updated),
    );
  }
}
