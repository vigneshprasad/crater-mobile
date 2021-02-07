import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:worknetwork/features/roundtable/data/repository/roundtable_repository_impl.dart';
import 'package:worknetwork/features/roundtable/domain/repository/roundtable_repository.dart';

import '../../../../../core/api_result/api_result.dart';
import '../../../../../core/error/failures/failures.dart';
import '../../../domain/entity/roundtable_entity/roundtable_entity.dart';

final roundTableStateNotifierProvier = StateNotifierProvider.autoDispose
    .family<RoundTableNotifier, int>((ref, id) {
  final RoundTableRepository repository =
      ref.read(roundtableRepositoryProvider);
  return RoundTableNotifier(repository, id);
});

class RoundTableNotifier extends StateNotifier<ApiResult<RoundTable>> {
  final int _id;
  final RoundTableRepository _repository;

  RoundTableNotifier(this._repository, this._id)
      : super(ApiResult<RoundTable>.loading()) {
    getRoundTable(_id);
  }

  Future<Either<Failure, RoundTable>> getRoundTable(int id) async {
    state = ApiResult<RoundTable>.loading();
    final response = await _repository.retrieveRoundTable(id);

    state = response.fold(
      (failure) => ApiResult<RoundTable>.error(failure),
      (table) => ApiResult<RoundTable>.data(table),
    );

    return response;
  }
}
