import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/core/status_bar_color/status_bar_color.dart';
import 'package:worknetwork/features/videos/domain/entity/video_entity.dart';
import 'package:worknetwork/features/videos/presentation/bloc/video_player/video_player_bloc.dart';
import 'package:worknetwork/features/videos/presentation/widgets/video_player_list_item.dart';
import 'package:worknetwork/features/videos/presentation/widgets/video_screen_layout.dart';
import 'package:worknetwork/ui/base/base_app_bar/base_app_bar.dart';

class VideoPlayerScreen extends StatefulWidget {
  final int videoId;

  const VideoPlayerScreen({
    @required this.videoId,
    Key key,
  }) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerBloc _bloc;
  VideoPlayerController _videoPlayerController;
  ChewieController _controller;
  List<Video> _playlist = [];

  @override
  void initState() {
    _bloc = KiwiContainer().resolve<VideoPlayerBloc>()
      ..add(
        GetFeatureVideoStarted(id: widget.videoId),
      )
      ..add(
        GetVideosPlaylistStarted(excludeItemId: widget.videoId, page: 1),
      );
    StatusBarColor.setTheme(ThemeType.dark);
    super.initState();
  }

  @override
  void dispose() {
    _bloc?.close();
    _videoPlayerController?.dispose();
    _controller?.dispose();
    StatusBarColor.setTheme(ThemeType.light);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Theme(
        data: AppTheme.darkTheme,
        child: BlocConsumer<VideoPlayerBloc, VideoPlayerState>(
          listener: (context, state) {
            if (state is VideoFeatureItemReceived) {
              setState(() {
                _videoPlayerController =
                    VideoPlayerController.network(state.featureVideo.cover);
                _controller = _buildVideoController(state.featureVideo);
              });
            }

            if (state is VideoPlaylistItemsReceived) {
              setState(() {
                _playlist = state.playlistItems;
              });
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: BaseAppBar(),
              body: VideoScreenLayout(
                  featureVideo: state.featureVideo,
                  videoPlayer: _buildPlayer(state),
                  playlist: _buildPlayList(state)),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPlayer(VideoPlayerState state) {
    if (_controller != null) {
      return Chewie(
        controller: _controller,
      );
    }
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        color: Colors.black,
      ),
    );
  }

  ChewieController _buildVideoController(Video featureVideo) {
    return ChewieController(
      showControlsOnInitialize: false,
      videoPlayerController: _videoPlayerController,
      autoInitialize: true,
      aspectRatio: 16 / 9,
      autoPlay: true,
      placeholder: _buildVideoPlaceholder(),
    );
  }

  Widget _buildPlayList(VideoPlayerState state) {
    return ListView.separated(
      itemCount: _playlist.length,
      itemBuilder: (context, index) => VideoPlayerListItem(
        video: _playlist[index],
        onPressItem: () {
          _onPressPlayListItem(_playlist[index]);
        },
      ),
      separatorBuilder: (context, index) => Divider(
        color: Colors.grey[00],
        height: 2.0,
      ),
    );
  }

  void _onPressPlayListItem(Video item) {
    _controller.pause();
    _bloc.add(GetFeatureVideoStarted(id: item.pk));
    _bloc.add(GetVideosPlaylistStarted(excludeItemId: item.pk, page: 1));
  }

  Widget _buildVideoPlaceholder() {
    return Center(
      child: LottieBuilder.asset(
        AppLottieAssets.imageLoading,
        width: 24,
      ),
    );
  }
}
