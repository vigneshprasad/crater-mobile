import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/all.dart';

import '../../../../../core/api_result/api_result.dart';
import '../../../../../core/error/failures/failures.dart';
import '../../../data/repository/roundtable_repository_impl.dart';
import '../../../domain/entity/topic_entity/topic_entity.dart';
import '../../../domain/repository/roundtable_repository.dart';

final getRootTopicsProvider =
    StateNotifierProvider.autoDispose<GetRootTopicNotifier>((ref) {
  final repository = ref.read(roundtableRepositoryProvider);
  return GetRootTopicNotifier(repository);
});

class GetRootTopicNotifier extends StateNotifier<ApiResult<List<Topic>>> {
  final RoundTableRepository _repository;

  GetRootTopicNotifier(this._repository)
      : super(ApiResult<List<Topic>>.loading()) {
    getAllRootTopics();
  }

  Future<Either<Failure, List<Topic>>> getAllRootTopics() async {
    state = ApiResult<List<Topic>>.loading();
    final response = await _repository.getAllTopics(null);

    state = response.fold(
      (failure) => ApiResult<List<Topic>>.error(failure),
      (topic) => ApiResult<List<Topic>>.data(topic),
    );

    return response;
  }

  Future<Either<Failure, List<Topic>>> getTopicsForParentTopic(
      int parent) async {
    state = ApiResult<List<Topic>>.loading();
    final response = await _repository.getAllTopics(parent);

    state = response.fold(
      (failure) => ApiResult<List<Topic>>.error(failure),
      (topics) => ApiResult<List<Topic>>.data(topics),
    );

    return response;
  }
}
