import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart' hide ReadContext;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kiwi/kiwi.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:worknetwork/core/widgets/root_app.dart';
import 'package:worknetwork/features/club/presentation/screens/streams/stream_screen.dart';
import 'package:worknetwork/features/conversations/domain/entity/conversation_entity/conversation_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/series_entity/series_entity.dart';
import 'package:worknetwork/features/conversations/presentation/screens/conversation_screen_2/conversation_screen_state.dart';
import 'package:worknetwork/features/meeting/presentation/screens/dyte_meeting_screen.dart';
import 'package:worknetwork/features/signup/presentation/screens/profile_email_screen.dart';
import 'package:worknetwork/ui/base/base_large_button/base_large_button.dart';
import 'package:worknetwork/utils/navigation_helpers/navigate_post_auth.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../constants/theme.dart';
import '../../../../../core/analytics/analytics.dart';
import '../../../../../core/analytics/anlytics_events.dart';
import '../../../../../core/features/popup_manager/popup_manager.dart';
import '../../../../../core/widgets/base/base_network_image/base_network_image.dart';
import '../../../../../routes.gr.dart';
import '../../../../../ui/base/base_app_bar/base_app_bar.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../../auth/presentation/screens/onboarding/onboarding_screen.dart';
import '../../widgets/conversation_overlay_indicator/conversation_overlay_controller.dart';
import 'series_screen_state.dart';

class SeriesScreen extends HookWidget {
  final int? id;

  const SeriesScreen({
    @PathParam("id") this.id,
  });

  @override
  Widget build(BuildContext context) {
    final seriesState = useProvider(seriesStateProvider(id!));
    final overlayProvider = useProvider(conversationOverlayProvider);

    useEffect(() {
      if (overlayProvider.entry != null) {
        overlayProvider.removeOverlayEntry();
        if (overlayProvider.groupId != null && overlayProvider.groupId != id) {
          // context
          //     .read(
          //         conversationStateProvider(overlayProvider.groupId!).notifier)
          //     .leaveAudioCall();
        }
      }

      return;
    }, []);

    return Scaffold(
      appBar: BaseAppBar(),
      body: seriesState.when(
        loading: () => _Loader(),
        data: (data) {
          final groupId = data.series.groups?.first;
          final conversationState =
              useProvider(conversationStateProvider(groupId!));

          return conversationState.when(
              loading: () => _Loader(),
              data: (conversationData) => _SeriesLoaded(
                    data: conversationData,
                    series: data.series,
                  ),
              error: (err, st) => _Loader());
        },
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
        color: Theme.of(context).accentColor,
      ),
    );
  }
}

class _SeriesLoaded extends StatelessWidget {
  final ConversationScreenData data;
  final Series series;
  OverlayEntry? overlayEntry;

  _SeriesLoaded({
    Key? key,
    required this.data,
    required this.series,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Styles
    final startDateFormat = DateFormat("dd MMM, hh:mm a");
    final dateStyle = Theme.of(context).textTheme.bodyText2;

    final authUserPK = BlocProvider.of<AuthBloc>(context).state.user?.pk;
    
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
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Stack(
        children: [
          SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppInsets.xl, vertical: AppInsets.l),
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
                    Text(startDateFormat.format(conversation.start!.toLocal()),
                        style: dateStyle),
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
                      )),
                ),
                const SizedBox(height: AppInsets.xxl),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          final url =
                              'http://www.linkedin.com/shareArticle?mini=true&url=https://crater.club/session/${conversation.id}&title=${shareText}';
                          launch(url, forceSafariVC: false);
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AppSvgAssets.linkedin,
                              color: Colors.white,
                              height: 24,
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
                    const SizedBox(width: AppInsets.xxl),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          final url =
                              'http://twitter.com/share?text=${shareText}&url=https://crater.club/session/${conversation.id}';
                          launch(url, forceSafariVC: false);
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AppSvgAssets.twitterBlack,
                              height: 24,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Expanded(
                              child: Text(
                                'Tweet',
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
                          ?.map((speaker) => _SpeakerWithIntro(
                                user: speaker,
                                authUserPk: authUserPK,
                              ))
                          .toList() ??
                      [],
                ),
                const Divider(thickness: 1, height: 80),
                Text(
                  'More from the series',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 40),
                SizedBox(
                    height: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 280.0,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: false,
                          ),
                          items: series.groupsDetailList?.where((element) => element.id != conversation.id).map((c) {
                            return Builder(
                              builder: (BuildContext context) {
                                return GroupGridTile(c);
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    )),
                const SizedBox(height: 200)
              ],
            ),
          )),
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
                          ))
                        else if (canJoin) // AUDIENCE
                          Expanded(
                              child: BaseLargeButton(
                            onPressed: () {
                              startDyteMeeting(context);
                            },
                            text: AppLocalizations.of(context)?.translate(
                                    "conversation_screen:go_live_label") ??
                                '',
                          ))
                        else
                          Expanded(
                            child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Theme.of(context).accentColor,
                                      width: 2,
                                    )),
                                child: Text(
                                  'You will be notified when ${conversation.hostDetail?.name} is live',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.subtitle2,
                                )),
                          )
                      else
                        Expanded(
                          child: BaseLargeButton(
                              onPressed: () {
                                _requestJoinGroup(context);
                              },
                              text: 'RSVP for the series'),
                        )
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

  void startDyteMeeting(BuildContext context) async {
    final loginStatus = await manageLoginPopup(context);
    if (loginStatus == false) {
      return;
    }

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DyteMeetingScreen(meetingId: data.conversation.id!)));
  }

  Future<void> _requestJoinGroup(BuildContext context) async {
    final loginStatus = await manageLoginPopup(context);
    if (loginStatus == false) {
      return;
    }

    overlayEntry = buildLoaderOverlay();
    Overlay.of(context)?.insert(overlayEntry!);

    final response = await context
        .read(seriesStateProvider(series.id!).notifier)
        .postRequestToRSVP();

    response.fold(
      (failure) {
        overlayEntry?.remove();
        Fluttertoast.showToast(msg: failure.message!);
      },
      (request) {
        final analytics = KiwiContainer().resolve<Analytics>();
        analytics.trackEvent(
            eventName: AnalyticsEvents.conversationGroupJoined,
            properties: {
              "id": request.seriesId
            });
        _updateConversation(context);
      },
    );
  }

  Future<void> _updateConversation(BuildContext context) async {

    final seriesResponse = await context
        .read(seriesStateProvider(series.id!).notifier)
        .retrieveSeries(justRSVPed: true);

    final response = await context
        .read(conversationStateProvider(data.conversation.id!).notifier)
        .retrieveConversation(justRSVPed: true);

    response.fold(
      (failure) {
        overlayEntry?.remove();
        Fluttertoast.showToast(msg: failure.message!);
      },
      (group) async {
        overlayEntry?.remove();

        // final now = DateTime.now().toLocal();
        // final start = group.start?.toLocal();
        // final end = group.end?.toLocal();

        // if (now.isAfter(start) && now.isBefore(end)) {
        // context
        //     .read(conversationStateProvider(conversation.id!).notifier)
        //     .connectToAudioCall();
        // } else {
        context
            .read(popupManagerProvider)
            .showPopup(PopupType.conversationJoin, context);

        await showEmail(context);

        // AutoRouter.of(context).pushAndPopUntil(
        //   OnboardingScreenRoute(type: OnboardingType.meetingJoining.toString()),
        //   predicate: (_) => false,
        // );
        // }
      },
    );
  }

  Future<void> showEmail(BuildContext context) async {
    final email = BlocProvider.of<AuthBloc>(context).state.user?.email;

    if (email != null && email.isNotEmpty) {
      return;
    }
    await showModalBottomSheet(
      elevation: 10,
      backgroundColor: Colors.transparent,
      context: context,
      isDismissible: false,
      enableDrag: false,
      useRootNavigator: false,
      isScrollControlled: true,
      builder: (context) {
        return const ProfileEmailScreen(editMode: true);
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
            userId: user.pk ?? '', allowEdit: authUserPk == user.pk),
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

class GroupGridTile extends StatelessWidget {
  final GroupsDetailList item;
  const GroupGridTile(
    this.item, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final conversation = item;
    final user = conversation.hostDetail;
    final topic = conversation.topicDetail;
    final tag = topic?.root;
    String description = user?.introduction ?? topic?.name ?? ' ';
    if (description.isEmpty) {
      description = conversation.description ?? '';
    }
    final title = user?.name ?? '';

    return InkWell(
      onTap: () async {
        if (item.closed == true || item.recordingDetails?.recording != null) {
          AutoRouter.of(context)
              .push(PastStreamDetailScreenRoute(id: conversation.id));
        } else {
          AutoRouter.of(context)
              .push(ConversationScreenRoute(id: conversation.id));
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: GridTile(
            child: Container(
          color: Theme.of(context).dialogBackgroundColor,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Theme.of(context).dialogBackgroundColor,
                  width: double.infinity,
                  height: double.infinity,
                  child: Stack(
                    children: [
                      if (topic?.image != null)
                        Image.network(
                          topic?.image ?? '',
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      if (item.type == GridItemType.featured)
                        LiveTime(date: conversation.start?.toLocal()),
                      if (item.type == GridItemType.live)
                        Container(
                          margin: const EdgeInsets.only(top: 8, left: 12),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.red,
                          ),
                          child: const Text('LIVE'),
                        ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(user?.photo ?? ''),
                                  backgroundColor:
                                      Theme.of(context).dialogBackgroundColor,
                                  radius: 16,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  title,
                                  style: Theme.of(context).textTheme.subtitle2,
                                  maxLines: 2,
                                ),
                              ),
                              const SizedBox(width: 8),
                              if (tag?.name?.isNotEmpty ?? false)
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        color: Colors.white, width: 0.5),
                                  ),
                                  child: Text(
                                    tag?.name ?? '',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            description,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
