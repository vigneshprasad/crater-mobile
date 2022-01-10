import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:worknetwork/features/auth/domain/entity/user_profile_entity.dart';
import 'package:worknetwork/features/connection/data/models/creator_response.dart';
import 'package:worknetwork/features/profile/presentation/widget/profile_header.dart';

import '../../../../../../routes.gr.dart';

class ProfileAppBar extends HookWidget {
  const ProfileAppBar({
    required this.allowEdit,
    required this.tabs,
    required this.context,
    required this.profile,
    required this.index,
    this.creator,
  });

  final bool allowEdit;
  final List<String> tabs;
  final BuildContext context;
  final UserProfile? profile;
  final Creator? creator;
  final ValueNotifier<int> index;

  @override
  Widget build(BuildContext context) {
    double height = 320.0;
    // if (profile?.coverFile == null) {
    //   height = 200;
    // }
    const tabHeight = 50.0;
    return SliverAppBar(
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      expandedHeight: height,
      flexibleSpace: FlexibleSpaceBar(
          background: ProfileHeader(
        height: height - 120,
        profile: profile,
        creator: creator,
        showConnect: profile?.canConnect ?? false,
      )),
      pinned: true,
      floating: true,
      shadowColor: Colors.grey,
      actions: [
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
