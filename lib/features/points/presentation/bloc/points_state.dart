part of 'points_bloc.dart';

@immutable
class PointsState extends Equatable {
  final bool loading;
  final int points;
  final double moneyValue;
  final dynamic error;
  final List<PointsRule> rules;
  final List<PointsFaq> faqs;

  const PointsState({
    this.rules,
    this.faqs,
    this.points,
    this.moneyValue,
    @required this.loading,
    @required this.error,
  });

  @override
  List<Object> get props => [
        faqs,
        rules,
        moneyValue,
        points,
        loading,
        error,
      ];

  PointsState copyWith({
    bool loading,
    int points,
    dynamic error,
    double moneyValue,
    List<PointsRule> rules,
    List<PointsFaq> faqs,
  }) {
    return PointsState(
      rules: rules ?? this.rules,
      faqs: faqs ?? this.faqs,
      loading: loading ?? this.loading,
      points: points ?? this.points,
      error: error ?? this.error,
      moneyValue: moneyValue ?? this.moneyValue,
    );
  }
}

class PointsInitial extends PointsState {
  const PointsInitial()
      : super(
          rules: const [],
          faqs: const [],
          points: 0,
          loading: false,
          error: null,
          moneyValue: 0.0,
        );
}

class PointsValueUpdateRecieved extends PointsState {
  const PointsValueUpdateRecieved({
    @required int points,
    @required double moneyValue,
  }) : super(
          points: points,
          loading: false,
          error: null,
          moneyValue: moneyValue,
        );
}

class PointsFaqRequestLoading extends PointsState {
  const PointsFaqRequestLoading()
      : super(
          loading: true,
          error: null,
        );
}

class PointsFaqListLoaded extends PointsState {
  const PointsFaqListLoaded({
    @required List<PointsFaq> faqs,
  }) : super(
          faqs: faqs,
          loading: false,
          error: null,
        );
}

class PointsRulesListLoading extends PointsState {
  const PointsRulesListLoading()
      : super(
          loading: true,
          error: null,
        );
}

class PointsRulesListLoaded extends PointsState {
  const PointsRulesListLoaded({
    @required List<PointsRule> rules,
  }) : super(
          rules: rules,
          loading: false,
          error: null,
        );
}
