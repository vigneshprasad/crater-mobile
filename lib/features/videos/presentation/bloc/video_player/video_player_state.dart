part of 'video_player_bloc.dart';

@immutable
class VideoPlayerState extends Equatable {
  final bool loadingFeature;
  final bool loadingList;
  final Video? featureVideo;
  final List<Video> playlistItems;
  final Object? error;

  const VideoPlayerState({
    required this.loadingFeature,
    required this.loadingList,
    this.featureVideo,
    required this.playlistItems,
    required this.error,
  });

  @override
  List<Object> get props {
    final List<Object> temp = [
      loadingFeature,
      loadingList,
      playlistItems,
    ];

    if (error != null) {
      temp.add(error!);
    }
    if (featureVideo != null) {
      temp.add(featureVideo!);
    }

    return temp;
  }

  VideoPlayerState copyWith({
    bool? loadingFeature,
    bool? loadingList,
    Video? featureVideo,
    List<Video>? playlistItems,
    Object? error,
  }) {
    return VideoPlayerState(
      loadingFeature: loadingFeature ?? this.loadingFeature,
      loadingList: loadingList ?? this.loadingList,
      featureVideo: featureVideo ?? this.featureVideo,
      playlistItems: playlistItems ?? this.playlistItems,
      error: error ?? this.error,
    );
  }
}

class VideoPlayerInitial extends VideoPlayerState {
  const VideoPlayerInitial()
      : super(
          loadingFeature: false,
          loadingList: false,
          playlistItems: const [],
          error: null,
        );
}

class VideoFeatureItemReceived extends VideoPlayerState {
  const VideoFeatureItemReceived({
    required bool loadingList,
    required Video featureVideo,
    required List<Video> playlistItems,
  }) : super(
          featureVideo: featureVideo,
          loadingFeature: false,
          loadingList: loadingList,
          playlistItems: playlistItems,
          error: null,
        );
}

class VideoPlaylistItemsReceived extends VideoPlayerState {
  const VideoPlaylistItemsReceived({
    required bool loadingFeature,
    required Video featureVideo,
    required List<Video> playlistItems,
  }) : super(
          featureVideo: featureVideo,
          loadingFeature: loadingFeature,
          loadingList: false,
          playlistItems: playlistItems,
          error: null,
        );
}
