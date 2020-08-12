part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();
}

class PostInitial extends PostState {
  @override
  List<Object> get props => [];
}

class PostGetSuccess extends PostState {
  final List<PostModel> posts;

  const PostGetSuccess(this.posts);

  @override
  List<Object> get props => [posts];
}

class PostGetLoading extends PostState {
  @override
  List<Object> get props => [];
}

class PostGetFailure extends PostState {
  final dynamic error;

  const PostGetFailure(this.error);

  @override
  List<Object> get props => [error];
}

class PostDeleteLoading extends PostState {
  @override
  List<Object> get props => [];
}

class PostDeleteCompleted extends PostState {
  @override
  List<Object> get props => [];
}

class PostDeleteFailure extends PostState {
  final dynamic error;

  const PostDeleteFailure(this.error);

  @override
  List<Object> get props => [error];
}

class PostCreateLoading extends PostState {
  @override
  List<Object> get props => [];
}

class PostCreateCompleted extends PostState {
  final PostModel post;

  const PostCreateCompleted(this.post);

  @override
  List<Object> get props => [post];
}

class PostCreateFailure extends PostState {
  final dynamic error;

  const PostCreateFailure(this.error);

  @override
  List<Object> get props => [error];
}
