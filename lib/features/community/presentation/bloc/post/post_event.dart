part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class GetPostRequestStarted extends PostEvent {
  final int postId;

  const GetPostRequestStarted({
    required this.postId,
  });

  @override
  List<Object> get props => [postId];
}

class GetPostCommentsRequest extends PostEvent {
  final int postId;
  final int page;
  final int pageSize;

  const GetPostCommentsRequest({
    required this.postId,
    required this.page,
    required this.pageSize,
  });

  @override
  List<Object> get props => [
        postId,
        page,
        pageSize,
      ];
}

class CreatePostRequestStarted extends PostEvent {
  final String creator;
  final String message;
  final int postId;

  const CreatePostRequestStarted({
    required this.creator,
    required this.message,
    required this.postId,
  });

  @override
  List<Object> get props => [
        creator,
        message,
        postId,
      ];
}
