import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/connection/presentation/screen/connection_tab/connection_tab.dart';
import 'package:worknetwork/features/profile/presentation/screens/profile_screen/profile_about.dart';
import 'package:worknetwork/features/profile/presentation/screens/profile_screen/profile_streams_tab.dart';
import 'package:worknetwork/features/profile/presentation/widget/profile_app_bar.dart';

import 'profile_screen_state.dart';

class ProfileScreen extends HookWidget {
  final String userId;
  final bool allowEdit;

  const ProfileScreen(
    @PathParam('userId') this.userId, {
    @PathParam('allowEdit') required this.allowEdit,
  });

  static const tabs = ["Streams", "About", "Club"];

  @override
  Widget build(BuildContext context) {
    final profileState = useProvider(getProfileNotifierProvider(userId));

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
                    index: index),
              ],
              body: TabBarView(
                children: [
                  ProfileStreamsTab(userId),
                  AboutTab(
                    profile: state.profile,
                    objectives: [],
                    interests: [],
                    meta: state.meta,
                    showLogout: allowEdit,
                  ),
                  ConnectionList(userId: userId),
                ],
              ),
            )),
      ),
      loading: () => Scaffold(
        body: DefaultTabController(
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
                      index: index),
                ],
                body: Center(
                    child: CircularProgressIndicator(
                  color: Theme.of(context).accentColor,
                )),
              ),
            )),
      ),
      error: (error, stackTrace) => Center(
        child: Text(error.toString()),
      ),
    );
  }
}
