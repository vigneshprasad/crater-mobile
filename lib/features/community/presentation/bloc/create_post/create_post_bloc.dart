import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:worknetwork/features/community/domain/usecase/create_post_usecase.dart';

import '../../../domain/entity/post_entity.dart';

part 'create_post_event.dart';
part 'create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  final UCCreatePost createPost;

  CreatePostBloc({
    @required this.createPost,
  }) : super(const CreatePostInitial());

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
      (post) => CreatPostRequestSuccessLoaded(post: post),
    );
  }
}
