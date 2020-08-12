import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:worknetwork/blocs/post/repo/post_repository.dart';
import 'package:worknetwork/models/post/post_model.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _postRepository = PostRepository();

  PostBloc() : super(PostInitial());

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    if (event is PostGetStarted) {
      yield* _mapPostGet();
    } else if (event is PostDeleteStarted) {
      yield* _mapPostDelete(event.id);
    } else if (event is PostCreateStarted) {
      yield* _mapPostCreate(event.message, event.files);
    }
  }

  Stream<PostState> _mapPostGet() async* {
    try {
      yield PostGetLoading();
      final response = await _postRepository.getPosts();
      yield PostGetSuccess(response.results);
    } catch (error) {
      yield PostGetFailure(error);
    }
  }

  Stream<PostState> _mapPostDelete(int id) async* {
    try {
      yield PostDeleteLoading();
      await _postRepository.deletePost(id);
      yield PostDeleteCompleted();
      add(PostGetStarted());
    } catch (error) {
      yield PostDeleteFailure(error);
    }
  }

  Stream<PostState> _mapPostCreate(
      String message, List<MultipartFile> files) async* {
    try {
      yield PostCreateLoading();
      final response = await _postRepository.createPost(message, files);
      yield PostCreateCompleted(response);
      add(PostGetStarted());
    } catch (error) {
      yield PostCreateFailure(error);
    }
  }

  @override
  Future<void> close() {
    _postRepository.dispose();
    return super.close();
  }
}
