import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/api_result/api_result.dart';
import '../../../../../core/error/failures/failures.dart';
import '../../../data/repository/roundtable_repository_impl.dart';
import '../../../domain/entity/topic_entity/topic_entity.dart';
import '../../../domain/repository/roundtable_repository.dart';
import '../roundtable_tab/roundtable_tab.dart';

final topicsStateProvider = StateNotifierProvider.autoDispose
    .family<TopicsFilterNotifier, RoundTablePageType>((ref, type) {
  final repository = ref.read(roundtableRepositoryProvider);
  return TopicsFilterNotifier(repository, type);
});

class TopicsFilterNotifier extends StateNotifier<ApiResult<List<Topic>>> {
  final RoundTablePageType _type;
  final RoundTableRepository _repository;

  TopicsFilterNotifier(this._repository, this._type)
      : super(ApiResult<List<Topic>>.loading());

  Future<Either<Failure, List<Topic>>> getRoundTableCategories(
      RoundTablePageType type) async {
    Either<Failure, List<Topic>> responseOrError;

    state = ApiResult<List<Topic>>.loading();

    if (type == RoundTablePageType.all) {
      responseOrError = await _repository.getAllRootTopicsForGroups();
    } else {
      responseOrError = await _repository.getAllRootTopicsForGroups();
    }

    state = responseOrError.fold(
      (failure) => ApiResult<List<Topic>>.error(failure),
      (categories) => ApiResult<List<Topic>>.data(categories),
    );

    return responseOrError;
  }
}
