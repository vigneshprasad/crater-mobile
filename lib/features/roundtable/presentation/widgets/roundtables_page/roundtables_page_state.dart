import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/all.dart';

import '../../../../../core/api_result/api_result.dart';
import '../../../../../core/error/failures/failures.dart';
import '../../../data/repository/roundtable_repository_impl.dart';
import '../../../domain/entity/category_entity/category_entity.dart';
import '../../../domain/entity/roundtable_entity/roundtable_entity.dart';
import '../../../domain/repository/roundtable_repository.dart';
import '../roundtable_tab/roundtable_tab.dart';

final roundTablesStateNotifier = StateNotifierProvider.autoDispose
    .family<RoundTablesNotifier, RoundTablePageType>((ref, type) {
  final repository = ref.read(roundtableRepositoryProvider);
  return RoundTablesNotifier(repository, type);
});

class RoundTablesNotifier extends StateNotifier<ApiResult<List<RoundTable>>> {
  final RoundTablePageType _type;
  final RoundTableRepository _repository;

  RoundTablesNotifier(this._repository, this._type)
      : super(ApiResult<List<RoundTable>>.loading()) {
    getRoundTables(_type);
  }

  Future<Either<Failure, List<RoundTable>>> getRoundTables(
      RoundTablePageType type) async {
    Either<Failure, List<RoundTable>> response;

    state = ApiResult<List<RoundTable>>.loading();

    switch (type) {
      case RoundTablePageType.all:
        response = await _repository.getAllRoundTables();
        break;
      case RoundTablePageType.user:
        response = await _repository.getAllMyRoundTables();
        break;
      case RoundTablePageType.upcoming:
        response = await _repository.getAllRoundTables();
        break;
    }

    state = response.fold(
      (failure) => ApiResult<List<RoundTable>>.error(failure),
      (tables) => ApiResult<List<RoundTable>>.data(tables),
    );

    return response;
  }

  Future<Either<Failure, List<RoundTable>>> filterRoundTables(
      Category category, RoundTablePageType type) async {
    state = ApiResult<List<RoundTable>>.loading();

    final response = await getRoundTables(type);

    state = response.fold(
      (failure) => ApiResult<List<RoundTable>>.error(failure),
      (tables) {
        final data = tables
            .where((element) => element.agenda.category == category)
            .toList();
        return ApiResult<List<RoundTable>>.data(data);
      },
    );

    return response;
  }
}
