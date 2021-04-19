import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide ReadContext;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:worknetwork/core/features/popup_manager/popup_manager.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../constants/theme.dart';
import '../../../../../core/widgets/base/base_large_button/base_large_button.dart';
import '../../../../../core/widgets/base/base_network_image/base_network_image.dart';
import '../../../../../routes.gr.dart';
import '../../../../../ui/base/base_app_bar/base_app_bar.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../auth/domain/entity/user_entity.dart';
import '../../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../domain/entity/roundtable_entity/roundtable_entity.dart';
import '../../widgets/editable_text_field/editable_text_field.dart';
import '../../widgets/roundtable_card/speakers_table.dart';
import '../../widgets/rtc_connection_bar/rtc_connection_bar.dart';
import 'roundtable_screen_controller.dart';

const kSpacingList = 24.00;
const kListBottomPadding = 124.00;

class RoundTableScreen extends HookWidget {
  final int id;

  const RoundTableScreen({
    @PathParam("id") this.id,
  });

  @override
  Widget build(BuildContext context) {
    final state = useProvider(getRoundTableNotifier(id).state);

    return Scaffold(
      appBar: BaseAppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _onShare,
          ),
        ],
      ),
      body: state.when(
        loading: () => _Loader(),
        data: (table) => _RoundTableLoaded(
          table: table,
        ),
        error: (error, st) => Container(),
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
  final RoundTable table;

  const _RoundTableLoaded({
    Key key,
    this.table,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Styles
    final primaryColor = Theme.of(context).primaryColor;
    final categoryStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 16,
          color: primaryColor,
        );
    final agendaStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 22,
        );
    final startDateFormat = DateFormat("dd MMM, hh:mm a");
    final dateStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          color: Colors.grey,
        );
    final pageLabelStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 14,
          color: primaryColor,
          fontWeight: FontWeight.w700,
        );

    final authUserPK = BlocProvider.of<AuthBloc>(context).state.user.pk;

    // Controller
    final rtcController =
        useProvider(roundTableScreenControllerProvider(table));

    useEffect(() {
      rtcController.hideOverlayEntry();
      return;
    }, []);

    return WillPopScope(
      onWillPop: () async {
        if (rtcController.connectionState != RtcConnectionState.disconnected) {
          rtcController.showOverlayEntry(context);
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
                if (table.topicDetail.root != null)
                  Text(table.topicDetail.root.name, style: categoryStyle),
                if (table.topicDetail.root != null)
                  const SizedBox(height: AppInsets.sm),
                Text(table.topicDetail.name, style: agendaStyle),
                const SizedBox(height: AppInsets.sm),
                Text(table.topicDetail.name, style: agendaStyle),
                const SizedBox(height: AppInsets.sm),
                Text(startDateFormat.format(table.start), style: dateStyle),
                const SizedBox(height: AppInsets.l),
                EditableTextField(text: table.topicDetail.description),
                const SizedBox(height: AppInsets.xl),
                Text(
                    AppLocalizations.of(context)
                        .translate("conversations:speakers_label"),
                    style: pageLabelStyle),
                if (table.isSpeaker) const SizedBox(height: AppInsets.l),
                if (!table.isSpeaker) const SizedBox(height: AppInsets.xl),
                if (rtcController.showConnectionBar)
                  SpeakersTable(
                      speakers: rtcController.speakers,
                      chairSize: 60,
                      isLive: rtcController.connectionState ==
                          RtcConnectionState.connected),
                if (!rtcController.showConnectionBar)
                  _SpeakersListWithIntro(
                    table: table,
                    authUserPk: authUserPK,
                  ),
                const SizedBox(height: kListBottomPadding),
              ],
            ),
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 120,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                fit: StackFit.expand,
                children: _buildActionButton(context, rtcController),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildActionButton(
      BuildContext context, RoundTableScreenController controller) {
    final bool showConnectionBar = controller.showConnectionBar;
    final List<Widget> items = [];
    final user = BlocProvider.of<AuthBloc>(context).state.user;

    final overlay = Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.white,
            Colors.white.withOpacity(0.0),
          ],
        ),
      ),
    );

    if (showConnectionBar) {
      items.add(overlay);
      items.add(Align(
        alignment: Alignment.bottomCenter,
        child: RtcConnectionBar(
          table: table,
          controller: controller,
        ),
      ));
    } else {
      if (table.isSpeaker) {
        items.add(overlay);

        items.add(
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppInsets.xxl),
              child: BaseLargeButton(
                width: MediaQuery.of(context).size.width * 0.6,
                onPressed: () {
                  _joinRoundTableChannel(context, user, controller);
                },
                child: Text("Join Table"),
              ),
            ),
          ),
        );
      } else {
        items.add(overlay);

        items.add(
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppInsets.xxl),
              child: BaseLargeButton(
                width: MediaQuery.of(context).size.width * 0.6,
                onPressed: () {
                  postRequestToJoinGroup(context, controller, table.id);
                },
                child: Text(AppLocalizations.of(context)
                    .translate("conversations:join_button_label")),
              ),
            ),
          ),
        );
      }
    }

    return items;
  }

  void _joinRoundTableChannel(
      BuildContext context, User user, RoundTableScreenController controller) {
    if (!controller.hasOngoingMeeting()) {
      controller.joinRoundTableChannel(user);
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Leave Ongoing RoundTable"),
          content: Text("Confirm to leave the roundtable discussion."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('CANCEL', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                controller.joinRoundTableChannel(user);
                Navigator.pop(context);
              },
              child: Text('LEAVE'),
            ),
          ],
        );
      },
    );
  }

  Future<void> postRequestToJoinGroup(BuildContext context,
      RoundTableScreenController controller, int group) async {
    final _overlay = _buildLoaderOverlay();
    Overlay.of(context).insert(_overlay);
    try {
      final response = await controller.requestToJoinGroup(group);

      response.fold(
        (failure) {
          _overlay.remove();
          Fluttertoast.showToast(msg: failure.message);
        },
        (result) {
          final tableId = result.groupDetail.id;
          _overlay.remove();
          context.read(getRoundTableNotifier(tableId)).getTableInfo(tableId);

          final popupManager = context.read(popupManagerProvider);
          popupManager.showPopup(PopupType.conversationJoin, context);
        },
      );
    } catch (e) {
      Fluttertoast.showToast(msg: 'Some error occorred');
    }
  }

  OverlayEntry _buildLoaderOverlay() {
    return OverlayEntry(
      builder: (context) {
        return Container();
      },
    );
  }
}

class _SpeakersListWithIntro extends StatelessWidget {
  final RoundTable table;
  final String authUserPk;
  const _SpeakersListWithIntro({
    Key key,
    this.table,
    @required this.authUserPk,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];
    if (table.host != null) {
      children.add(_SpeakerWithIntro(
        user: table.hostDetail,
        authUserPk: authUserPk,
      ));
    }

    if (table.speakersDetailList != null &&
        table.speakersDetailList.isNotEmpty) {
      for (final speaker in table.speakersDetailList) {
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
  final RoundTableUser user;
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
    final bodyStyle =
        Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.grey[600]);
    return InkWell(
      onTap: () => ExtendedNavigator.of(context).push(Routes.profileScreen(
          userId: user.pk, allowEdit: authUserPk == user.pk)),
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
