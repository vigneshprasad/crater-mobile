part of 'video_bloc.dart';

abstract class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object> get props => [];
}

class GetVideosListRequestStarted extends VideoEvent {
  final int page;

  const GetVideosListRequestStarted({
    @required this.page,
  });

  @override
  List<Object> get props => [page];
}
