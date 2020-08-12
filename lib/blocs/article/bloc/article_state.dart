part of 'article_bloc.dart';

abstract class ArticleState extends Equatable {
  const ArticleState();
}

class ArticleInitial extends ArticleState {
  @override
  List<Object> get props => [];
}

class ArticleGetLoading extends ArticleState {
  final bool loading;

  const ArticleGetLoading({this.loading = true});

  @override
  List<Object> get props => [loading];
}

class ArticleGetSuccess extends ArticleState {
  final GetArticlesListResponse response;

  const ArticleGetSuccess({this.response});

  @override
  List<Object> get props => [response];
}

class ArticleGetError extends ArticleState {
  final dynamic error;

  const ArticleGetError({this.error});

  @override
  List<Object> get props => [error];
}
