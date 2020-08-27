part of 'video_bloc.dart';

@immutable
class VideoState extends Equatable {
  final bool fromCache;
  final int count;
  final int pages;
  final int currentPage;
  final List<Video> videos;
  final bool loading;
  final dynamic error;

  const VideoState({
    @required this.fromCache,
    @required this.count,
    @required this.pages,
    @required this.currentPage,
    @required this.videos,
    @required this.loading,
    @required this.error,
  });

  @override
  List<Object> get props => [
        fromCache,
        count,
        pages,
        currentPage,
        videos,
        loading,
        error,
      ];

  VideoState copyWith({
    bool fromCache,
    int count,
    int pages,
    int currentPage,
    List<Video> videos,
    bool loading,
    dynamic error,
  }) {
    return VideoState(
      fromCache: fromCache ?? this.fromCache,
      count: count ?? this.count,
      pages: pages ?? this.pages,
      currentPage: currentPage ?? this.currentPage,
      videos: videos ?? this.videos,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }
}

class VideoInitial extends VideoState {
  const VideoInitial()
      : super(
          fromCache: false,
          count: 0,
          pages: 1,
          currentPage: 1,
          videos: const [],
          loading: false,
          error: null,
        );
}
