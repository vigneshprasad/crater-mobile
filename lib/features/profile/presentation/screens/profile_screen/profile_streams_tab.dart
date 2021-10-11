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
                          const UnderlinedText(
                            'LIVE',
                            bgText: 'STREAMS',
                          ),
                          const SizedBox(height: AppInsets.xl),
                          SizedBox(
                            height: 300,
                            child: UpcomingGridTile(conversations[0]),
                          ),
                        ],
                      ));
                }),
            const SizedBox(height: 40),
            upcomingProvider.when(
                loading: () => Container(),
                error: (e, s) => Container(),
                data: (conversations) {
                  if (conversations.isEmpty) return Container();
                  return SizedBox(
                    height: 280,
                    child: CarouselSlider(
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
                  );
                }),
          ],
        ),
      ),
    );
  }
}
