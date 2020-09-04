part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  final bool loading;
  final dynamic error;

  const PostState({
    @required this.loading,
    @required this.error,
  });

  @override
  List<Object> get props => [
        loading,
        error,
      ];
}

class PostInitial extends PostState {
  const PostInitial()
      : super(
          loading: false,
          error: null,
        );
}

class PostRequestLoading extends PostState {
  const PostRequestLoading()
      : super(
          loading: true,
          error: null,
        );
}

class PostRequestError extends PostState {
  const PostRequestError({
    @required dynamic error,
  }) : super(
          loading: false,
          error: error,
        );
}

class PostResponseLoaded extends PostState {
  final Post post;

  const PostResponseLoaded({
    @required this.post,
  }) : super(
          loading: false,
          error: null,
        );

  @override
  List<Object> get props => [
        loading,
        error,
        post,
      ];
}

class GetPostCommentsResponseLoaded extends PostState {
  final List<Comment> comments;
  final bool fromCache;
  final int currentPage;
  final int pages;
  final int count;

  const GetPostCommentsResponseLoaded({
    @required this.comments,
    @required this.fromCache,
    @required this.currentPage,
    @required this.pages,
    @required this.count,
  }) : super(
          loading: false,
          error: null,
        );

  @override
  List<Object> get props => [
        loading,
        error,
        comments,
        fromCache,
        currentPage,
        pages,
        count,
      ];
}

class CreatePostResponseReceived extends PostState {
  final Comment comment;

  const CreatePostResponseReceived({
    @required this.comment,
  }) : super(
          loading: false,
          error: null,
        );

  @override
  List<Object> get props => [
        loading,
        error,
        comment,
      ];
}
