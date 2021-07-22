part of 'article_bloc.dart';

abstract class ArticleState extends Equatable {
  final bool loading;
  final Object? error;

  const ArticleState({
    required this.loading,
    required this.error,
  });

  @override
  List<Object> get props => error != null ? [loading, error!] : [loading];
}

class ArticleInitial extends ArticleState {
  const ArticleInitial()
      : super(
          loading: false,
          error: null,
        );
}

class ArticleRequestError extends ArticleState {
  const ArticleRequestError({required dynamic error})
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
  final int? websiteTag;
  final List<Article>? articles;
  final int? currentPage;
  final int? pages;
  final int? count;
  final bool fromCache;

  const ArticlesPageRequestLoaded({
    this.websiteTag,
    this.articles,
    this.currentPage,
    this.pages,
    this.count,
    required this.fromCache,
  }) : super(
          loading: false,
          error: null,
        );

  @override
  List<Object> get props {
    final List<Object> temp = [
      loading,
      fromCache,
    ];

    if (articles != null) temp.add(articles!);
    if (currentPage != null) temp.add(currentPage!);
    if (pages != null) temp.add(pages!);
    if (count != null) temp.add(count!);
    if (websiteTag != null) temp.add(websiteTag!);

    return temp;
  }
}

class ArticleWebsitesRequestLoaded extends ArticleState {
  final List<ArticleWebsite> websites;

  const ArticleWebsitesRequestLoaded({
    required this.websites,
  }) : super(
          loading: false,
          error: null,
        );

  @override
  List<Object> get props =>
      error != null ? [loading, error!, websites] : [loading, websites];
}
