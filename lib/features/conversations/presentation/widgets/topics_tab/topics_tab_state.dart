import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/api_result/api_result.dart';
import '../../../../../core/error/failures/failures.dart';
import '../../../data/repository/conversation_repository_impl.dart';
import '../../../domain/entity/topic_entity/topic_entity.dart';

final topicsStateProvider =
    StateNotifierProvider<TopicsStateNotifier, ApiResult<List<Topic>>>(
        (ref) => TopicsStateNotifier(ref));

final amaTopicsStateProvider =
    StateNotifierProvider<AMATopicsStateNotifier, ApiResult<List<Topic>>>(
        (ref) => AMATopicsStateNotifier(ref));

final articleTopicsStateProiver =
    StateNotifierProvider<ArticleTopicsStateNotifier, ApiResult<List<Topic>>>(
        (ref) => ArticleTopicsStateNotifier(ref));

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

class AMATopicsStateNotifier extends StateNotifier<ApiResult<List<Topic>>> {
  final ProviderReference ref;

  AMATopicsStateNotifier(
    this.ref,
  ) : super(ApiResult<List<Topic>>.loading()) {
    getTopicsList();
  }

  Future<Either<Failure, List<Topic>>> getTopicsList() async {
    state = ApiResult<List<Topic>>.loading();
    final response =
        await ref.read(conversationRepositoryProvider).getAllAMATopics();

    state = response.fold(
      (failure) => ApiResult<List<Topic>>.error(failure),
      (topics) => ApiResult<List<Topic>>.data(topics),
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
