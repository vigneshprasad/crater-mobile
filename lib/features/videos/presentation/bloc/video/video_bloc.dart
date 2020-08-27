import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:worknetwork/features/videos/domain/entity/video_entity.dart';
import 'package:worknetwork/features/videos/domain/usecase/get_videos_list_usecase.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final UCGetVideosListPage getVideos;

  VideoBloc({
    @required this.getVideos,
  }) : super(const VideoInitial());

  @override
  Stream<VideoState> mapEventToState(
    VideoEvent event,
  ) async* {
    if (event is GetVideosListRequestStarted) {
      yield* _mapGetVideosRequestToState(event);
    }
  }

  Stream<VideoState> _mapGetVideosRequestToState(
      GetVideosListRequestStarted event) async* {
    yield state.copyWith(loading: true);
    final resultOrError =
        await getVideos(GetVideosPageParams(page: event.page));
    yield resultOrError.fold(
      (failure) => state.copyWith(error: failure, loading: false),
      (response) => state.copyWith(
        videos: response.results,
        pages: response.pages,
        count: response.count,
        // ignore: avoid_redundant_argument_values
        error: null,
        currentPage: response.currentPage,
        fromCache: response.fromCache,
        loading: false,
      ),
    );
  }
}
