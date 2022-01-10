import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/core/widgets/base/base_network_image/base_network_image.dart';
import 'package:worknetwork/features/auth/domain/entity/user_tag_entity.dart';
import 'package:worknetwork/features/connection/presentation/screen/time_slots/timeslots_screen.dart';
import 'package:worknetwork/features/connection/presentation/widget/connectable_list/connectable_list_state.dart';
import 'package:worknetwork/features/profile/domain/entity/profile_entity/profile_entity.dart';
import 'package:worknetwork/ui/base/base_large_button/base_large_button.dart';

import '../../../../../routes.gr.dart';

class ConnectableList extends HookWidget {
  final UserTag tag;

  const ConnectableList({required this.tag});

  @override
  Widget build(BuildContext context) {
    final requestState =
        useProvider(connectableStateProvider(tag.pk.toString()));
    final _controller = useScrollController();
    _controller.addListener(() {
      // reached End of scroll
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        context
            .read(connectableStateProvider(tag.pk.toString()).notifier)
            .getNextPageConnectableProfileList(tag.pk.toString());
      }
    });
    return requestState.when(
        loading: () => Container(),
        error: (err, st) => Container(),
        data: (profiles) => SizedBox(
            height: profiles.isEmpty ? 0 : 280,
            child: ListView.separated(
                controller: _controller,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                scrollDirection: Axis.horizontal,
                itemCount: profiles.length,
                padding: const EdgeInsets.only(left: 20, right: 80),
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      if (index == 0) MatchMeCard(tag: tag),
                      if (index == 0) const SizedBox(width: 8),
                      ConnectableCard(
                        user: profiles[index],
                        authUserPk: 0, //TODO: pass auth user pk.
                        showConnect: profiles[index].pk != 0,
                      ),
                    ],
                  );
                })));
  }
}

class MatchMeCard extends StatelessWidget {
  const MatchMeCard({
    Key? key,
    required this.tag,
  }) : super(key: key);

  final UserTag tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(16)),
      width: 200,
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Connect with ${tag.name}',
            style: Theme.of(context).textTheme.headline6,
            maxLines: 3,
          ),
          const SizedBox(height: 20),
          Text(
            'Let our AI engine curate\n1:1 meetings for you',
            style: Theme.of(context).textTheme.caption,
          ),
          const Spacer(),
          BaseLargeButton(
            onPressed: () =>
                AutoRouter.of(context).push(TopicsListRoute(showTitle: true)),
            text: 'Match me',
          )
        ],
      ),
    );
  }
}

class ConnectableCard extends StatelessWidget {
  final Profile user;
  final int? authUserPk;
  final bool showConnect;
  const ConnectableCard({
    Key? key,
    required this.user,
    this.authUserPk,
    required this.showConnect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final description = user.tag?.first.name ?? '';
    final headingStyle = Theme.of(context).textTheme.subtitle1;
    final bodyStyle = Theme.of(context).textTheme.caption;
    return InkWell(
      onTap: () => AutoRouter.of(context).push(
        ProfileScreenRoute(
            userId: user.uuid!, allowEdit: authUserPk == user.pk),
      ),
      child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: 160,
            child: Column(
              children: [
                SizedBox(
                  height: 104,
                  width: 104,
                  child: BaseNetworkImage(
                    imageUrl: user.photo,
                    defaultImage: AppImageAssets.defaultAvatar,
                    imagebuilder: (context, imageProvider) => CircleAvatar(
                      backgroundImage: imageProvider,
                      radius: 52,
                    ),
                  ),
                ),
                const SizedBox(height: AppInsets.xl),
                Text(
                  user.name ?? '',
                  style: headingStyle,
                  textAlign: TextAlign.center,
                ),
                if (description.isNotEmpty)
                  const SizedBox(height: AppInsets.sm),
                if (description.isNotEmpty)
                  Text(
                    description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: bodyStyle,
                    textAlign: TextAlign.center,
                  ),
                if (showConnect == true) const SizedBox(height: AppInsets.xxl),
                if (showConnect == true)
                  BaseLargeButton(
                    onPressed: () => _showTimeSlots(context),
                    text: 'Connect',
                    outlined: true,
                  )
              ],
            ),
          )),
    );
  }

  Future<void> _showTimeSlots(BuildContext context) async {
    showModalBottomSheet(
      elevation: 10,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppBorderRadius.bottomSheetRadius),
            topRight: Radius.circular(AppBorderRadius.bottomSheetRadius),
          ),
          child: TimeSlotsScreen(profileId: user.uuid!),
        );
      },
    );
  }
}
