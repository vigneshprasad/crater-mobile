import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/api_result/api_result.dart';
import 'package:worknetwork/core/error/failures/failures.dart';
import 'package:worknetwork/features/club/domain/entity/upcoming_grid_item.dart';
import 'package:worknetwork/features/connection/data/models/creator_response.dart';
import 'package:worknetwork/features/conversations/data/repository/conversation_repository_impl.dart';
import 'package:worknetwork/features/conversations/domain/entity/webinar_entity/webinar_entity.dart';

final upcomingStreamsStateProvider = StateNotifierProvider.autoDispose.family<
    UpcomingStreamStateNotifier, ApiResult<List<UpcomingGridItem>>, int?>(
  (ref, id) => UpcomingStreamStateNotifier(ref.read, id),
);

class UpcomingStreamStateNotifier
    extends StateNotifier<ApiResult<List<UpcomingGridItem>>> {
  final Reader read;
  final int? categoryId;

  List<UpcomingGridItem> upcomingClubs = [];
  late bool loadingPage;
  final pageSize = 10;
  int page = 1;
  bool allLoaded = false;

  UpcomingStreamStateNotifier(this.read, this.categoryId)
      : super(ApiResult<List<UpcomingGridItem>>.loading()) {
    try {
      getUpcomingData();
    } catch (_) {}
  }

  Future<Either<Failure, FollowCreatorResponse>?> getUpcomingData() async {
    state = ApiResult<List<UpcomingGridItem>>.loading();
    page = 1;
    allLoaded = false;
    loadingPage = true;

    final response = await read(conversationRepositoryProvider)
        .getUpcomingClubs(pageSize: pageSize, categoryId: categoryId);

    state = response.fold(
      (failure) {
        loadingPage = false;
        return ApiResult<List<UpcomingGridItem>>.error(failure);
      },
      (webinars) {
        upcomingClubs = webinars.results
            .map(
              (e) => UpcomingGridItem(
                conversation: e,
                type: GridItemType.past,
              ),
            )
            .toList();
        loadingPage = false;
        allLoaded =
            webinars.results.isEmpty || webinars.results.length < pageSize;

        return ApiResult<List<UpcomingGridItem>>.data(upcomingClubs);
      },
    );

    return response;
  }

  Future<Either<Failure, List<Webinar>>?> getNextPageList() async {
    if (loadingPage == true || allLoaded == true) {
      return null;
    }
    loadingPage = true;

    state = ApiResult<List<UpcomingGridItem>>.data(
      upcomingClubs + [const UpcomingGridItem(type: GridItemType.loader)],
    );

    page = page + 1;

    final response = await read(conversationRepositoryProvider)
        .getPastClubs(page: page, pageSize: pageSize, categoryId: categoryId);

    state = response.fold(
      (failure) {
        loadingPage = false;
        return ApiResult<List<UpcomingGridItem>>.data(upcomingClubs);
      },
      (webinars) {
        upcomingClubs += webinars
            .map(
              (e) => UpcomingGridItem(
                conversation: e,
                type: GridItemType.past,
              ),
            )
            .toList();
        loadingPage = false;
        allLoaded = webinars.isEmpty || webinars.length < pageSize;
        return ApiResult<List<UpcomingGridItem>>.data(upcomingClubs);
      },
    );

    return response;
  }
}
