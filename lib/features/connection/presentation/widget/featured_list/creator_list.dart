import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/auth/presentation/screens/splash/splash_screen_state.dart';

import 'package:worknetwork/features/connection/presentation/widget/featured_list/creator_follow_card.dart';
import 'package:worknetwork/features/connection/presentation/widget/featured_list/creator_list_state.dart';

class CreatorList extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(authStateProvider.notifier).getUser();
    final _controller = useScrollController();
    _controller.addListener(() {
      // reached End of scroll
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        ref.read(creatorStateProvider('').notifier).getNextPageProfileList('');
      }
    });
    final connectionState = ref.watch(creatorStateProvider(''));
    return connectionState.when(
      loading: () => Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      error: (err, st) => Center(
        child: err == null ? Container() : Text(err.toString()),
      ),
      data: (items) {
        return items.isEmpty
            ? Container()
            : Wrap(
                direction: Axis.vertical,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Text(
                      'Creators to follow',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  SizedBox(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 20,
                      ),
                      controller: _controller,
                      itemCount: items.length,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.fromLTRB(20, 8, 8, 40),
                      itemBuilder: (context, index) => CreatorFollowCard(
                        item: items[index],
                        authUserPk: user?.pk,
                      ),
                    ),
                  ),
                ],
              );
      },
    );
  }
}
