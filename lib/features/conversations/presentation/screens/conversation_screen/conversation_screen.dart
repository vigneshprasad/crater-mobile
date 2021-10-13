import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart' hide ReadContext;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:worknetwork/core/features/popup_manager/popup_manager.dart';
import 'package:worknetwork/core/widgets/root_app.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../constants/theme.dart';
import '../../../../../core/error/failures/failures.dart';
import '../../../../../core/widgets/base/base_container/base_container.dart';
import '../../../../../core/widgets/base/base_container/scaffold_container.dart';
import '../../../../../core/widgets/base/base_large_button/base_large_button.dart';
import '../../../../../core/widgets/base/base_network_image/base_network_image.dart';
import '../../../../../routes.gr.dart';
import '../../../../../ui/base/base_app_bar/base_app_bar.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../auth/domain/entity/user_entity.dart';
import '../../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../data/models/conversation_failures/conversation_failures.dart';
import '../../../domain/entity/conversation_entity/conversation_entity.dart';
import '../../widgets/conversation_card/conversation_card.dart';
import '../../widgets/editable_text_field/editable_text_field.dart';
import '../../widgets/rtc_connection_bar/rtc_connection_bar.dart';
import '../../widgets/speakers_table/speakers_table.dart';
import 'conversation_screen_controller.dart';

part 'conversation_screen_error.dart';

const kSpacingList = 24.00;
const kListBottomPadding = 124.00;

class ConversationScreen extends HookWidget {
  final int? id;

  const ConversationScreen({
    @PathParam("id") this.id,
  });

  @override
  Widget build(BuildContext context) {
    final state = useProvider(getRoundTableNotifier(id!));
    return Scaffold(
      appBar: BaseAppBar(
        actions: [
          BaseContainer(
            radius: 30,
            child: IconButton(
              icon: const Icon(Icons.share),
              onPressed: _onShare,
            ),
          ),
        ],
      ),
      body: state.when(
        loading: () => _Loader(),
        data: (table) => _RoundTableLoaded(
          table: table,
        ),
        error: (error, st) => _ConversationError(failure: error),
      ),
    );
  }

  void _onShare() {
    Share.share(
      AppConstants.defaultShareText,
      subject: "Know any relevant people?",
    );
  }
}

class _Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _RoundTableLoaded extends HookWidget {
  final Conversation table;

  const _RoundTableLoaded({
    Key? key,
    required this.table,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Styles
    final startDateFormat = DateFormat("dd MMM, hh:mm a");
    final dateStyle = Theme.of(context).textTheme.bodyText2;
    final pageLabelStyle = Theme.of(context).textTheme.headline6;

    final authUserPK = BlocProvider.of<AuthBloc>(context).state.user!.pk;

    // Controller
    final rtcController =
        useProvider(conversationScreenControllerProvider(table));

    useEffect(() {
      rtcController.hideOverlayEntry();
      return;
    }, []);

    return WillPopScope(
      onWillPop: () async {
        if (rtcController.connectionState != RtcConnectionState.disconnected) {
          // rtcController.showOverlayEntry(context);
        }
        return true;
      },
      child: Stack(
        children: [
          ScaffoldContainer(
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppInsets.xl, vertical: AppInsets.xxl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (table.topicDetail!.root != null)
                    Chip(
                        backgroundColor:
                            Theme.of(context).dialogBackgroundColor,
                        visualDensity: VisualDensity.compact,
                        label: Text(
                          table.topicDetail?.root?.name ?? '',
                        )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(startDateFormat.format(table.start!.toLocal()),
                        style: dateStyle),
                  ),
                  ConversationCard(
                    conversation: table,
                    // hideFooter: true,
                    // onCardPressed: (_) {},
                  ),
                  const SizedBox(height: AppInsets.l),
                  if (table.topicDetail!.articleDetail == null)
                    EditableTextField(text: table.topicDetail!.description!),
                  const SizedBox(height: AppInsets.xl),
                  Center(
                    child: Text(
                        AppLocalizations.of(context)
                                ?.translate("conversations:speakers_label") ??
                            '',
                        style: pageLabelStyle),
                  ),
                  if (table.isSpeaker!) const SizedBox(height: AppInsets.l),
                  if (!table.isSpeaker!) const SizedBox(height: AppInsets.xl),
                  if (rtcController.showConnectionBar)
                    SpeakersTable(
                        speakers: rtcController.speakers,
                        chairSize: 60,
                        isLive: rtcController.connectionState ==
                            RtcConnectionState.connected),
                  if (!rtcController.showConnectionBar)
                    _SpeakersListWithIntro(
                      table: table,
                      authUserPk: authUserPK!,
                    ),
                  const SizedBox(height: kListBottomPadding),
                ],
              ),
            )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: SizedBox(
                height: 120,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  fit: StackFit.expand,
                  children: _buildActionButton(context, rtcController),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildActionButton(
      BuildContext context, ConversationScreenController controller) {
    final bool showConnectionBar = controller.showConnectionBar;
    final List<Widget> items = [];
    final user = BlocProvider.of<AuthBloc>(context).state.user!;

    if (showConnectionBar) {
      items.add(Align(
        alignment: Alignment.bottomCenter,
        child: RtcConnectionBar(
          table: table,
        ),
      ));
    } else if (!table.isPast!) {
      if (table.isSpeaker!) {
        final label = AppLocalizations.of(context)
            ?.translate("conversation_screen:go_live_label");

        items.add(
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppInsets.xxl),
              child: BaseContainer(
                radius: 30,
                child: BaseLargeButton(
                  width: MediaQuery.of(context).size.width * 0.6,
                  onPressed: () {
                    _joinRoundTableChannel(context, user, controller);
                  },
                  child: Text(label!),
                ),
              ),
            ),
          ),
        );
      } else {
        items.add(
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppInsets.xxl),
              child: BaseContainer(
                radius: 30,
                child: BaseLargeButton(
                  width: MediaQuery.of(context).size.width * 0.6,
                  onPressed: () {
                    postRequestToJoinGroup(context, controller, table.id!);
                  },
                  child: Text(AppLocalizations.of(context)
                          ?.translate("conversations:join_button_label") ??
                      ''),
                ),
              ),
            ),
          ),
        );
      }
    }

    return items;
  }

  void _joinRoundTableChannel(BuildContext context, User user,
      ConversationScreenController controller) {
    if (!controller.hasOngoingMeeting()) {
      controller.joinRoundTableChannel(user);
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Leave Ongoing RoundTable"),
          content: const Text("Confirm to leave the roundtable discussion."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('CANCEL', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                controller.joinRoundTableChannel(user);
                Navigator.pop(context);
              },
              child: const Text('LEAVE'),
            ),
          ],
        );
      },
    );
  }

  Future<void> postRequestToJoinGroup(BuildContext context,
      ConversationScreenController controller, int group) async {
    final _overlay = buildLoaderOverlay();
    Overlay.of(context)?.insert(_overlay);
    final response = await controller.requestToJoinGroup(group);

    response.fold(
      (failure) {
        _overlay.remove();
        Fluttertoast.showToast(msg: failure.message!);
      },
      (result) {
        final tableId = result.groupDetail!.id;
        _overlay.remove();
        _updatedTableAndShowPopup(context, tableId!);
      },
    );
  }

  Future<void> _updatedTableAndShowPopup(
      BuildContext context, int tableId) async {
    final response = await context
        .read(getRoundTableNotifier(tableId).notifier)
        .getTableInfo(tableId);

    response.fold(
      (l) {},
      (group) {
        context
            .read(popupManagerProvider)
            .showPopup(PopupType.conversationJoin, context);
      },
    );
  }
}

class _SpeakersListWithIntro extends StatelessWidget {
  final Conversation table;
  final String authUserPk;
  const _SpeakersListWithIntro({
    Key? key,
    required this.table,
    required this.authUserPk,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];

    if (table.speakersDetailList != null &&
        table.speakersDetailList!.isNotEmpty) {
      for (final speaker in table.speakersDetailList!) {
        children.add(_SpeakerWithIntro(
          user: speaker,
          authUserPk: authUserPk,
        ));
      }
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
    Key? key,
    required this.user,
    required this.authUserPk,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final description = user.introduction ?? user.email;
    final headingStyle = Theme.of(context).textTheme.bodyText1?.copyWith(
          fontSize: 16,
        );
    final bodyStyle = Theme.of(context).textTheme.bodyText2;
    return InkWell(
      onTap: () => AutoRouter.of(context).push(ProfileScreenRoute(
          userId: user.pk!, allowEdit: authUserPk == user.pk)),
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
