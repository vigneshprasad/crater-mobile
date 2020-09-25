import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/analytics/analytics.dart';
import '../../../../../core/analytics/anlytics_events.dart';
import '../../../domain/entity/post_entity.dart';
import '../../../domain/usecase/create_post_usecase.dart';

part 'create_post_event.dart';
part 'create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  final UCCreatePost createPost;
  final Analytics analytics;

  CreatePostBloc({
    @required this.createPost,
    @required this.analytics,
  })  : assert(createPost != null),
        assert(analytics != null),
        super(const CreatePostInitial());

  @override
  Stream<CreatePostState> mapEventToState(
    CreatePostEvent event,
  ) async* {
    if (event is CreatePostRequestStarted) {
      yield* _mapCreatePostRequestToState(event);
    }
  }

  Stream<CreatePostState> _mapCreatePostRequestToState(
      CreatePostRequestStarted event) async* {
    yield const CreatePostRequestLoading();
    final postOrError = await createPost(CreatePostParams(
      message: event.message,
      images: event.images,
    ));

    yield postOrError.fold(
      (failure) => CreatePostRequestError(error: failure),
      (post) {
        analytics.trackEvent(
          eventName: AnalyticsEvents.postCreated,
          properties: {
            "message": post.message,
            "post_id": post.pk,
          },
        );
        return CreatPostRequestSuccessLoaded(post: post);
      },
    );
  }
}
