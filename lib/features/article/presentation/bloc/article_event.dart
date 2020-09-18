part of 'article_bloc.dart';

abstract class ArticleEvent extends Equatable {
  const ArticleEvent();

  @override
  List<Object> get props => [];
}

class ArticlesGetPageRequestStarted extends ArticleEvent {
  final int page;
  final int pageSize;

  const ArticlesGetPageRequestStarted({
    @required this.page,
    @required this.pageSize,
  });

  @override
  List<Object> get props => [
        page,
        pageSize,
      ];
}
