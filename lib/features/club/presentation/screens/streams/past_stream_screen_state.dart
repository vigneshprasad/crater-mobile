import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/conversations/domain/entity/webinar_entity/webinar_entity.dart';

import '../../../../../core/api_result/api_result.dart';
import '../../../../../core/error/failures/failures.dart';
import '../../../../conversations/data/repository/conversation_repository_impl.dart';
import 'stream_screen.dart';

final pastStreamsStateProvider = StateNotifierProvider<PastStreamStateNotifier,
        ApiResult<List<UpcomingGridItem>>>(
    (ref) => PastStreamStateNotifier(ref.read));

class PastStreamStateNotifier
    extends StateNotifier<ApiResult<List<UpcomingGridItem>>> {
  final Reader read;

  List<UpcomingGridItem> pastClubs = [];
  late bool loadingPage;
  final pageSize = 10;
  int page = 1;
  bool allLoaded = false;

  PastStreamStateNotifier(this.read)
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
        .getPastClubs(pageSize: pageSize);

    state = response.fold(
      (failure) {
        loadingPage = false;
        return ApiResult<List<UpcomingGridItem>>.error(failure);
      },
      (webinars) {
        pastClubs = webinars
            .map((e) => UpcomingGridItem(
                  conversation: e,
                  type: GridItemType.past,
                ))
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
        pastClubs + [UpcomingGridItem(type: GridItemType.loader)]);

    page = page + 1;

    final response = await read(conversationRepositoryProvider)
        .getPastClubs(page: page, pageSize: pageSize);

    state = response.fold(
      (failure) {
        loadingPage = false;
        return ApiResult<List<UpcomingGridItem>>.data(pastClubs);
      },
      (webinars) {
        pastClubs += webinars
            .map((e) => UpcomingGridItem(
                  conversation: e,
                  type: GridItemType.past,
                ))
            .toList();
        loadingPage = false;
        allLoaded = webinars.isEmpty || webinars.length < pageSize;
        return ApiResult<List<UpcomingGridItem>>.data(pastClubs);
      },
    );

    return response;
  }
}
