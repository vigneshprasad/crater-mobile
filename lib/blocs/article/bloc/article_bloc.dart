import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:worknetwork/api/articles/articles_api_service.dart';
import 'package:worknetwork/blocs/article/repo/article_repository.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepository _articleRepository = ArticleRepository();

  ArticleBloc() : super(ArticleInitial());

  @override
  Stream<ArticleState> mapEventToState(
    ArticleEvent event,
  ) async* {
    if (event is ArticleGetStarted) {
      yield* _mapArticleGetList();
    }
  }

  Stream<ArticleState> _mapArticleGetList() async* {
    try {
      yield const ArticleGetLoading();
      final response = await _articleRepository.getArticlesList();
      yield ArticleGetSuccess(response: response);
    } catch (error) {
      yield ArticleGetError(error: error);
    }
  }

  @override
  Future<void> close() {
    _articleRepository.dispose();
    return super.close();
  }
}
