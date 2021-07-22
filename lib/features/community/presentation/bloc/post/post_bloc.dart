import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entity/comment_entity.dart';
import '../../../domain/entity/post_entity.dart';
import '../../../domain/usecase/create_comment_post_usercase.dart';
import '../../../domain/usecase/get_comments_page_usecase.dart';
import '../../../domain/usecase/get_post_usecase.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final UCGetPost getPost;
  final UCGetCommentsPage getCommentsPage;
  final UCCreateCommentPost createComment;

  PostBloc({
    required this.getPost,
    required this.getCommentsPage,
    required this.createComment,
  }) : super(const PostInitial());

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    if (event is GetPostRequestStarted) {
      yield* _mapPostRequestToState(event);
    } else if (event is GetPostCommentsRequest) {
      yield* _mapGetCommentsToState(event);
    } else if (event is CreatePostRequestStarted) {
      yield* _mapCreateCommentToState(event);
    }
  }

  Stream<PostState> _mapPostRequestToState(GetPostRequestStarted event) async* {
    yield const PostRequestLoading();
    final responseOrError = await getPost(GetPostParams(postId: event.postId));

    yield responseOrError.fold(
      (failure) => PostRequestError(error: failure),
      (post) => PostResponseLoaded(post: post!),
    );
  }

  Stream<PostState> _mapGetCommentsToState(
      GetPostCommentsRequest event) async* {
    yield const PostRequestLoading();
    final responseOrError = await getCommentsPage(
      GetCommentPageParams(
        page: event.page,
        pageSize: event.pageSize,
        postId: event.postId,
      ),
    );

    yield responseOrError.fold(
      (failure) => PostRequestError(error: failure),
      (response) => GetPostCommentsResponseLoaded(
        comments: response.results,
        currentPage: response.currentPage,
        count: response.count,
        fromCache: response.fromCache,
        pages: response.pages,
      ),
    );
  }

  Stream<PostState> _mapCreateCommentToState(
      CreatePostRequestStarted event) async* {
    yield const PostRequestLoading();
    final createdOrError = await createComment(CreateCommentPostParams(
      post: event.postId,
      message: event.message,
      creator: event.creator,
    ));

    yield createdOrError.fold(
      (failure) => PostRequestError(error: failure),
      (comment) => CreatePostResponseReceived(comment: comment),
    );
  }
}
