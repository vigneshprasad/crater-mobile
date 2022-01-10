import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entity/video_entity.dart';
import '../../../domain/usecase/get_videos_list_usecase.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final UCGetVideosListPage getVideos;

  VideoBloc({
    required this.getVideos,
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
    yield const VideoRequestLoading();
    final resultOrError = await getVideos(GetVideosPageParams(
      page: event.page,
      pageSize: event.pageSize,
    ));
    yield resultOrError.fold(
      (failure) => VideoRequestError(error: failure),
      (response) => VideoPageResponseLoaded(
        currentPage: response.currentPage,
        pages: response.pages,
        fromCache: response.fromCache,
        videos: response.results,
      ),
    );
  }
}
