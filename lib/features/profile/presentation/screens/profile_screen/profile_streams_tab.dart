import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/features/club/presentation/screens/streams/stream_screen.dart';
import 'package:worknetwork/features/profile/presentation/screens/profile_screen/profile_streams_state.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:worknetwork/features/profile/presentation/widget/underline_text.dart';

import '../../../../../routes.gr.dart';

class ProfileStreamsTab extends HookWidget {
  final String userId;
  const ProfileStreamsTab(this.userId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final liveProvider = useProvider(profileLiveStreamsStateProvider(userId));
    final upcomingProvider =
        useProvider(profileUpcomingStreamsStateProvider(userId));
    final pastProvider = useProvider(profilePastStreamsStateProvider(userId));
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              'Live streams',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                          const SizedBox(height: AppInsets.xl),
                          SizedBox(
                            height: 300,
                            child: LiveGridTile(conversations[0]),
                          ),
                        ],
                      ));
                }),
            const SizedBox(height: 40),
            upcomingProvider.when(
                loading: () => Center(
                        child: CircularProgressIndicator(
                      color: Theme.of(context).accentColor,
                    )),
                error: (e, s) => Container(),
                data: (conversations) {
                  if (conversations.isEmpty) return Container();
                  return SizedBox(
                    height: 320,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            'Upcoming streams',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                        const SizedBox(height: AppInsets.xxl),
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 280.0,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: false,
                          ),
                          items: conversations.map((c) {
                            return Builder(
                              builder: (BuildContext context) {
                                return UpcomingGridTile(c);
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  );
                }),
            const SizedBox(height: 40),
            pastProvider.when(
                loading: () => Container(),
                error: (e, s) => Container(),
                data: (conversations) {
                  if (conversations.isEmpty) return Container();
                  return SizedBox(
                    height: 320,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            'Past streams',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                        const SizedBox(height: AppInsets.xxl),
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 280.0,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: false,
                          ),
                          items: conversations.map((c) {
                            return Builder(
                              builder: (BuildContext context) {
                                return UpcomingGridTile(c);
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
