import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../domain/entity/video_entity.dart';
import '../../../domain/usecase/get_video_item_usecase.dart';
import '../../../domain/usecase/get_videos_list_usecase.dart';

part 'video_player_event.dart';
part 'video_player_state.dart';

class VideoPlayerBloc extends Bloc<VideoPlayerEvent, VideoPlayerState> {
  final UCGetVideoItem getVideoItem;
  final UCGetVideosListPage getVideosList;

  VideoPlayerBloc({
    required this.getVideoItem,
    required this.getVideosList,
  }) : super(const VideoPlayerInitial());

  @override
  Stream<VideoPlayerState> mapEventToState(
    VideoPlayerEvent event,
  ) async* {
    if (event is GetFeatureVideoStarted) {
      yield* _mapGetFeatureVideoToState(event);
    } else if (event is GetVideosPlaylistStarted) {
      yield* _mapGetVidesPlaylist(event);
    }
  }

  Stream<VideoPlayerState> _mapGetFeatureVideoToState(
      GetFeatureVideoStarted event) async* {
    yield state.copyWith(loadingFeature: true);
    final videoOrerror = await getVideoItem(GetVideoItemParams(event.id));
    yield videoOrerror.fold(
      (failure) => state.copyWith(
        error: failure,
        loadingFeature: false,
      ),
      (video) => VideoFeatureItemReceived(
        featureVideo: video,
        loadingList: state.loadingList,
        playlistItems: state.playlistItems,
      ),
    );
  }

  Stream<VideoPlayerState> _mapGetVidesPlaylist(
      GetVideosPlaylistStarted event) async* {
    yield state.copyWith(loadingList: true);
    final playlistOrError = await getVideosList(GetVideosPageParams(
      page: event.page,
      pageSize: event.pageSize,
    ));

    yield playlistOrError.fold(
      (failure) => state.copyWith(
        error: failure,
        loadingList: false,
      ),
      (videos) {
        final results = videos.results;
        videos.results
            ?.removeWhere((element) => element.pk == event.excludeItemId);
        return VideoPlaylistItemsReceived(
          featureVideo: state.featureVideo!,
          playlistItems: results!,
          loadingFeature: state.loadingFeature,
        );
      },
    );
  }
}
