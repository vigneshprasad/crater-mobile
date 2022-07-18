import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/core/analytics/analytics.dart';
import 'package:worknetwork/core/analytics/anlytics_events.dart';
import 'package:worknetwork/core/widgets/base/base_network_image/base_network_image.dart';
import 'package:worknetwork/core/widgets/root_app.dart';
import 'package:worknetwork/features/auth/presentation/screens/splash/splash_screen_state.dart';
import 'package:worknetwork/features/conversations/domain/entity/conversation_entity/conversation_entity.dart';
import 'package:worknetwork/features/conversations/presentation/screens/conversation_screen/conversation_screen_state.dart';
import 'package:worknetwork/features/meeting/presentation/screens/dyte_meeting_screen.dart';
import 'package:worknetwork/routes.gr.dart';
import 'package:worknetwork/ui/base/base_app_bar/base_app_bar.dart';
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

    return Scaffold(
      appBar: BaseAppBar(),
      body: conversationState.when(
        loading: () => _Loader(),
        data: (data) => _ConversationLoaded(
          data: data,
          // speakers: speakers,
          // connection: connectionProvider.connection,
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

class _ConversationLoaded extends ConsumerWidget {
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
    final startDateFormat = DateFormat("dd MMM, hh:mm a");
    final dateStyle = Theme.of(context).textTheme.bodyText2;

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

    final canHost = conversation.host == authUserPK &&
        now.isAfter(start) &&
        now.isBefore(end) &&
        !isClosed;

    final link = 'https://crater.club/session/${conversation.id}';

    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppInsets.xl,
              vertical: AppInsets.l,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  heading ?? '',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    const Icon(Icons.calendar_today),
                    const SizedBox(width: 12),
                    Text(
                      startDateFormat.format(conversation.start!.toLocal()),
                      style: dateStyle,
                    ),
                  ],
                ),
                const SizedBox(height: AppInsets.xxl),
                if (topic?.image != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      topic?.image ?? '',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                const SizedBox(height: AppInsets.xxl),
                if (conversation.topicDetail?.description?.isNotEmpty ?? false)
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
                const Divider(thickness: 1, height: 80),
                Text(
                  'Let others know',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(height: AppInsets.xxl),
                InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: link));
                    Fluttertoast.showToast(msg: 'Copied to clipboard');
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 2, color: Colors.white10),
                    ),
                    child: Row(
                      children: [
                        Text(link),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.copy),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppInsets.xxl),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          final url =
                              'https://crater.club/session/${conversation.id}?utm_source=in_app_share&referrer_id=$authUserPK&utm_campaign=mobile_app';
                          shareApp(context, url, shareText);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Platform.isAndroid
                                  ? Icons.share
                                  : Icons.ios_share,
                              size: 24,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Expanded(
                              child: Text(
                                'Share',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(thickness: 1, height: 80),
                Text(
                  'Speakers',
                  style: Theme.of(context).textTheme.headline6,
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
                const SizedBox(height: 200)
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
                          child: BaseLargeButton(
                            onPressed: () {
                              startDyteMeeting(context);
                            },
                            text: "Go Live",
                          ),
                        )
                      else if (canJoin) // AUDIENCE
                        Expanded(
                          child: BaseLargeButton(
                            onPressed: () {
                              startDyteMeeting(context);
                            },
                            text: AppLocalizations.of(context)?.translate(
                                  "conversation_screen:go_live_label",
                                ) ??
                                '',
                          ),
                        )
                      else
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.secondary,
                                width: 2,
                              ),
                            ),
                            child: Text(
                              'You will be notified when ${conversation.hostDetail?.name} is live',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ),
                        )
                    else
                      Expanded(
                        child: BaseLargeButton(
                          onPressed: () {
                            _requestJoinGroup(context);
                          },
                          text: 'RSVP for this session',
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
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
