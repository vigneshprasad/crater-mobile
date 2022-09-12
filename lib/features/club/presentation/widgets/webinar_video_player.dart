import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:worknetwork/features/conversations/domain/entity/webinar_entity/webinar_entity.dart';

class WebinarVideoPlayer extends StatefulWidget {
  const WebinarVideoPlayer({
    Key? key,
    required this.conversation,
  }) : super(key: key);

  final Webinar conversation;

  @override
  _WebinarVideoPlayerState createState() => _WebinarVideoPlayerState();
}

class _WebinarVideoPlayerState extends State<WebinarVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      widget.conversation.recordingDetails?.recording ?? '',
    );

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) {
      _controller.setVolume(0.0);
      _controller.seekTo(const Duration(minutes: 10));
      return setState(() {});
    });
    _controller.play();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).dialogBackgroundColor,
      width: double.infinity,
      child: Stack(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.conversation.topicDetail?.image ?? '',
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              VideoPlayer(_controller),
              // _ControlsOverlay(
              //   isPlaying: _controller.value.isPlaying,
              //   isFullScreen: widget.isFullScreen,
              // ),
              // VideoProgressIndicator(
              //   _controller,
              //   colors: VideoProgressColors(playedColor: Theme.of(context).accentColor),
              //   allowScrubbing: true,
              //   padding: EdgeInsets.only(
              //     bottom: 0,
              //     top: 20,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
