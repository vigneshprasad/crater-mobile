import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/core/widgets/base/base_network_image/base_network_image.dart';
import 'package:worknetwork/features/auth/presentation/screens/splash/splash_screen_state.dart';
import 'package:worknetwork/features/club/presentation/screens/past_stream/past_stream_detail_screen_state.dart';
import 'package:worknetwork/features/club/presentation/screens/streams/past_stream_screen_state.dart';
import 'package:worknetwork/features/club/presentation/screens/streams/stream_screen.dart';
import 'package:worknetwork/features/conversations/domain/entity/conversation_entity/conversation_entity.dart';
import 'package:worknetwork/features/meeting/presentation/screens/dyte_meeting_screen.dart';
import 'package:worknetwork/routes.gr.dart';
import 'package:worknetwork/ui/base/base_app_bar/base_app_bar.dart';

class PastStreamDetailScreen extends HookConsumerWidget {
  final int? id;

  const PastStreamDetailScreen({
    @PathParam("id") this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conversationState = ref.read(pastStreamStateProvider(id ?? 0));
    final isFullScreen = useState(false);

    return Scaffold(
      appBar: isFullScreen.value ? null : BaseAppBar(),
      body: conversationState.when(
        loading: () => _Loader(),
        data: (conversation) => _ConversationLoaded(
          conversation: conversation,
          isFullScreen: isFullScreen,
        ),
        error: (err, st) => _Loader(),
      ),
    );
  }
}

class _Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}

class _ConversationLoaded extends HookConsumerWidget {
  final Conversation conversation;
  final ValueNotifier<bool> isFullScreen;

  _ConversationLoaded({
    Key? key,
    required this.conversation,
    required this.isFullScreen,
  }) : super(key: key);

  OverlayEntry? overlayEntry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Styles
    final startDateFormat = DateFormat("dd MMM yyyy, hh:mm a");
    final dateStyle = Theme.of(context).textTheme.caption;

    final authUserPK = ref.read(authStateProvider.notifier).getUser()?.pk;

    final article = conversation.topicDetail?.articleDetail;

    final heading =
        article != null ? article.description : conversation.topicDetail?.name;

    final similarStreamProvider = ref.read(pastStreamsStateProvider(null));

    final start = conversation.start?.toLocal();

    return SingleChildScrollView(
      child: Padding(
        padding: isFullScreen.value
            ? EdgeInsets.zero
            : const EdgeInsets.symmetric(
                horizontal: AppInsets.xl,
                vertical: AppInsets.l,
              ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamVideoPlayer(
              conversation: conversation,
              isFullScreen: isFullScreen,
            ),
            if (!isFullScreen.value)
              Column(
                children: [
                  const SizedBox(height: AppInsets.xxl),
                  Text(
                    heading ?? '',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      if (start != null)
                        Text(startDateFormat.format(start), style: dateStyle),
                    ],
                  ),
                  const SizedBox(height: AppInsets.xxl),
                  if (conversation.topicDetail?.description?.isNotEmpty ??
                      false)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Talking About',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const SizedBox(height: AppInsets.xxl),
                        Text(conversation.topicDetail?.description ?? ''),
                      ],
                    ),
                  const Divider(thickness: 1, height: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Speakers',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(height: AppInsets.xxl),
                      Column(
                        children: conversation.speakersDetailList
                                ?.map(
                                  (speaker) => _SpeakerWithIntro(
                                    user: speaker,
                                    authUserPk: authUserPK ?? '',
                                  ),
                                )
                                .toList() ??
                            [],
                      )
                    ],
                  ),
                  const Divider(thickness: 1, height: 40),
                  similarStreamProvider.when(
                    loading: () => Container(),
                    error: (e, s) => Container(),
                    data: (conversations) {
                      if (conversations.isEmpty) return Container();
                      return SizedBox(
                        height: 340,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Similar streams',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            const SizedBox(height: AppInsets.xxl),
                            CarouselSlider(
                              options: CarouselOptions(
                                height: 280.0,
                                enlargeCenterPage: true,
                                enableInfiniteScroll: false,
                              ),
                              items: conversations.map((c) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return UpcomingGridTile(c);
                                  },
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 200),
                ],
              )
          ],
        ),
      ),
    );
  }

  void startDyteMeeting(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DyteMeetingScreen(
          meetingId: conversation.id ?? 0,
          creatorId: conversation.hostDetail?.creatorDetail?.id ?? 0,
        ),
      ),
    );
  }
}

class StreamVideoPlayer extends StatefulWidget {
  const StreamVideoPlayer({
    Key? key,
    required this.conversation,
    required this.isFullScreen,
  }) : super(key: key);

  final ValueNotifier<bool> isFullScreen;

  final Conversation conversation;

  @override
  _StreamVideoPlayerState createState() => _StreamVideoPlayerState();
}

class _StreamVideoPlayerState extends State<StreamVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      widget.conversation.recordingDetails?.recording ?? '',
    );

    _controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    _controller.setLooping(false);
    _controller.initialize().then((_) {
      return setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (_controller.value.isPlaying) {
          _controller.pause();
        } else {
          _controller.play();
        }
      },
      child: Container(
        color: widget.isFullScreen.value
            ? Colors.black
            : Theme.of(context).dialogBackgroundColor,
        width: double.infinity,
        height: widget.isFullScreen.value
            ? MediaQuery.of(context).size.height
            : null,
        alignment: widget.isFullScreen.value ? Alignment.center : null,
        child: RotatedBox(
          quarterTurns: widget.isFullScreen.value ? 1 : 0,
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: _controller.value.isInitialized
                    ? _controller.value.aspectRatio
                    : 16.0 / 9.0,
                child: Stack(
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
                    _ControlsOverlay(
                      isPlaying: _controller.value.isPlaying,
                      isFullScreen: widget.isFullScreen,
                    ),
                    VideoProgressIndicator(
                      _controller,
                      colors: VideoProgressColors(
                        playedColor: Theme.of(context).colorScheme.secondary,
                      ),
                      allowScrubbing: true,
                      padding: EdgeInsets.only(
                        bottom: widget.isFullScreen.value ? 40 : 0,
                        top: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({
    Key? key,
    required this.isPlaying,
    required this.isFullScreen,
  }) : super(key: key);

  final bool isPlaying;
  final ValueNotifier<bool> isFullScreen;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: isPlaying
              ? const SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: const Center(
                    child: Icon(
                      Icons.play_circle,
                      color: Colors.white,
                      size: 100.0,
                      semanticLabel: 'Play',
                    ),
                  ),
                ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: const Icon(Icons.zoom_out_map),
            onPressed: () {
              isFullScreen.value = !isFullScreen.value;
              if (isFullScreen.value) {
                SystemChrome.setEnabledSystemUIMode(
                  SystemUiMode.manual,
                  overlays: [SystemUiOverlay.bottom],
                );
              } else {
                SystemChrome.setEnabledSystemUIMode(
                  SystemUiMode.manual,
                  overlays: SystemUiOverlay.values,
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

class _SpeakerWithIntro extends StatelessWidget {
  final ConversationUser user;
  final String authUserPk;
  const _SpeakerWithIntro({
    Key? key,
    required this.user,
    required this.authUserPk,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final description = user.introduction ?? user.email;
    final headingStyle = Theme.of(context).textTheme.subtitle2;
    final bodyStyle = Theme.of(context).textTheme.caption;
    return InkWell(
      onTap: () => AutoRouter.of(context).push(
        ProfileScreenRoute(
          userId: user.pk ?? '',
          allowEdit: authUserPk == user.pk,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseNetworkImage(
              imageUrl: user.photo,
              defaultImage: AppImageAssets.defaultAvatar,
              imagebuilder: (context, imageProvider) => CircleAvatar(
                backgroundImage: imageProvider,
                radius: 36,
              ),
            ),
            const SizedBox(width: AppInsets.xl),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.name ?? '', style: headingStyle),
                  const SizedBox(height: AppInsets.sm),
                  Text(
                    description ?? '',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: bodyStyle,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
