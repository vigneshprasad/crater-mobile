import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/club/presentation/widgets/home_app_bar.dart';
import 'package:worknetwork/features/connection/presentation/widget/connectable_list/connectable_list.dart';
import 'package:worknetwork/features/connection/presentation/widget/featured_list/featured_list.dart';
import 'package:worknetwork/features/connection/presentation/widget/featured_list/featured_list_state.dart';

import 'connection_tab_state.dart';

class ConnectionTab extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // final tagsState = useProvider(tagStateProvider);
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (context, _) => const [
          HomeAppBar(
            title: 'Creators & Educators',
          )
        ],
        body: RefreshIndicator(
          color: Theme.of(context).accentColor,
          onRefresh: () {
            final futures = [
              context.read(featuredConnectionStateProvider('').notifier).getProfileList(''),
            ];

            return Future.wait(futures);
          },
          child: FeaturedList(),
        ),
      ),
    );
  }
}
