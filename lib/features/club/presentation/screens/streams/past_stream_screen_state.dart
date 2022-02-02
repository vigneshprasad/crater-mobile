
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/conversations/domain/entity/webinar_entity/webinar_entity.dart';

import '../../../../../core/api_result/api_result.dart';
import '../../../../../core/error/failures/failures.dart';
import '../../../../conversations/data/repository/conversation_repository_impl.dart';
import 'stream_screen.dart';

final pastStreamsStateProvider =
    StateNotifierProvider<PastStreamStateNotifier, ApiResult<StreamPage>>(
        (ref) => PastStreamStateNotifier(ref.read));

class StreamPage {
  final List<UpcomingGridItem> liveClubs;
  final List<UpcomingGridItem> upcomingClubs;
  final List<UpcomingGridItem> pastClubs;

  StreamPage({
    required this.liveClubs,
    required this.upcomingClubs,
    required this.pastClubs,
  });
}

class PastStreamStateNotifier extends StateNotifier<ApiResult<StreamPage>> {
  final Reader read;

  List<UpcomingGridItem> pastClubs = [];

  PastStreamStateNotifier(this.read) : super(ApiResult<StreamPage>.loading()) {
    try {
      getPastData();
    } catch (_) {}
  }


  Future<void> getPastData() async {
    final response = await read(conversationRepositoryProvider).getPastClubs();

    if (response.isLeft()) {
      throw response.swap().getOrElse(() => ServerFailure());
    }

    final webinars = response.getOrElse(() => List<Webinar>.empty());

    pastClubs = webinars
        .map((e) => UpcomingGridItem(
              conversation: e,
              type: GridItemType.past,
            ))
        .toList();

    updateData();
  }

  void updateData() {
    state = ApiResult.data(StreamPage(
      liveClubs: [],
      upcomingClubs: [],
      pastClubs: pastClubs,
    ));
  }

}
