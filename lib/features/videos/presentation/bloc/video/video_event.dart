part of 'video_bloc.dart';

abstract class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object> get props => [];
}

class GetVideosListRequestStarted extends VideoEvent {
  final int page;
  final int pageSize;

  const GetVideosListRequestStarted({
    @required this.page,
    @required this.pageSize,
  });

  @override
  List<Object> get props => [page, pageSize];
}
