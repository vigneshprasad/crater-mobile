import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:worknetwork/core/widgets/root_app.dart';
import 'package:worknetwork/features/auth/domain/entity/user_profile_entity.dart';
import 'package:worknetwork/features/connection/data/models/creator_response.dart';
import 'package:worknetwork/features/profile/presentation/widget/profile_header.dart';

import 'package:worknetwork/routes.gr.dart';

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
    const imageRatio = 375.0 / 400.0;
    final imageHeight = MediaQuery.of(context).size.width * imageRatio;
    final height = imageHeight + 100;
    // if (profile?.coverFile == null) {
    //   height = 200;
    // }
    const tabHeight = 52.0;
    final showConnect = creator?.isSubscriber ?? true;
    return SliverAppBar(
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      expandedHeight: height,
      flexibleSpace: FlexibleSpaceBar(
        background: ProfileHeader(
          height: imageHeight,
          profile: profile,
          creator: creator,
          showConnect: showConnect,
          allowEdit: allowEdit,
        ),
      ),
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
              ),
            ),
            onPressed: () => AutoRouter.of(context).push(
              ProfileBasicScreenRoute(editMode: true),
            ),
          ),
        // IconButton(
        //   icon: Container(
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(40),
        //       color: Theme.of(context).scaffoldBackgroundColor,
        //     ),
        //     padding: const EdgeInsets.all(4),
        //     child: const Icon(
        //       Icons.share_outlined,
        //     ),
        //   ),
        //   onPressed: () {
        //     final slug = creator?.slug;
        //     if (slug != null) {
        //       final shareText = profile?.name ?? 'Creator';
        //       final url = 'https://crater.club/creator/$slug/streams';
        //       shareApp(context, url, shareText);
        //     }
        //   },
        // ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size(double.infinity, tabHeight),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor,
              ),
            ),
            color: Theme.of(context).backgroundColor,
          ),
          height: tabHeight,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 28,
                alignment: Alignment.center,
                child: TabBar(
                  indicatorColor: Colors.transparent,
                  onTap: (i) {
                    index.value = i;
                  },
                  tabs: tabs
                      .asMap()
                      .entries
                      .map(
                        (e) => Tab(
                          child: Container(
                            decoration: index.value == e.key
                                ? BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.2),
                                        blurRadius: 17,
                                        spreadRadius: -3,
                                      ),
                                    ],
                                  )
                                : null,
                            child: Text(e.value),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              Container(
                width: 1,
                height: 28,
                color: Theme.of(context).dividerColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
