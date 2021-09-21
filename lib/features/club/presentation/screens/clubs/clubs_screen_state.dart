import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/conversations/domain/entity/webinar_entity/webinar_entity.dart';

import '../../../../../core/api_result/api_result.dart';
import '../../../../../core/error/failures/failures.dart';
import '../../../../conversations/data/repository/conversation_repository_impl.dart';
import 'clubs_screen.dart';

final clubsStateProvider = StateNotifierProvider<ClubsStateNotifier,
    ApiResult<List<UpcomingGridItem>>>((ref) => ClubsStateNotifier(ref.read));

class ClubsStateNotifier
    extends StateNotifier<ApiResult<List<UpcomingGridItem>>> {
  final Reader read;

  List<UpcomingGridItem> liveClubs = [];
  List<UpcomingGridItem> upcomingClubs = [];

  ClubsStateNotifier(this.read)
      : super(ApiResult<List<UpcomingGridItem>>.loading()) {
    getLiveData();
    getUpcomingData();
  }

  Future<void> getUpcomingData() async {
    final response =
        await read(conversationRepositoryProvider).getUpcomingClubs();

    if (response.isLeft()) {
      throw response.swap().getOrElse(() => ServerFailure());
    }

    final webinars = response.getOrElse(() => List<Webinar>.empty());

    upcomingClubs = webinars
        .map((e) => UpcomingGridItem(
              conversation: e,
              type: GridItemType.upcoming,
            ))
        .toList();

    updateData();
  }

  void updateData() {
    final items = upcomingClubs;
    if (items.isNotEmpty) {
      items.insert(
          1,
          UpcomingGridItem(
              title: 'UPCOMING\nSTREAMS',
              color: '#B02A2A',
              type: GridItemType.title,
              icon: const Icon(
                Icons.schedule,
                size: 80,
              )));

      // items.insert(
      //     upcomingClubs.length,
      //     UpcomingGridItem(
      //         title: 'PAST\nSTREAMS',
      //         color: '#80D1C3',
      //         type: GridItemType.title,
      //         icon: const Icon(
      //           Icons.movie,
      //           size: 80,
      //         )));
    }
    state = ApiResult.data(liveClubs + items);
  }

  Future<void> getLiveData() async {
    final response = await read(conversationRepositoryProvider).getLiveClubs();

    if (response.isLeft()) {
      throw response.swap().getOrElse(() => ServerFailure());
    }

    final webinars = response.getOrElse(() => List<Webinar>.empty());

    liveClubs = webinars
        .map((e) => UpcomingGridItem(
              conversation: e,
              type: GridItemType.live,
            ))
        .toList();
    updateData();
  }
}
