part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class GetCommentsPageRequeststarted extends CommentEvent {
  final int postId;
  final int page;
  final int pageSize;

  const GetCommentsPageRequeststarted({
    required this.postId,
    required this.page,
    required this.pageSize,
  });
}
