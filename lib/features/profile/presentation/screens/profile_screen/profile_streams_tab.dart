import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/features/club/presentation/widgets/going_live_list.dart';
import 'package:worknetwork/features/club/presentation/widgets/past_live_grid_tile.dart';
import 'package:worknetwork/features/club/presentation/widgets/past_stream_list.dart';
import 'package:worknetwork/features/profile/presentation/screens/profile_screen/profile_streams_state.dart';

class ProfileStreamsTab extends HookConsumerWidget {
  final String userId;
  const ProfileStreamsTab(this.userId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liveProvider = ref.watch(profileLiveStreamsStateProvider(userId));
    final upcomingProvider =
        ref.watch(profileUpcomingStreamsStateProvider(userId));
    final pastProvider = ref.watch(profilePastStreamsStateProvider(userId));
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const SizedBox(height: AppInsets.xxl),
            liveProvider.when(
              loading: () => Container(),
              error: (e, s) => Container(),
              data: (conversations) {
                if (conversations.isEmpty) return Container();
                return SizedBox(
                  height: 350,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Live streams',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        const SizedBox(height: AppInsets.xl),
                        SizedBox(
                          height: 300,
                          child: PastLiveGridTile(conversations[0]),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            upcomingProvider.when(
              loading: () => Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              error: (e, s) => Container(),
              data: (conversations) {
                if (conversations.isEmpty) return Container();
                final total = conversations.length;
                const limit = 2;
                final height =
                    min(total, limit) * 144.0 + (total >= limit ? 120 : 40);
                return SizedBox(
                  height: height,
                  child: GoingLiveList(
                    title: 'Upcoming Streams',
                    showCategories: false,
                    gridItems: conversations.take(limit).toList(),
                  ),
                );
              },
            ),
            pastProvider.when(
              loading: () => Container(),
              error: (e, s) => Container(),
              data: (conversations) {
                if (conversations.isEmpty) return Container();
                final total = conversations.length;
                const limit = 2;
                final height =
                    min(total, limit) * 144.0 + (total >= limit ? 100 : 40);
                return SizedBox(
                  height: height,
                  child: PastStreamList(
                    title: 'Past streams',
                    showCategories: false,
                    gridItems: conversations.take(limit).toList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
