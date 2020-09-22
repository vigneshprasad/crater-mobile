part of 'article_bloc.dart';

abstract class ArticleEvent extends Equatable {
  const ArticleEvent();

  @override
  List<Object> get props => [];
}

class ArticlesGetPageRequestStarted extends ArticleEvent {
  final int page;
  final int pageSize;
  final int websiteTag;

  const ArticlesGetPageRequestStarted({
    @required this.page,
    @required this.pageSize,
    @required this.websiteTag,
  });

  @override
  List<Object> get props => [
        page,
        pageSize,
        websiteTag,
      ];
}

class GetArticleWebsitesRequestStarted extends ArticleEvent {
  const GetArticleWebsitesRequestStarted();
}
