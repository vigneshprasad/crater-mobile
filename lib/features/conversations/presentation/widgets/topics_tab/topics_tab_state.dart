import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/api_result/api_result.dart';
import '../../../../../core/error/failures/failures.dart';
import '../../../data/repository/conversation_repository_impl.dart';
import '../../../domain/entity/topic_entity/topic_entity.dart';

final topicsStateProvider =
    StateNotifierProvider((ref) => TopicsStateNotifier(ref.read));

final articleTopicsStateProiver =
    StateNotifierProvider((ref) => ArticleTopicsStateNotifier(ref.read));

class TopicsStateNotifier extends StateNotifier<ApiResult<List<Topic>>> {
  final Reader read;

  TopicsStateNotifier(
    this.read,
  ) : super(ApiResult<List<Topic>>.loading()) {
    getTopicsList();
  }

  Future<Either<Failure, List<Topic>>> getTopicsList() async {
    state = ApiResult<List<Topic>>.loading();
    final response =
        await read(conversationRepositoryProvider).getAllTopics(null);

    state = response.fold(
      (failure) => ApiResult<List<Topic>>.error(failure),
      (topics) => ApiResult<List<Topic>>.data(topics),
    );

    return response;
  }
}

class ArticleTopicsStateNotifier extends StateNotifier<ApiResult<List<Topic>>> {
  final Reader read;

  ArticleTopicsStateNotifier(this.read)
      : super(ApiResult<List<Topic>>.loading()) {
    getAllArticleTopcs();
  }

  Future<Either<Failure, List<Topic>>> getAllArticleTopcs() async {
    state = ApiResult<List<Topic>>.loading();
    final response =
        await read(conversationRepositoryProvider).getAllArticleTopics();

    state = response.fold(
      (failure) => ApiResult<List<Topic>>.error(failure),
      (topics) => ApiResult<List<Topic>>.data(topics),
    );

    return response;
  }
}
