import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:neopop/widgets/buttons/neopop_tilted_button/neopop_tilted_button.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/core/analytics/analytics.dart';
import 'package:worknetwork/core/analytics/anlytics_events.dart';
import 'package:worknetwork/core/color/color.dart';
import 'package:worknetwork/core/widgets/base/base_network_image/base_network_image.dart';
import 'package:worknetwork/core/widgets/root_app.dart';
import 'package:worknetwork/features/auth/presentation/screens/splash/splash_screen_state.dart';
import 'package:worknetwork/features/conversations/domain/entity/conversation_entity/conversation_entity.dart';
import 'package:worknetwork/features/conversations/presentation/screens/conversation_screen/conversation_screen_state.dart';
import 'package:worknetwork/features/conversations/presentation/screens/conversation_screen/user_stream_screen.dart';
import 'package:worknetwork/features/meeting/presentation/screens/dyte_meeting_screen.dart';
import 'package:worknetwork/routes.gr.dart';
import 'package:worknetwork/ui/base/base_large_button/base_large_button.dart';
import 'package:worknetwork/utils/app_localizations.dart';
import 'package:worknetwork/utils/navigation_helpers/navigate_post_auth.dart';

class ConversationScreen extends HookConsumerWidget {
  final int? id;

  const ConversationScreen({
    @PathParam("id") this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conversationState = ref.watch(conversationStateProvider(id!));

    return conversationState.when(
      loading: () => Scaffold(
        appBar: AppBar(),
        body: _Loader(),
      ),
      data: (data) => _ConversationLoaded(
        data: data,
        // speakers: speakers,
        // connection: connectionProvider.connection,
      ),
      error: (err, st) => Scaffold(
        appBar: AppBar(),
        body: _Loader(),
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
  final ConversationScreenData data;
  // final List<RtcUser> speakers;
  // final RtcConnection connection;
  OverlayEntry? overlayEntry;
  late WidgetRef ref;

  _ConversationLoaded({
    Key? key,
    required this.data,
    // required this.speakers,
    // required this.connection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    this.ref = ref;
    // Styles
    final startDateFormat = DateFormat("dd MMMM yyyy");
    final startTimeFormat = DateFormat('hh:mm a');

    final authUserPK = ref.read(authStateProvider.notifier).getUser()?.pk;
    final conversation = data.conversation;
    final article = conversation.topicDetail?.articleDetail;

    final topic = conversation.topicDetail;
    final heading =
        article != null ? article.description : conversation.topicDetail?.name;
    final shareText = Uri.encodeQueryComponent(heading ?? '');

    final now = DateTime.now().toLocal();
    const timeBefore = Duration(minutes: 5);
    final start = conversation.start!.toLocal().subtract(timeBefore);

    const timeAfter = Duration(minutes: 60);
    final end = conversation.start!.toLocal().add(timeAfter);

    final isClosed = conversation.closed ?? false;

    final canJoin = now.isAfter(start) && now.isBefore(end) && !isClosed;

    final selectedTab = useState(0);

    final canHost = conversation.host == authUserPK &&
        now.isAfter(start) &&
        now.isBefore(end) &&
        !isClosed;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppSvgAssets.cableTV,
              width: 18,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              startDateFormat.format(conversation.start!.toLocal()),
              style: Theme.of(context).textTheme.subtitle2,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              startTimeFormat.format(conversation.start!.toLocal()),
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  ?.copyWith(color: HexColor.fromHex('#D5BBFF')),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              final url =
                  'https://crater.club/session/${conversation.id}?utm_source=in_app_share&referrer_id=$authUserPK&utm_campaign=mobile_app';
              shareApp(context, url, shareText);
            },
            icon: const Icon(Icons.share_outlined),
          ),
        ],
      ),
      body: Stack(
        children: [
          DefaultTabController(
            length: 2,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (topic?.image != null)
                                Image.network(
                                  topic?.image ?? '',
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              const SizedBox(height: AppInsets.xxl),
                              Text(
                                heading ?? '',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        TabBar(
                          isScrollable: true,
                          indicatorColor: HexColor.fromHex("#121212"),
                          onTap: (value) {
                            selectedTab.value = value;
                          },
                          tabs: [
                            Container(
                              color: selectedTab.value == 0
                                  ? HexColor.fromHex("#121212")
                                  : null,
                              child: const Tab(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Text('ABOUT THE STREAM'),
                                ),
                              ),
                            ),
                            Container(
                              color: selectedTab.value == 1
                                  ? HexColor.fromHex("#121212")
                                  : null,
                              child: Tab(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Text(
                                    'MORE FROM ${conversation.hostDetail?.name?.split(' ').first.toUpperCase() ?? 'HOST'}',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
              body: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppInsets.xl,
                    ),
                    child: Column(
                      children: [
                        Container(
                          color: HexColor.fromHex("#121212"),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (conversation
                                        .topicDetail?.description?.isNotEmpty ??
                                    false)
                                  Text(
                                    conversation.topicDetail?.description ?? '',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                const SizedBox(height: AppInsets.xxl),
                                Text(
                                  'SPEAKER',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                Column(
                                  children: conversation.speakersDetailList
                                          ?.map(
                                            (speaker) => _SpeakerWithIntro(
                                              user: speaker,
                                              authUserPk: authUserPK,
                                            ),
                                          )
                                          .toList() ??
                                      [],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  UserStreamScreen(
                    userId: conversation.host ?? '',
                    conversationId: conversation.id ?? 0,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Container(
                  color: Theme.of(context).backgroundColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (data.isRSVPed)
                        if (canHost) // HOST
                          Expanded(
                            child: NeoPopTiltedButton(
                              key: Key("golive"),
                              color: Theme.of(context).primaryColor,
                              onTapUp: () {
                                startDyteMeeting(context);
                              },
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                  child: Text(
                                    'Go Live',
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                ),
                              ),
                            ),
                          )
                        else if (canJoin) // AUDIENCE
                          Expanded(
                            child: NeoPopTiltedButton(
                              key: Key("goliveaudience"),
                              color: Theme.of(context).primaryColor,
                              onTapUp: () {
                                startDyteMeeting(context);
                              },
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)?.translate(
                                          "conversation_screen:go_live_label",
                                        ) ??
                                        '',
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                ),
                              ),
                            ),
                          )
                        else
                          Expanded(
                            child: NeoPopTiltedButton(
                              key: Key("wellremind"),
                              color: HexColor.fromHex("#53A476"),
                              onTapUp: () {},
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "We'll remind you",
                                        style:
                                            Theme.of(context).textTheme.button,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Icon(
                                        Icons.check,
                                        size: 14,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                      else
                        Expanded(
                          child: NeoPopTiltedButton(
                            key: Key("remind"),
                            color: Theme.of(context).primaryColor,
                            onTapUp: () {
                              _requestJoinGroup(context);
                            },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                                child: Text(
                                  'Remind Me',
                                  style: Theme.of(context).textTheme.button,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> startDyteMeeting(BuildContext context) async {
    final analytics = ref.read(analyticsProvider);
    analytics.trackEvent(
      eventName: AnalyticsEvents.joinStreamButtonClick,
      properties: {
        "id": data.conversation.id,
      },
    );

    final loginStatus = await manageLoginPopup(context, ref);
    if (loginStatus == false) {
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DyteMeetingScreen(
          meetingId: data.conversation.id!,
          creatorId: data.conversation.hostDetail?.creatorDetail?.id ?? 0,
        ),
      ),
    );
  }

  Future<void> _requestJoinGroup(BuildContext context) async {
    final analytics = ref.read(analyticsProvider);
    analytics.trackEvent(
      eventName: AnalyticsEvents.rsvpStreamButtonClick,
      properties: {
        "id": data.conversation.id,
      },
    );

    final loginStatus = await manageLoginPopup(context, ref);
    if (loginStatus == false) {
      return;
    }

    overlayEntry = buildLoaderOverlay();
    Overlay.of(context)?.insert(overlayEntry!);

    final response = await ref
        .read(conversationStateProvider(data.conversation.id!).notifier)
        .postRequestToJoinGroup();

    response.fold(
      (failure) {
        overlayEntry?.remove();
        Fluttertoast.showToast(msg: failure.message.toString());
      },
      (request) {
        analytics.trackEvent(
          eventName: AnalyticsEvents.rsvpStream,
          properties: {
            "id": request.group,
          },
        );
        _updateConversation(context);
      },
    );
  }

  Future<void> _updateConversation(BuildContext context) async {
    final response = await ref
        .read(conversationStateProvider(data.conversation.id!).notifier)
        .retrieveConversation(justRSVPed: true);

    response.fold(
      (failure) {
        overlayEntry?.remove();
        Fluttertoast.showToast(msg: failure.message.toString());
      },
      (group) async {
        overlayEntry?.remove();

        await manageRSVPPopup(
          context,
          data.conversation.hostDetail?.name ?? 'the host',
        );

        await showEmail(context, ref);
      },
    );
  }
}

class _SpeakerWithIntro extends StatelessWidget {
  final ConversationUser user;
  final String? authUserPk;
  const _SpeakerWithIntro({
    Key? key,
    required this.user,
    this.authUserPk,
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
                radius: 18,
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
