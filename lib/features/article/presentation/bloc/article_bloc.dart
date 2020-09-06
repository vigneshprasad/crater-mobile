import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:worknetwork/features/article/domain/entity/article_entity.dart';
import 'package:worknetwork/features/article/domain/usecase/get_articles_page_usecase.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final UCGetArticlesPage getArticles;

  ArticleBloc({
    @required this.getArticles,
  }) : super(const ArticleInitial());

  @override
  Stream<ArticleState> mapEventToState(
    ArticleEvent event,
  ) async* {
    if (event is ArticlesGetPageRequestStarted) {
      yield* _mapArticleRequestToState(event);
    }
  }

  Stream<ArticleState> _mapArticleRequestToState(
      ArticlesGetPageRequestStarted event) async* {
    yield const ArticlesRequestLoading();
    final resultsOrError = await getArticles(GetArticlesPageParams(
      page: event.page,
      pageSize: event.pageSize,
    ));

    yield resultsOrError.fold(
      (failure) => ArticleRequestError(error: failure),
      (response) => ArticlesPageRequestLoaded(
        articles: response.results,
        count: response.count,
        pages: response.pages,
        fromCache: response.fromCache,
        currentPage: response.currentPage,
      ),
    );
  }
}
