part of 'points_bloc.dart';

abstract class PointsEvent extends Equatable {
  const PointsEvent();

  @override
  List<Object> get props => [];
}

class GetUserPointsStarted extends PointsEvent {
  const GetUserPointsStarted();
}

class GetPointsFaqStarted extends PointsEvent {
  const GetPointsFaqStarted();
}

class GetPointsRulesStarted extends PointsEvent {
  const GetPointsRulesStarted();
}
