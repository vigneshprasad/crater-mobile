import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide ReadContext;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/core/widgets/base/base_container/base_container.dart';
import 'package:worknetwork/features/conversations/presentation/widgets/conversation_card/conversation_card.dart';
import 'package:worknetwork/features/conversations/presentation/widgets/conversation_overlay_indicator/conversation_overlay_controller.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../constants/theme.dart';
import '../../../../../core/custom_tabs/custom_tabs.dart';
import '../../../../../core/widgets/base/base_large_button/base_large_button.dart';
import '../../../../../core/widgets/base/base_network_image/base_network_image.dart';
import '../../../../../routes.gr.dart';
import '../../../../../ui/base/base_app_bar/base_app_bar.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../article/domain/entity/article_entity/article_entity.dart';
import '../../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../domain/entity/conversation_entity/conversation_entity.dart';
import '../../../domain/entity/rtc_user_entity/rtc_user_entity.dart';
import '../../widgets/rtc_connection_bar/rtc_connection_bar.dart';
import '../../widgets/speakers_table/speakers_table.dart';
import 'conversation_screen_state.dart';

class ConversationScreen extends HookWidget {
  final int id;

  const ConversationScreen({
    @PathParam("id") this.id,
  });

  @override
  Widget build(BuildContext context) {
    final conversationState = useProvider(conversationStateProvider(id).state);
    final speakers = useProvider(conversationSpeakersState(id).state);
    final connectionProvider = useProvider(rtcConnectionProvider(id));
    final overlayProvider = useProvider(conversationOverlayProvider);

    useEffect(() {
      if (overlayProvider.entry != null) {
        overlayProvider.removeOverlayEntry();
        if (overlayProvider.groupId != id) {
          context
              .read(conversationStateProvider(overlayProvider.groupId))
              .leaveAudioCall();
        }
      }

      return;
    }, []);

    return Scaffold(
      appBar: BaseAppBar(),
      body: conversationState.when(
        loading: () => _Loader(),
        data: (conversation) => _ConversationLoaded(
          conversation: conversation,
          speakers: speakers,
          connection: connectionProvider.connection,
        ),
        error: (err, st) => _Loader(),
      ),
    );
  }
}

class _Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _ConversationLoaded extends StatelessWidget {
  final Conversation conversation;
  final List<RtcUser> speakers;
  final RtcConnection connection;

  const _ConversationLoaded({
    Key key,
    this.conversation,
    this.speakers,
    this.connection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Styles
    final rootTopicStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 14,
        );
    final startDateFormat = DateFormat("dd MMM, hh:mm a");
    final dateStyle = Theme.of(context).textTheme.bodyText2;
    final pageLabelStyle = Theme.of(context).textTheme.headline6;

    final authUserPK = BlocProvider.of<AuthBloc>(context).state.user.pk;

    return WillPopScope(
      onWillPop: () async {
        if (connection != RtcConnection.disconnected) {
          context
              .read(conversationStateProvider(conversation.id))
              .createAudioCallOverlay(context);
        }
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
                const SizedBox(height: AppInsets.sm),
                Text(startDateFormat.format(conversation.start.toLocal()),
                    style: dateStyle),
                ConversationCard(
                  conversation: conversation,
                  hideFooter: true,
                ),
                if (conversation.topicDetail.articleDetail == null)
                  Text(conversation.topicDetail.description),
                const SizedBox(height: AppInsets.xl),
                Center(
                  child: Text(
                      AppLocalizations.of(context)
                          .translate("conversations:speakers_label"),
                      style: pageLabelStyle),
                ),
                if (conversation.isSpeaker) const SizedBox(height: AppInsets.l),
                if (!conversation.isSpeaker)
                  const SizedBox(height: AppInsets.xl),
                if (connection == RtcConnection.disconnected)
                  _SpeakersListWithIntro(
                    speakers: speakers,
                    authUserPk: authUserPK,
                  )
                else
                  SpeakersTable(
                    speakers: speakers,
                    chairSize: 60,
                    isLive: connection == RtcConnection.connected,
                  ),
                const SizedBox(height: 120),
              ],
            ),
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Theme.of(context).backgroundColor,
              height: 120,
              width: MediaQuery.of(context).size.width,
              child: SafeArea(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (connection == RtcConnection.disconnected)
                      if (conversation.isSpeaker)
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: AppInsets.xl),
                            child: BaseContainer(
                              radius: 30,
                              child: BaseLargeButton(
                                width: MediaQuery.of(context).size.width * 0.6,
                                onPressed: () {
                                  context
                                      .read(conversationStateProvider(
                                          conversation.id))
                                      .connectToAudioCall();
                                },
                                child: Text(AppLocalizations.of(context)
                                    .translate(
                                        "conversation_screen:go_live_label")),
                              ),
                            ),
                          ),
                        )
                      else
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: AppInsets.xl),
                            child: BaseContainer(
                              radius: 30,
                              child: BaseLargeButton(
                                width: MediaQuery.of(context).size.width * 0.6,
                                onPressed: () {
                                  _requestJoinGroup(context);
                                },
                                child: Text(AppLocalizations.of(context)
                                    .translate(
                                        "conversations:join_button_label")),
                              ),
                            ),
                          ),
                        )
                    else
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: RtcConnectionBar(
                          table: conversation,
                          connection: connection,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _requestJoinGroup(BuildContext context) async {
    final response = await context
        .read(conversationStateProvider(conversation.id))
        .postRequestToJoinGroup();

    response.fold(
      (failure) => Fluttertoast.showToast(msg: failure.message),
      (request) => _updateConversation(context),
    );
  }

  Future<void> _updateConversation(BuildContext context) async {
    final response = await context
        .read(conversationStateProvider(conversation.id))
        .retrieveConversation();

    response.fold(
      (failure) {
        Fluttertoast.showToast(msg: failure.message);
      },
      (group) {
        final now = DateTime.now().toLocal();
        final start = group.start.toLocal();
        final end = group.end.toLocal();

        print(now.isAfter(start));

        if (now.isAfter(start) && now.isBefore(end)) {
          context
              .read(conversationStateProvider(conversation.id))
              .connectToAudioCall();
        }
      },
    );
  }
}

class _SpeakersListWithIntro extends StatelessWidget {
  final List<RtcUser> speakers;
  final String authUserPk;
  const _SpeakersListWithIntro({
    Key key,
    this.speakers,
    @required this.authUserPk,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];
    // if (table.host != null) {
    //   children.add(_SpeakerWithIntro(
    //     user: table.hostDetail,
    //     authUserPk: authUserPk,
    //   ));
    // }

    for (final speaker in speakers) {
      children.add(_SpeakerWithIntro(
        user: speaker.userInfo,
        authUserPk: authUserPk,
      ));
    }

    return Column(
      children: children,
    );
  }
}

class _SpeakerWithIntro extends StatelessWidget {
  final ConversationUser user;
  final String authUserPk;
  const _SpeakerWithIntro({
    Key key,
    @required this.user,
    @required this.authUserPk,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final description = user.introduction ?? user.email;
    final headingStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 16,
        );
    final bodyStyle = Theme.of(context).textTheme.bodyText2;
    return InkWell(
      onTap: () => ExtendedNavigator.of(context).push(
        Routes.profileScreen(userId: user.pk, allowEdit: authUserPk == user.pk),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
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
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.name, style: headingStyle),
                  const SizedBox(height: AppInsets.sm),
                  Text(
                    description,
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

class _ArticleDetailCard extends StatelessWidget {
  final Article article;

  const _ArticleDetailCard({
    Key key,
    @required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sourceLabelStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 14.00,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        );
    final contentStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 12.0,
          color: Colors.black54,
        );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppInsets.xl),
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8.00)),
          side: BorderSide(width: 2.00, color: Colors.grey[300]),
        ),
        color: Colors.white,
        type: MaterialType.card,
        child: InkWell(
          onTap: () {
            KiwiContainer().resolve<CustomTabs>().openLink(article.websiteUrl);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppInsets.l,
              horizontal: AppInsets.l,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    BaseNetworkImage(
                      imageUrl: article.articleSourceDetail.image,
                      defaultImage: AppImageAssets.videoPlaceholder,
                      imagebuilder: (context, imageProvider) => CircleAvatar(
                        backgroundImage: imageProvider,
                        radius: 12.00,
                      ),
                    ),
                    const SizedBox(width: AppInsets.l),
                    Text(article.articleSourceDetail.name,
                        style: sourceLabelStyle),
                  ],
                ),
                const SizedBox(height: AppInsets.l),
                Text(
                  article.title,
                  maxLines: 3,
                  style: contentStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
