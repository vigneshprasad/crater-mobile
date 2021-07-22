part of 'video_bloc.dart';

abstract class VideoState extends Equatable {
  final bool loading;
  final Object? error;

  const VideoState({
    required this.loading,
    required this.error,
  });

  @override
  List<Object> get props => error != null ? [loading, error!] : [loading];
}

class VideoInitial extends VideoState {
  const VideoInitial()
      : super(
          loading: false,
          error: null,
        );
}

class VideoRequestLoading extends VideoState {
  const VideoRequestLoading()
      : super(
          loading: true,
          error: null,
        );
}

class VideoRequestError extends VideoState {
  const VideoRequestError({
    required dynamic error,
  }) : super(loading: false, error: error);
}

class VideoPageResponseLoaded extends VideoState {
  final List<Video>? videos;
  final int? pages;
  final int? currentPage;
  final bool fromCache;

  const VideoPageResponseLoaded({
    this.videos,
    this.pages,
    this.currentPage,
    required this.fromCache,
  }) : super(loading: false, error: null);
}
