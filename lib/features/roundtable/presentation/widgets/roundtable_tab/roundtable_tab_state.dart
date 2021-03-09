import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/all.dart';

import '../../../../../core/api_result/api_result.dart';
import '../../../../../core/error/failures/failures.dart';
import '../../../data/repository/roundtable_repository_impl.dart';
import '../../../domain/entity/optin_entity/optin_entity.dart';
import '../../../domain/entity/roundtable_entity/roundtable_entity.dart';
import '../../../domain/repository/roundtable_repository.dart';

part 'roundtable_tab_state.freezed.dart';

final roundTableStateProvider =
    StateNotifierProvider.autoDispose<RoundTableTabStateNotifier>((ref) {
  final repository = ref.read(roundtableRepositoryProvider);
  return RoundTableTabStateNotifier(repository);
});

@freezed
abstract class MyTablesState with _$MyTablesState {
  factory MyTablesState({
    List<RoundTable> tables,
    List<Optin> optins,
  }) = _MyTablesState;
}

@freezed
abstract class RoundTableTabState with _$RoundTableTabState {
  factory RoundTableTabState({
    List<RoundTable> allTables,
    MyTablesState myTables,
  }) = _RoundTableTabState;
}

class RoundTableTabStateNotifier
    extends StateNotifier<ApiResult<RoundTableTabState>> {
  final RoundTableRepository _repository;
  RoundTableTabStateNotifier(this._repository)
      : super(ApiResult<RoundTableTabState>.loading()) {
    getRoundTableTabState();
  }

  Future<void> getRoundTableTabState() async {
    state = ApiResult<RoundTableTabState>.loading();

    final futures = [
      _repository.getAllRoundTables(),
      _repository.getAllMyRoundTables(),
      _repository.getAllMyOptins(),
    ];

    final response = await Future.wait(futures);

    for (final result in response) {
      if (result.isLeft()) {
        final failure = result.getOrElse(() => null) as Failure;
        state = ApiResult<RoundTableTabState>.error(failure);
        return;
      }
    }

    final allTables =
        response[0].getOrElse(() => <RoundTable>[]) as List<RoundTable>;
    final myTables =
        response[1].getOrElse(() => <RoundTable>[]) as List<RoundTable>;
    final optins = response[2].getOrElse(() => <Optin>[]) as List<Optin>;

    MyTablesState myTablesState;

    if (myTables.isNotEmpty || optins.isNotEmpty) {
      myTablesState = MyTablesState(
        tables: myTables,
        optins: optins,
      );
    }

    state = ApiResult<RoundTableTabState>.data(
      RoundTableTabState(
        allTables: allTables,
        myTables: myTablesState,
      ),
    );
  }
}
