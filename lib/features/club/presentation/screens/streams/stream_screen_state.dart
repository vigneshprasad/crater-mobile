import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/conversations/domain/entity/webinar_entity/webinar_entity.dart';

import '../../../../../core/api_result/api_result.dart';
import '../../../../../core/error/failures/failures.dart';
import '../../../../conversations/data/repository/conversation_repository_impl.dart';
import 'stream_screen.dart';

final streamStateProvider =
    StateNotifierProvider<StreamStateNotifier, ApiResult<StreamPage>>(
        (ref) => StreamStateNotifier(ref.read));

class StreamPage {
  final List<UpcomingGridItem> liveClubs;
  final List<UpcomingGridItem> upcomingClubs;
  final List<UpcomingGridItem> series;

  StreamPage({
    required this.liveClubs,
    required this.upcomingClubs,
    required this.series,
  });
}

class StreamStateNotifier extends StateNotifier<ApiResult<StreamPage>> {
  final Reader read;

  List<UpcomingGridItem> liveClubs = [];
  List<UpcomingGridItem> featuredClubs = [];
  List<UpcomingGridItem> upcomingClubs = [];
  List<UpcomingGridItem> series = [];
  
  late bool loadingPage;
  final pageSize = 10;
  int page = 1;
  bool allLoaded = false;

  StreamStateNotifier(this.read) : super(ApiResult<StreamPage>.loading()) {
    try {
      getLiveData();
    } catch (_) {}
    try {
      getSeriesData();
    } catch (_) {}
    try {
      getFeaturedData();
    } catch (_) {}
    try {
      getUpcomingData();
    } catch (_) {}
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
    final items = List<UpcomingGridItem>.from(upcomingClubs);

    final live = liveClubs + featuredClubs;

    state = ApiResult.data(StreamPage(
      liveClubs: live.toSet().toList(),
      upcomingClubs: items,
      series: series,
    ));
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


  Future<void> getFeaturedData() async {
    final response = await read(conversationRepositoryProvider).getFeaturedClubs();

    if (response.isLeft()) {
      throw response.swap().getOrElse(() => ServerFailure());
    }

    final webinars = response.getOrElse(() => List<Webinar>.empty());

    featuredClubs = webinars
        .map((e) => UpcomingGridItem(
              conversation: e,
              type: GridItemType.featured,
            ))
        .toList();
    updateData();
  }

  Future<Either<Failure, List<Webinar>>?> getSeriesData() async {
    
    page = 1;
    allLoaded = false;
    loadingPage = true;

    final response = await read(conversationRepositoryProvider)
        .getSeries(pageSize: pageSize);

    state = response.fold(
      (failure) {
        loadingPage = false;
        return state;
      },
      (webinars) {
        series = webinars
            .map((e) => UpcomingGridItem(
                  conversation: e,
                  type: GridItemType.series,
                ))
            .toList();
        loadingPage = false;
        allLoaded = webinars.isEmpty || webinars.length < pageSize;

        updateData();
        return state;
      },
    );

    return response;
  }

  Future<Either<Failure, List<Webinar>>?>
      getNextPageSeriesData() async {
    if (loadingPage == true || allLoaded == true) {
      return null;
    }
    loadingPage = true;

    series = series + [UpcomingGridItem(type: GridItemType.loader)];
    updateData();

    page = page + 1;

    final response = await read(conversationRepositoryProvider)
        .getSeries(page: page, pageSize: pageSize);

    state = response.fold(
      (failure) {
        loadingPage = false;
        return state;
      },
      (webinars) {
        series += webinars
            .map((e) => UpcomingGridItem(
                  conversation: e,
                  type: GridItemType.series,
                ))
            .toList();
        loadingPage = false;
        allLoaded = webinars.isEmpty || webinars.length < pageSize;

        updateData();
        return state;
      },
    );

    return response;
  }
}
