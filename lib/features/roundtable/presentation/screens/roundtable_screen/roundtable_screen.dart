import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide ReadContext;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';

import '../../../../../constants/theme.dart';
import '../../../../../core/widgets/base/base_large_button/base_large_button.dart';
import '../../../../../ui/base/base_app_bar/base_app_bar.dart';
import '../../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../domain/entity/roundtable_entity/roundtable_entity.dart';
import '../../widgets/editable_text_field/editable_text_field.dart';
import '../../widgets/rtc_connection_bar/rtc_connection_bar.dart';
import '../../widgets/speaker_avatar/speaker_avatar.dart';
import 'roundtable_screen_controller.dart';

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
    Share.share("Share WorkNetwork");
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

    // Controller
    final controller = useProvider(roundTableScreenControllerProvider(table));
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppInsets.xl, vertical: AppInsets.l),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (table.topic.root != null)
                  Text(table.topic.root.name, style: categoryStyle),
                if (table.topic.root != null)
                  const SizedBox(height: AppInsets.sm),
                Text(table.topic.name, style: agendaStyle),
                const SizedBox(height: AppInsets.sm),
                Text(startDateFormat.format(table.start), style: dateStyle),
                const SizedBox(height: AppInsets.l),
                EditableTextField(text: table.description),
                const SizedBox(height: AppInsets.xl),
                Text("Speakers(${table.speakers.length})",
                    style: pageLabelStyle),
                const SizedBox(height: AppInsets.l),
                Wrap(
                  spacing: AppInsets.xxl,
                  children: controller.speakers
                      .map((member) => SpeakerAvatar(
                            user: member,
                            isLive: controller.connectionState ==
                                RtcConnectionState.connected,
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: 120,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              fit: StackFit.expand,
              children: _buildActionButton(context, controller),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildActionButton(
      BuildContext context, RoundTableScreenController controller) {
    final bool showConnectionBar = controller.showConnectionBar;
    final List<Widget> items = [];
    final user = BlocProvider.of<AuthBloc>(context).state.user;
    final isSpeaker =
        table.speakers.where((speaker) => speaker.pk == user.pk).isNotEmpty;
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
      if (isSpeaker) {
        items.add(overlay);

        items.add(
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppInsets.xxl),
              child: BaseLargeButton(
                width: MediaQuery.of(context).size.width * 0.6,
                onPressed: () {
                  controller.joinRoundTableChannel(user);
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
                child: Text("Join Table"),
              ),
            ),
          ),
        );
      }
    }

    return items;
  }

  Future<void> postRequestToJoinGroup(BuildContext context,
      RoundTableScreenController controller, int group) async {
    final response = await controller.requestToJoinGroup(group);
    final _overlay = _buildLoaderOverlay();
    Overlay.of(context).insert(_overlay);
    response.fold(
      (failure) {
        _overlay.remove();
        Fluttertoast.showToast(msg: failure.message);
      },
      (result) {
        final tableId = result.groupDetail.id;
        _overlay.remove();
        context.read(getRoundTableNotifier(tableId)).getTableInfo(tableId);
      },
    );
  }

  OverlayEntry _buildLoaderOverlay() {
    return OverlayEntry(
      builder: (context) {
        return Container();
      },
    );
  }
}
