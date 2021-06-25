import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/api_result/api_result.dart';
import '../../../../../core/error/failures/failures.dart';
import '../../../data/repository/conversation_repository_impl.dart';
import '../../../domain/entity/topic_entity/topic_entity.dart';

final topicsStateProvider =
    StateNotifierProvider((ref) => TopicsStateNotifier(ref));

final articleTopicsStateProiver =
    StateNotifierProvider((ref) => ArticleTopicsStateNotifier(ref));

final topicSuggestionStateProvider =
    StateNotifierProvider((ref) => TopicSuggestionStateNotifier(ref));

class TopicsStateNotifier extends StateNotifier<ApiResult<List<Topic>>> {
  final ProviderReference ref;

  TopicsStateNotifier(
    this.ref,
  ) : super(ApiResult<List<Topic>>.loading()) {
    getTopicsList();
  }

  Future<Either<Failure, List<Topic>>> getTopicsList() async {
    state = ApiResult<List<Topic>>.loading();
    final response =
        await ref.read(conversationRepositoryProvider).getAllTopics(null);

    state = response.fold(
      (failure) => ApiResult<List<Topic>>.error(failure),
      (topics) => ApiResult<List<Topic>>.data(topics),
    );

    return response;
  }
}

class TopicSuggestionStateNotifier extends StateNotifier<ApiResult<Topic>> {
  final ProviderReference ref;

  TopicSuggestionStateNotifier(
    this.ref,
  ) : super(ApiResult<Topic>.data(null));

  Future<Either<Failure, Topic>> postTopicSuggestion(String topic) async {
    state = ApiResult<Topic>.loading();
    final response = await ref
        .read(conversationRepositoryProvider)
        .postTopicSuggestion(topic);

    state = response.fold(
      (failure) => ApiResult<Topic>.error(failure),
      (topic) => ApiResult<Topic>.data(topic),
    );

    return response;
  }
}

class ArticleTopicsStateNotifier extends StateNotifier<ApiResult<List<Topic>>> {
  final ProviderReference ref;

  ArticleTopicsStateNotifier(this.ref)
      : super(ApiResult<List<Topic>>.loading()) {
    getAllArticleTopcs();
  }

  Future<Either<Failure, List<Topic>>> getAllArticleTopcs() async {
    state = ApiResult<List<Topic>>.loading();
    final response =
        await ref.read(conversationRepositoryProvider).getAllArticleTopics();

    state = response.fold(
      (failure) => ApiResult<List<Topic>>.error(failure),
      (topics) => ApiResult<List<Topic>>.data(topics),
    );

    return response;
  }
}
