import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide ReadContext;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/core/features/share_manager/share_manager.dart';
import 'package:worknetwork/core/integrations/intercom/intercom_provider.dart';
import 'package:worknetwork/features/auth/domain/entity/user_profile_entity.dart';
import 'package:worknetwork/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:worknetwork/features/profile/domain/entity/profile_entity/profile_entity.dart';
import 'package:worknetwork/features/profile/presentation/widget/help_button.dart';
import 'package:worknetwork/features/profile/presentation/widget/profile_header.dart';
import 'package:worknetwork/features/profile/presentation/widget/share_button.dart';

import '../../../../../../routes.gr.dart';

class ProfileAppBar extends HookWidget {
  const ProfileAppBar({
    required this.allowEdit,
    required this.tabs,
    required this.context,
    required this.profile,
    required this.index,
  });

  final bool allowEdit;
  final List<String> tabs;
  final BuildContext context;
  final UserProfile? profile;
  final ValueNotifier<int> index;

  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<AuthBloc>(context).state.user;
    final email = user?.email;
    const height = 320.0;
    const tabHeight = 50.0;
    return SliverAppBar(
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      expandedHeight: height,
      flexibleSpace: FlexibleSpaceBar(
          background: ProfileHeader(
        height: height - 120,
        profile: profile,
        showConnect: profile?.canConnect ?? false,
      )),
      pinned: true,
      floating: true,
      shadowColor: Colors.grey,
      // leading: IconButton(
      //   icon: const Icon(Icons.live_help),
      //   iconSize: 28,
      //   onPressed: () => context.read(intercomProvider).show(email!),
      // ),
      actions: [
        // if (allowEdit) ShareButton(),
        if (allowEdit)
          IconButton(
            icon: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                padding: const EdgeInsets.all(4),
                child: Icon(
                  Icons.edit,
                  color: Theme.of(context).buttonColor,
                )),
            onPressed: () => AutoRouter.of(context).push(
              ProfileBasicScreenRoute(editMode: true),
            ),
          ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size(double.infinity, tabHeight),
        child: Container(
          color: Theme.of(context).dialogBackgroundColor,
          height: tabHeight,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                height: tabHeight - 18,
                alignment: Alignment.bottomLeft,
                child: TabBar(
                  onTap: (i) {
                    index.value = i;
                  },
                  tabs: tabs
                      .map((e) => Tab(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(e),
                            ],
                          )))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
