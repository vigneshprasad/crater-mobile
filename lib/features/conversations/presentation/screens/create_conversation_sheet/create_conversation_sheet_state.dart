import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/api_result/api_result.dart';
import '../../../../../core/error/failures/failures.dart';
import '../../../data/repository/conversation_repository_impl.dart';
import '../../../domain/entity/topic_entity/topic_entity.dart';

final getRootTopicsProvider = StateNotifierProvider.autoDispose<
    GetRootTopicNotifier, ApiResult<List<Topic>>>((ref) {
  return GetRootTopicNotifier(ref.read);
});

class GetRootTopicNotifier extends StateNotifier<ApiResult<List<Topic>>> {
  final Reader read;

  GetRootTopicNotifier(this.read) : super(ApiResult<List<Topic>>.loading()) {
    getAllRootTopics();
  }

  Future<Either<Failure, List<Topic>>> getAllRootTopics() async {
    state = ApiResult<List<Topic>>.loading();
    final response =
        await read(conversationRepositoryProvider).getAllTopics(null);

    state = response.fold(
      (failure) => ApiResult<List<Topic>>.error(failure),
      (topic) => ApiResult<List<Topic>>.data(topic),
    );

    return response;
  }

  Future<Either<Failure, List<Topic>>> getTopicsForParentTopic(
      int parent) async {
    state = ApiResult<List<Topic>>.loading();
    final response =
        await read(conversationRepositoryProvider).getAllTopics(parent);

    state = response.fold(
      (failure) => ApiResult<List<Topic>>.error(failure),
      (topics) => ApiResult<List<Topic>>.data(topics),
    );

    return response;
  }
}
