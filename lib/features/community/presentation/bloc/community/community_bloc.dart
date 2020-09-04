import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:worknetwork/features/community/domain/entity/like_entity.dart';

import 'package:worknetwork/features/community/domain/entity/post_entity.dart';
import 'package:worknetwork/features/community/domain/usecase/create_like_post_usecase.dart';
import 'package:worknetwork/features/community/domain/usecase/delete_like_post_usecase.dart';
import 'package:worknetwork/features/community/domain/usecase/delete_post_usecase.dart';
import 'package:worknetwork/features/community/domain/usecase/get_posts_page_usecase.dart';

part 'community_event.dart';
part 'community_state.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  final UCGetPostsPage getPostsPage;
  final UCDeletePost deletePost;
  final UCCreateLikePost createLikePost;
  final UCDeleteLikePost deleteLikePost;

  CommunityBloc({
    @required this.getPostsPage,
    @required this.deletePost,
    @required this.createLikePost,
    @required this.deleteLikePost,
  }) : super(const CommunityInitial());

  @override
  Stream<CommunityState> mapEventToState(
    CommunityEvent event,
  ) async* {
    if (event is GetCommunityPageRequestStarted) {
      yield* _mapGetPageRequestToState(event);
    } else if (event is DeletePostRequestStarted) {
      yield* _mapDeletePostRequestToState(event);
    } else if (event is CreateLikePostRequest) {
      yield* _mapCreateLikePostToState(event);
    } else if (event is DeleteLikePostRequest) {
      yield* _mapDeleteLikePostToState(event);
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

  Stream<CommunityState> _mapCreateLikePostToState(
      CreateLikePostRequest event) async* {
    yield const CommunityRequestLoading();
    final createdOrError = await createLikePost(CreateLikeParams(
      post: event.postId,
      user: event.userId,
    ));

    yield createdOrError.fold(
      (failure) => CommunityRequestError(error: failure),
      (like) => CommunityCreateLikeReceivedSuccess(like: like),
    );
  }

  Stream<CommunityState> _mapDeleteLikePostToState(
      DeleteLikePostRequest event) async* {
    yield const CommunityRequestLoading();
    final deleteOrError = await deleteLikePost(DeleteLikeParams(
      postId: event.postId,
    ));

    yield deleteOrError.fold(
      (failure) => CommunityRequestError(error: failure),
      (like) => CommunityDeleteLikeReceivedSuccess(like: like),
    );
  }
}
