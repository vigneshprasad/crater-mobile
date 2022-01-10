part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  final bool loading;
  final Object? error;

  const PostState({
    required this.loading,
    required this.error,
  });

  @override
  List<Object> get props => error != null
      ? [
          loading,
          error!,
        ]
      : [loading];
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
    required dynamic error,
  }) : super(
          loading: false,
          error: error,
        );
}

class PostResponseLoaded extends PostState {
  final Post post;

  const PostResponseLoaded({
    required this.post,
  }) : super(
          loading: false,
          error: null,
        );

  @override
  List<Object> get props => error != null
      ? [
          loading,
          error!,
          post,
        ]
      : [
          loading,
          post,
        ];
}

class GetPostCommentsResponseLoaded extends PostState {
  final List<Comment>? comments;
  final bool fromCache;
  final int? currentPage;
  final int? pages;
  final int? count;

  const GetPostCommentsResponseLoaded({
    this.comments,
    required this.fromCache,
    this.currentPage,
    this.pages,
    this.count,
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
    if (comments != null) temp.add(comments!);
    if (currentPage != null) temp.add(currentPage!);
    if (pages != null) temp.add(pages!);
    if (count != null) temp.add(count!);
    return temp;
  }
}

class CreatePostResponseReceived extends PostState {
  final Comment comment;

  const CreatePostResponseReceived({
    required this.comment,
  }) : super(
          loading: false,
          error: null,
        );

  @override
  List<Object> get props => error != null
      ? [
          loading,
          error!,
          comment,
        ]
      : [
          loading,
          comment,
        ];
}
