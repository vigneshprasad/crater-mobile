import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/all.dart';

import '../../../../../core/api_result/api_result.dart';
import '../../../../../core/error/failures/failures.dart';
import '../../../data/repository/roundtable_repository_impl.dart';
import '../../../domain/entity/category_entity/category_entity.dart';
import '../../../domain/repository/roundtable_repository.dart';
import '../roundtable_tab/roundtable_tab.dart';

final categoriesStateProvider = StateNotifierProvider.autoDispose
    .family<CategoryNotifier, RoundTablePageType>((ref, type) {
  final repository = ref.read(roundtableRepositoryProvider);
  return CategoryNotifier(repository, type);
});

class CategoryNotifier extends StateNotifier<ApiResult<List<Category>>> {
  final RoundTablePageType _type;
  final RoundTableRepository _repository;

  CategoryNotifier(this._repository, this._type)
      : super(ApiResult<List<Category>>.loading());

  Future<Either<Failure, List<Category>>> getRoundTableCategories(
      RoundTablePageType type) async {
    Either<Failure, List<Category>> responseOrError;

    state = ApiResult<List<Category>>.loading();

    switch (type) {
      case RoundTablePageType.all:
        responseOrError = await _repository.getAllRoundTableCategories();
        break;
      case RoundTablePageType.user:
        responseOrError = await _repository.getMyRoundTableCategories();
        break;
    }

    state = responseOrError.fold(
      (failure) => ApiResult<List<Category>>.error(failure),
      (categories) => ApiResult<List<Category>>.data(categories),
    );

    return responseOrError;
  }
}
