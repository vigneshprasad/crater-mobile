import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide ReadContext;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/api_result/api_result.dart';
import 'package:worknetwork/core/widgets/base/base_container/base_container.dart';
import 'package:worknetwork/core/widgets/base/base_large_button/base_large_button.dart';
import 'package:worknetwork/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:worknetwork/features/profile/presentation/screens/profile_screen/profile_screen.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../constants/theme.dart';
import '../../../../../core/widgets/base/base_network_image/base_network_image.dart';
import '../../../../../routes.gr.dart';
import '../../../../auth/domain/entity/user_tag_entity.dart';
import '../../../../profile/domain/entity/profile_entity/profile_entity.dart';
import '../../../../profile/presentation/screens/profile_screen/gradient_button.dart';
import '../../screens/create_conversation_screen/timeslots_screen.dart';
import 'connection_tab_state.dart';

class ConnectionTab extends HookWidget {
  UserTag allTag = UserTag(name: 'All');
  UserTag? selectedTag;

  @override
  Widget build(BuildContext context) {
    final connectionState = useProvider(connectionStateProvider);
    final tagsState = useProvider(tagStateProvider);

    final requestState = useProvider(requestStateProvider);

    final user = BlocProvider.of<AuthBloc>(context).state.profile;

    final _controller = useScrollController();
    _controller.addListener(() {
      // reached End of scroll
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        context
            .read(connectionStateProvider.notifier)
            .getNextPageProfileList(selectedTag?.pk?.toString() ?? '');
      }
    });
    return RefreshIndicator(
      displacement: 96.00,
      onRefresh: () {
        final futures = [
          context
              .read(connectionStateProvider.notifier)
              .getProfileList(selectedTag?.pk?.toString() ?? ''),
          context.read(tagStateProvider.notifier).getTagList(),
        ];

        return Future.wait(futures);
      },
      child: Column(
        children: [
          tagsState.when(
            loading: () => Container(),
            error: (err, st) => Container(
              height: 200,
              width: 200,
              child: Center(
                child: Text(err.toString()),
              ),
            ),
            data: (tags) {
              selectedTag = selectedTag ?? allTag;
              tags = [allTag] + tags;
              return SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tags.length,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: FilterChip(
                        visualDensity: VisualDensity.compact,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        selected: selectedTag?.name == tags[index].name,
                        showCheckmark: false,
                        selectedColor: Colors.white,
                        label: Text(
                          tags[index].name ?? '',
                          style: TextStyle(
                              color: selectedTag?.name == tags[index].name
                                  ? Colors.black
                                  : Colors.white),
                        ),
                        backgroundColor: Colors.black,
                        side: BorderSide(color: Colors.white),
                        onSelected: (value) {
                          selectedTag = tags[index];
                          context
                              .read(connectionStateProvider.notifier)
                              .getProfileList(
                                  selectedTag?.pk?.toString() ?? '');
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
          connectionState.when(
            loading: () => const CircularProgressIndicator(),
            error: (err, st) => Container(
              height: 200,
              width: 200,
              color: Colors.red,
            ),
            data: (profiles) => Expanded(
              child: ListView.builder(
                padding:
                    const EdgeInsets.only(left: 20, right: 20, bottom: 100),
                itemCount: profiles.length +
                    (context.read(connectionStateProvider.notifier).allLoaded
                        ? 0
                        : 1),
                controller: _controller,
                itemBuilder: (BuildContext context, int index) {
                  if (index == profiles.length) {
                    return const Padding(
                      padding: EdgeInsets.all(40.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (index == 0)
                        connectableProfiles(context, requestState, user?.pk),
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
          )
        ],
      ),
    );
  }

  Widget connectableProfiles(BuildContext context,
      ApiResult<List<Profile>> requestState, int? userPk) {
    return requestState.when(
      loading: () => Container(),
      error: (err, st) => Container(),
      data: (profiles) => Column(
        children: List.generate(profiles.length, (index) => index)
            .map(
              (index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (index == 0)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: UnderlinedText(
                        'CONNECT NOW',
                        bgText: 'INSTANT',
                      ),
                    ),
                  _Connection(
                    user: profiles[index],
                    authUserPk: userPk, //TODO: pass auth user pk.
                    showConnect: (profiles[index].pk == userPk ? false : true),
                  ),
                ],
              ),
            )
            .toList(),
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
    final headingStyle = Theme.of(context).textTheme.bodyText1?.copyWith(
          fontSize: 16,
        );
    final bodyStyle = Theme.of(context).textTheme.bodyText2;
    return InkWell(
      onTap: () => AutoRouter.of(context).push(
        ProfileScreenRoute(
            userId: user.uuid!, allowEdit: authUserPk == user.pk),
      ),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
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
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: bodyStyle,
                        ),
                      if (showConnect == true)
                        const SizedBox(height: AppInsets.med),
                      if (showConnect == true)
                        Align(
                          alignment: Alignment.centerRight,
                          child: BaseContainer(
                            radius: 30,
                            child: SizedBox(
                              width: 90,
                              height: 32,
                              child: BaseLargeButton(
                                onPressed: () => _showTimeSlots(context),
                                child: const Text(
                                  'CONNECT',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
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
