import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecase/aysnc_usecase.dart';
import '../../domain/entity/article_entity.dart';
import '../../domain/entity/article_website_entity.dart';
import '../../domain/usecase/get_article_websites_usecase.dart';
import '../../domain/usecase/get_articles_page_usecase.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final UCGetArticlesPage getArticles;
  final UCGetArticleWebsites getArticleWebsites;

  ArticleBloc({
    required this.getArticles,
    required this.getArticleWebsites,
  }) : super(const ArticleInitial());

  @override
  Stream<ArticleState> mapEventToState(
    ArticleEvent event,
  ) async* {
    if (event is ArticlesGetPageRequestStarted) {
      yield* _mapArticleRequestToState(event);
    } else if (event is GetArticleWebsitesRequestStarted) {
      yield* _mapArticleWebsitesToState(event);
    }
  }

  Stream<ArticleState> _mapArticleRequestToState(
      ArticlesGetPageRequestStarted event) async* {
    yield const ArticlesRequestLoading();
    final resultsOrError = await getArticles(GetArticlesPageParams(
      page: event.page,
      pageSize: event.pageSize,
      websiteTag: event.websiteTag,
    ));

    yield resultsOrError.fold(
      (failure) => ArticleRequestError(error: failure),
      (response) => ArticlesPageRequestLoaded(
        websiteTag: event.websiteTag,
        articles: response.results,
        count: response.count,
        pages: response.pages,
        fromCache: response.fromCache,
        currentPage: response.currentPage,
      ),
    );
  }

  Stream<ArticleState> _mapArticleWebsitesToState(
      GetArticleWebsitesRequestStarted event) async* {
    yield const ArticlesRequestLoading();

    final websitesOrError = await getArticleWebsites(NoParams());

    yield websitesOrError.fold(
      (failure) => ArticleRequestError(error: failure),
      (websites) => ArticleWebsitesRequestLoaded(websites: websites),
    );
  }
}
