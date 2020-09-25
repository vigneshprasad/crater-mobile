import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/usecase/aysnc_usecase.dart';
import '../../domain/usecases/get_self_user_points.dart';

part 'points_event.dart';
part 'points_state.dart';

class PointsBloc extends Bloc<PointsEvent, PointsState> {
  final UCGetSelfUserPoints getPoints;

  PointsBloc({
    @required this.getPoints,
  }) : super(const PointsInitial());

  @override
  Stream<PointsState> mapEventToState(
    PointsEvent event,
  ) async* {
    if (event is GetUserPointsStarted) {
      yield* _mapGetUserRequestToState(event);
    }
  }

  Stream<PointsState> _mapGetUserRequestToState(
      GetUserPointsStarted event) async* {
    yield state.copyWith(loading: true);
    final pointsOrError = await getPoints(NoParams());

    yield pointsOrError.fold(
      (failure) => state.copyWith(loading: false, error: failure),
      (points) => PointsValueUpdateRecieved(points: points.points),
    );
  }
}
