import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/profile/presentation/screens/profile_screen/profile_about.dart';
import 'package:worknetwork/features/profile/presentation/screens/profile_screen/profile_screen_state.dart';
import 'package:worknetwork/features/profile/presentation/screens/profile_screen/profile_streams_tab.dart';
import 'package:worknetwork/features/profile/presentation/widget/profile_app_bar.dart';

class ProfileScreen extends HookConsumerWidget {
  final String userId;
  final int? createrId;
  final bool allowEdit;

  const ProfileScreen(
    @PathParam('userId') this.userId, {
    @PathParam('createrId') this.createrId,
    @PathParam('allowEdit') required this.allowEdit,
  });

  static const tabs = [
    "Streams",
    "About",
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(getProfileNotifierProvider(userId));

    ref
        .watch(getProfileNotifierProvider(userId).notifier)
        .retrieveProfile(creatorId: createrId);

    final index = useState(0);

    return profileState.when(
      data: (state) => Scaffold(
        body: DefaultTabController(
          length: tabs.length,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              ProfileAppBar(
                allowEdit: allowEdit,
                tabs: tabs,
                context: context,
                profile: state.profile,
                creator: state.creator,
                index: index,
              ),
            ],
            body: TabBarView(
              children: [
                ProfileStreamsTab(userId),
                AboutTab(
                  profile: state.profile,
                  meta: state.meta,
                  showLogout: allowEdit,
                ),
              ],
            ),
          ),
        ),
      ),
      loading: () => Scaffold(
        body: DefaultTabController(
          initialIndex: index.value,
          length: tabs.length,
          child: SafeArea(
            bottom: false,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                ProfileAppBar(
                  allowEdit: allowEdit,
                  tabs: tabs,
                  context: context,
                  profile: null,
                  index: index,
                ),
              ],
              body: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ),
        ),
      ),
      error: (error, stackTrace) => Center(
        child: Text(error.toString()),
      ),
    );
  }
}
