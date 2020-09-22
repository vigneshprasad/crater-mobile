part of 'article_bloc.dart';

abstract class ArticleState extends Equatable {
  final bool loading;
  final dynamic error;

  const ArticleState({
    @required this.loading,
    @required this.error,
  });

  @override
  List<Object> get props => [loading, error];
}

class ArticleInitial extends ArticleState {
  const ArticleInitial()
      : super(
          loading: false,
          error: null,
        );
}

class ArticleRequestError extends ArticleState {
  const ArticleRequestError({@required dynamic error})
      : super(loading: false, error: error);
}

class ArticlesRequestLoading extends ArticleState {
  const ArticlesRequestLoading()
      : super(
          loading: true,
          error: null,
        );
}

class ArticlesPageRequestLoaded extends ArticleState {
  final int websiteTag;
  final List<Article> articles;
  final int currentPage;
  final int pages;
  final int count;
  final bool fromCache;

  const ArticlesPageRequestLoaded({
    @required this.websiteTag,
    @required this.articles,
    @required this.currentPage,
    @required this.pages,
    @required this.count,
    @required this.fromCache,
  }) : super(
          loading: false,
          error: null,
        );

  @override
  List<Object> get props => [
        loading,
        error,
        articles,
        currentPage,
        count,
        pages,
        fromCache,
      ];
}

class ArticleWebsitesRequestLoaded extends ArticleState {
  final List<ArticleWebsite> websites;

  const ArticleWebsitesRequestLoaded({
    this.websites,
  }) : super(
          loading: false,
          error: null,
        );

  @override
  List<Object> get props => [loading, error, websites];
}
