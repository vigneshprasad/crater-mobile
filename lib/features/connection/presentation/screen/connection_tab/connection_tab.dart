import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide ReadContext;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:worknetwork/features/club/presentation/widgets/home_app_bar.dart';
import 'package:worknetwork/features/connection/presentation/screen/time_slots/timeslots_screen.dart';
import 'package:worknetwork/features/connection/presentation/widget/connectable_list/connectable_list.dart';
import 'package:worknetwork/features/connection/presentation/widget/featured_list/featured_list.dart';
import 'package:worknetwork/features/profile/presentation/widget/underline_text.dart';
import 'package:worknetwork/ui/base/base_large_button/base_large_button.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../constants/theme.dart';
import '../../../../../core/widgets/base/base_network_image/base_network_image.dart';
import '../../../../../routes.gr.dart';
import '../../../../profile/domain/entity/profile_entity/profile_entity.dart';
import 'connection_tab_state.dart';

class ConnectionTab extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final tagsState = useProvider(tagStateProvider);
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (context, _) => const [
          HomeAppBar(
            title: 'Network',
          )
        ],
        body: RefreshIndicator(
          color: Theme.of(context).accentColor,
          onRefresh: () {
            final futures = [
              context.read(tagStateProvider.notifier).getTagList(),
            ];

            return Future.wait(futures);
          },
          child: tagsState.when(
            loading: () => Container(),
            error: (err, st) => Center(child: Text(err.toString())),
            data: (tags) {
              return ListView.builder(
                itemCount: tags.length,
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (index == 0)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text('Crater Featured',
                                  style: Theme.of(context).textTheme.headline6),
                            ),
                            const SizedBox(height: 20),
                            FeaturedList(),
                            const SizedBox(height: 40),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text('Member only',
                                  style: Theme.of(context).textTheme.headline6),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Let the AI match you or request a meeting with your preferences',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ConnectableList(tag: tags[index]),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class ConnectionList extends HookWidget {
  final String? tag;
  final String userId;

  const ConnectionList({Key? key, this.tag, this.userId = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<AuthBloc>(context).state.profile;
    final _controller = useScrollController();
    _controller.addListener(() {
      // reached End of scroll
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        context
            .read(connectionStateProvider(userId).notifier)
            .getNextPageProfileList(tag ?? '');
      }
    });
    final connectionState = useProvider(connectionStateProvider(userId));
    return connectionState.when(
      loading: () => Center(
          child: CircularProgressIndicator(
        color: Theme.of(context).accentColor,
      )),
      error: (err, st) => Center(
        child: Text(err.toString()),
      ),
      data: (profiles) => Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.only(bottom: 100),
          itemCount: profiles.length +
              (context.read(connectionStateProvider(userId).notifier).allLoaded
                  ? 0
                  : 1),
          controller: _controller,
          itemBuilder: (BuildContext context, int index) {
            if (index == profiles.length) {
              return Padding(
                padding: const EdgeInsets.all(40.0),
                child: Center(
                    child: CircularProgressIndicator(
                  color: Theme.of(context).accentColor,
                )),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (index == 0)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: UnderlinedText(
                      'MATCH ME',
                      bgText: 'CURATED',
                    ),
                  ),
                _Connection(
                  user: profiles[index],
                  authUserPk: user?.pk, //TODO: pass auth user pk.
                  showConnect: false,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Connection extends StatelessWidget {
  final Profile user;
  final int? authUserPk;
  final bool showConnect;
  const _Connection({
    Key? key,
    required this.user,
    this.authUserPk,
    required this.showConnect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final description = user.introduction ?? user.generatedIntroduction ?? '';
    final headingStyle = Theme.of(context).textTheme.subtitle1;
    final bodyStyle = Theme.of(context).textTheme.caption;
    return InkWell(
      onTap: () => AutoRouter.of(context).push(
        ProfileScreenRoute(
            userId: user.uuid!, allowEdit: authUserPk == user.pk),
      ),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
                // color:
                //     Theme.of(context).dialogBackgroundColor.withAlpha(50),
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                SizedBox(
                  width: 72,
                  child: BaseNetworkImage(
                    imageUrl: user.photo,
                    defaultImage: AppImageAssets.defaultAvatar,
                    imagebuilder: (context, imageProvider) => CircleAvatar(
                      backgroundImage: imageProvider,
                      radius: 36,
                    ),
                  ),
                ),
                const SizedBox(width: AppInsets.xl),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.name ?? '', style: headingStyle),
                      if (description.isNotEmpty)
                        const SizedBox(height: AppInsets.sm),
                      if (description.isNotEmpty)
                        Text(
                          description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: bodyStyle,
                        ),
                    ],
                  ),
                ),
                if (showConnect == true) const SizedBox(height: AppInsets.xl),
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
