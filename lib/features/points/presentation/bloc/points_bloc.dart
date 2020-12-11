import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/usecase/aysnc_usecase.dart';
import '../../domain/entity/points_faq_entity.dart';
import '../../domain/entity/points_rule_entity.dart';
import '../../domain/usecases/get_points_faq_usecase.dart';
import '../../domain/usecases/get_points_rule_usecase.dart';
import '../../domain/usecases/get_self_user_points.dart';

part 'points_event.dart';
part 'points_state.dart';

class PointsBloc extends Bloc<PointsEvent, PointsState> {
  final UCGetSelfUserPoints getPoints;
  final UCGetPointsFaq getPointsFaq;
  final UCGetPointsRules pointsRules;

  PointsBloc({
    @required this.getPoints,
    @required this.getPointsFaq,
    @required this.pointsRules,
  })  : assert(getPoints != null),
        assert(getPointsFaq != null),
        assert(pointsRules != null),
        super(const PointsInitial());

  @override
  Stream<PointsState> mapEventToState(
    PointsEvent event,
  ) async* {
    if (event is GetUserPointsStarted) {
      yield* _mapGetUserRequestToState(event);
    } else if (event is GetPointsFaqStarted) {
      yield* _mapGetPointsFaqToState(event);
    } else if (event is GetPointsRulesStarted) {
      yield* _mapGetPointsRulesToState(event);
    }
  }

  Stream<PointsState> _mapGetUserRequestToState(
      GetUserPointsStarted event) async* {
    yield state.copyWith(loading: true);
    final pointsOrError = await getPoints(NoParams());

    yield pointsOrError.fold(
      (failure) => state.copyWith(loading: false, error: failure),
      (data) => PointsValueUpdateRecieved(
        points: data.points,
        moneyValue: data.moneyValue,
      ),
    );
  }

  Stream<PointsState> _mapGetPointsFaqToState(
      GetPointsFaqStarted event) async* {
    yield state.copyWith(loading: true);
    final responseOrError = await getPointsFaq(NoParams());

    yield responseOrError.fold(
      (failure) => state.copyWith(loading: false, error: failure),
      (faqs) => PointsFaqListLoaded(faqs: faqs),
    );
  }

  Stream<PointsState> _mapGetPointsRulesToState(PointsEvent event) async* {
    yield state.copyWith(loading: true);
    final responseOrError = await pointsRules(NoParams());

    yield responseOrError.fold(
      (failure) => state.copyWith(loading: false, error: failure),
      (rules) => PointsRulesListLoaded(rules: rules),
    );
  }
}
