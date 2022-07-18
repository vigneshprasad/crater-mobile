import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/api_result/api_result.dart';
import 'package:worknetwork/core/error/failures/failures.dart';
import 'package:worknetwork/features/club/presentation/screens/streams/stream_screen.dart';
import 'package:worknetwork/features/connection/data/models/creator_response.dart';
import 'package:worknetwork/features/conversations/data/repository/conversation_repository_impl.dart';
import 'package:worknetwork/features/conversations/domain/entity/webinar_entity/webinar_entity.dart';

final streamStateProvider =
    StateNotifierProvider<StreamStateNotifier, ApiResult<StreamPage>>(
  (ref) => StreamStateNotifier(ref.read),
);

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

  List<UpcomingGridItem> featuredClubs = [];
  List<UpcomingGridItem> upcomingClubs = [];
  List<UpcomingGridItem> series = [];

  late bool loadingPage;
  final pageSize = 10;
  int page = 1;
  bool allLoaded = false;

  final upcomingPageSize = 10;
  int upcomingPage = 1;
  late bool loadingUpcomingPage;
  bool allUpcomingLoaded = false;

  final featuredPageSize = 10;
  int featuredPage = 1;
  late bool loadingFeaturedPage;
  bool allFeaturedLoaded = false;

  StreamStateNotifier(this.read) : super(ApiResult<StreamPage>.loading()) {
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
    upcomingPage = 1;
    allUpcomingLoaded = false;
    loadingUpcomingPage = true;

    final response =
        await read(conversationRepositoryProvider).getUpcomingClubs(
      page: upcomingPage,
      pageSize: upcomingPageSize,
    );

    if (response.isLeft()) {
      // throw response.swap().getOrElse(() => ServerFailure());

      loadingUpcomingPage = false;
      return;
    }

    final pageData = response.getOrElse(() => const FollowCreatorResponse());

    loadingUpcomingPage = false;
    allUpcomingLoaded = pageData.next == null;

    upcomingClubs = pageData.results
        .map(
          (e) => UpcomingGridItem(
            conversation: e,
            type: GridItemType.upcoming,
          ),
        )
        .toList();

    updateData();
  }

  Future<void> getUpcomingNextData() async {
    if (loadingUpcomingPage == true || allUpcomingLoaded == true) {
      return;
    }
    loadingUpcomingPage = true;

    // upcomingClubs = upcomingClubs + [UpcomingGridItem(type: GridItemType.loader)];
    // updateData();

    upcomingPage = upcomingPage + 1;

    final response =
        await read(conversationRepositoryProvider).getUpcomingClubs(
      page: upcomingPage,
      pageSize: upcomingPageSize,
    );

    if (response.isLeft()) {
      // throw response.swap().getOrElse(() => ServerFailure());

      loadingUpcomingPage = false;
      return;
    }

    final pageData = response.getOrElse(() => const FollowCreatorResponse());

    loadingUpcomingPage = false;
    allUpcomingLoaded = pageData.next == null;

    upcomingClubs = upcomingClubs +
        pageData.results
            .map(
              (e) => UpcomingGridItem(
                conversation: e,
                type: GridItemType.upcoming,
              ),
            )
            .toList();

    updateData();
  }

  void updateData() {
    final items = List<UpcomingGridItem>.from(upcomingClubs);

    state = ApiResult.data(
      StreamPage(
        liveClubs: featuredClubs.toSet().toList(),
        upcomingClubs: items,
        series: series,
      ),
    );
  }

  Future<void> getFeaturedData() async {
    featuredPage = 1;
    loadingFeaturedPage = true;
    allFeaturedLoaded = false;

    final response = await read(conversationRepositoryProvider)
        .getFeaturedClubs(page: featuredPage, pageSize: featuredPageSize);

    if (response.isLeft()) {
      // throw response.swap().getOrElse(() => ServerFailure());
      return;
    }

    final pageData = response.getOrElse(() => const FollowCreatorResponse());

    allFeaturedLoaded = pageData.next == null;

    featuredClubs = pageData.results.map((e) {
      var type = e.isLive ?? false ? GridItemType.live : GridItemType.featured;
      if (e.isPast ?? false) {
        type = GridItemType.past;
      }
      return UpcomingGridItem(
        conversation: e,
        type: type,
      );
    }).toList();
    updateData();
  }

  Future<void> getFeaturedNextData() async {
    if (loadingFeaturedPage == true || allFeaturedLoaded == true) {
      return;
    }
    loadingFeaturedPage = true;

    featuredPage = featuredPage + 1;

    final response = await read(conversationRepositoryProvider)
        .getFeaturedClubs(page: featuredPage, pageSize: featuredPageSize);

    if (response.isLeft()) {
      loadingFeaturedPage = false;
      // throw response.swap().getOrElse(() => ServerFailure());
      return;
    }

    final pageData = response.getOrElse(() => const FollowCreatorResponse());

    allFeaturedLoaded = pageData.next == null;

    featuredClubs = pageData.results.map((e) {
      var type = e.isLive ?? false ? GridItemType.live : GridItemType.featured;
      if (e.isPast ?? false) {
        type = GridItemType.past;
      }
      return UpcomingGridItem(
        conversation: e,
        type: type,
      );
    }).toList();
    updateData();

    loadingFeaturedPage = false;
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
            .map(
              (e) => UpcomingGridItem(
                conversation: e,
                type: GridItemType.series,
              ),
            )
            .toList();
        loadingPage = false;
        allLoaded = webinars.isEmpty || webinars.length < pageSize;

        updateData();
        return state;
      },
    );

    return response;
  }

  Future<Either<Failure, List<Webinar>>?> getNextPageSeriesData() async {
    if (loadingPage == true || allLoaded == true) {
      return null;
    }
    loadingPage = true;

    series = series + [const UpcomingGridItem(type: GridItemType.loader)];
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
            .map(
              (e) => UpcomingGridItem(
                conversation: e,
                type: GridItemType.series,
              ),
            )
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
