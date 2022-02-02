import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/club/presentation/widgets/home_app_bar.dart';
import 'package:worknetwork/features/connection/presentation/widget/connectable_list/connectable_list.dart';
import 'package:worknetwork/features/connection/presentation/widget/featured_list/featured_list.dart';

import 'connection_tab_state.dart';

class ConnectionTab extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final tagsState = useProvider(tagStateProvider);
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (context, _) => const [
          HomeAppBar(
            title: 'Creators',
          )
        ],
        body: RefreshIndicator(
          color: Theme.of(context).accentColor,
          onRefresh: () {
            final futures = [
              context.read(tagStateProvider.notifier).getTagList(),
            ];

            return Future.wait(futures);
          },
          child: tagsState.when(
            loading: () => Container(),
            error: (err, st) => Center(child: Text(err.toString())),
            data: (tags) {
              return ListView.builder(
                itemCount: tags.length,
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (index == 0)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text('Crater Featured',
                                  style: Theme.of(context).textTheme.headline6),
                            ),
                            const SizedBox(height: 20),
                            FeaturedList(),
                            const SizedBox(height: 40),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.symmetric(horizontal: 20),
                            //   child: Text('Member only',
                            //       style: Theme.of(context).textTheme.headline6),
                            // ),
                            // const SizedBox(height: 8),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.symmetric(horizontal: 20),
                            //   child: Text(
                            //     'Let the AI match you or request a meeting with your preferences',
                            //     style: Theme.of(context).textTheme.caption,
                            //   ),
                            // ),
                            // const SizedBox(height: 40),
                          ],
                        ),
                      ConnectableList(tag: tags[index]),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
