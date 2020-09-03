import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:worknetwork/features/community/domain/entity/post_entity.dart';
import 'package:worknetwork/features/community/domain/usecase/delete_post_usecase.dart';
import 'package:worknetwork/features/community/domain/usecase/get_posts_page_usecase.dart';

part 'community_event.dart';
part 'community_state.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  final UCGetPostsPage getPostsPage;
  final UCDeletePost deletePost;

  CommunityBloc({
    @required this.getPostsPage,
    @required this.deletePost,
  }) : super(const CommunityInitial());

  @override
  Stream<CommunityState> mapEventToState(
    CommunityEvent event,
  ) async* {
    if (event is GetCommunityPageRequestStarted) {
      yield* _mapGetPageRequestToState(event);
    } else if (event is DeletePostRequestStarted) {
      yield* _mapDeletePostRequestToState(event);
    }
  }

  Stream<CommunityState> _mapGetPageRequestToState(
      GetCommunityPageRequestStarted event) async* {
    yield const CommunityRequestLoading();
    final resutsOrError = await getPostsPage(GetPostPageParams(
      page: event.page,
      pageSize: event.pageSize,
    ));

    yield resutsOrError.fold(
      (failure) => CommunityRequestError(error: failure),
      (results) => CommunityGetPageResponseReceived(
        currentPage: results.currentPage,
        count: results.count,
        posts: results.results,
        pages: results.pages,
        fromCache: results.fromCache,
      ),
    );
  }

  Stream<CommunityState> _mapDeletePostRequestToState(
      DeletePostRequestStarted event) async* {
    yield const CommunityRequestLoading();
    final resultOrError =
        await deletePost(DeletePostParams(postId: event.postId));

    yield resultOrError.fold(
      (failure) => CommunityRequestError(error: failure),
      (id) => CommunityPostDeletedSuccess(postId: id),
    );
  }
}
