import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/club/presentation/widgets/home_app_bar.dart';
import 'package:worknetwork/features/connection/presentation/widget/featured_list/featured_list.dart';
import 'package:worknetwork/features/connection/presentation/widget/featured_list/featured_list_state.dart';

class ConnectionTab extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final tagsState = useProvider(tagStateProvider);
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (context, _) => const [
          HomeAppBar(
            title: 'Creators & Educators',
          )
        ],
        body: RefreshIndicator(
          color: Theme.of(context).colorScheme.secondary,
          onRefresh: () {
            final futures = [
              ref
                  .read(featuredConnectionStateProvider('').notifier)
                  .getProfileList(''),
            ];

            return Future.wait(futures);
          },
          child: FeaturedList(),
        ),
      ),
    );
  }
}
