import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/api_result/api_result.dart';
import 'package:worknetwork/core/error/failures/failures.dart';
import 'package:worknetwork/features/club/domain/entity/upcoming_grid_item.dart';
import 'package:worknetwork/features/club/presentation/screens/streams/stream_screen.dart';
import 'package:worknetwork/features/conversations/data/repository/conversation_repository_impl.dart';
import 'package:worknetwork/features/conversations/domain/entity/series_entity/series_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/webinar_entity/webinar_entity.dart';

final pastStreamsStateProvider = StateNotifierProvider.autoDispose
    .family<PastStreamStateNotifier, ApiResult<List<UpcomingGridItem>>, int?>(
  (ref, id) => PastStreamStateNotifier(ref.read, id),
);

final webinarCategoryStateProvider = StateNotifierProvider<
    WebinarCategoryStateNotifier, ApiResult<List<CategoriesDetailList>>>(
  (ref) => WebinarCategoryStateNotifier(ref.read),
);

class PastStreamStateNotifier
    extends StateNotifier<ApiResult<List<UpcomingGridItem>>> {
  final Reader read;
  final int? categoryId;

  List<UpcomingGridItem> pastClubs = [];
  late bool loadingPage;
  final pageSize = 10;
  int page = 1;
  bool allLoaded = false;

  PastStreamStateNotifier(this.read, this.categoryId)
      : super(ApiResult<List<UpcomingGridItem>>.loading()) {
    try {
      getPastData();
    } catch (_) {}
  }

  Future<Either<Failure, List<Webinar>>?> getPastData() async {
    state = ApiResult<List<UpcomingGridItem>>.loading();
    page = 1;
    allLoaded = false;
    loadingPage = true;

    final response = await read(conversationRepositoryProvider)
        .getPastClubs(pageSize: pageSize, categoryId: categoryId);

    state = response.fold(
      (failure) {
        loadingPage = false;
        return ApiResult<List<UpcomingGridItem>>.error(failure);
      },
      (webinars) {
        pastClubs = webinars
            .map(
              (e) => UpcomingGridItem(
                conversation: e,
                type: GridItemType.past,
              ),
            )
            .toList();
        loadingPage = false;
        allLoaded = webinars.isEmpty || webinars.length < pageSize;

        return ApiResult<List<UpcomingGridItem>>.data(pastClubs);
      },
    );

    return response;
  }

  Future<Either<Failure, List<Webinar>>?>
      getNextPageConnectableProfileList() async {
    if (loadingPage == true || allLoaded == true) {
      return null;
    }
    loadingPage = true;

    state = ApiResult<List<UpcomingGridItem>>.data(
      pastClubs + [const UpcomingGridItem(type: GridItemType.loader)],
    );

    page = page + 1;

    final response = await read(conversationRepositoryProvider)
        .getPastClubs(page: page, pageSize: pageSize, categoryId: categoryId);

    state = response.fold(
      (failure) {
        loadingPage = false;
        return ApiResult<List<UpcomingGridItem>>.data(pastClubs);
      },
      (webinars) {
        pastClubs += webinars
            .map(
              (e) => UpcomingGridItem(
                conversation: e,
                type: GridItemType.past,
              ),
            )
            .toList();
        loadingPage = false;
        allLoaded = webinars.isEmpty || webinars.length < pageSize;
        return ApiResult<List<UpcomingGridItem>>.data(pastClubs);
      },
    );

    return response;
  }
}

class WebinarCategoryStateNotifier
    extends StateNotifier<ApiResult<List<CategoriesDetailList>>> {
  final Reader read;

  WebinarCategoryStateNotifier(this.read)
      : super(ApiResult<List<CategoriesDetailList>>.loading()) {
    try {
      getWebinarCategories();
    } catch (_) {}
  }

  Future<Either<Failure, List<CategoriesDetailList>>?>
      getWebinarCategories() async {
    state = ApiResult.loading();

    final response =
        await read(conversationRepositoryProvider).getWebinarCategories();

    state = response.fold(
      (failure) {
        return ApiResult.error(failure);
      },
      (catetories) {
        return ApiResult.data(catetories);
      },
    );

    return response;
  }
}
