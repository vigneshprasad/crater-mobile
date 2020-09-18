part of 'video_player_bloc.dart';

abstract class VideoPlayerEvent extends Equatable {
  const VideoPlayerEvent();

  @override
  List<Object> get props => [];
}

class GetFeatureVideoStarted extends VideoPlayerEvent {
  final int id;
  const GetFeatureVideoStarted({
    @required this.id,
  });

  @override
  List<Object> get props => [id];
}

class GetVideosPlaylistStarted extends VideoPlayerEvent {
  final int excludeItemId;
  final int page;
  final int pageSize;

  const GetVideosPlaylistStarted({
    @required this.excludeItemId,
    @required this.page,
    @required this.pageSize,
  });
}
