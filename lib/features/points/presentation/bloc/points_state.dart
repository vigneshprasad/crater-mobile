part of 'points_bloc.dart';

@immutable
class PointsState extends Equatable {
  final bool loading;
  final int points;
  final dynamic error;
  const PointsState({
    @required this.points,
    @required this.loading,
    @required this.error,
  });

  @override
  List<Object> get props => [points, loading, error];

  PointsState copyWith({
    bool loading,
    int points,
    dynamic error,
  }) {
    return PointsState(
      loading: loading ?? this.loading,
      points: points ?? this.points,
      error: error ?? this.error,
    );
  }
}

class PointsInitial extends PointsState {
  const PointsInitial()
      : super(
          points: 0,
          loading: false,
          error: null,
        );
}

class PointsValueUpdateRecieved extends PointsState {
  const PointsValueUpdateRecieved({
    @required int points,
  }) : super(
          points: points,
          loading: false,
          error: null,
        );
}
