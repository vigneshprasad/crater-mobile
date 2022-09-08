import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/api_result/api_result.dart';
import 'package:worknetwork/core/error/failures/failures.dart';
import 'package:worknetwork/features/club/domain/entity/upcoming_grid_item.dart';
import 'package:worknetwork/features/conversations/data/repository/conversation_repository_impl.dart';
import 'package:worknetwork/features/conversations/domain/entity/conversation_request_entity/conversation_request_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/webinar_entity/webinar_entity.dart';

final upcomingStreamListStateProvider = StateNotifierProvider<
    UpcomingStreamListStateNotifier, ApiResult<List<UpcomingGridItem>>>(
  (ref) => UpcomingStreamListStateNotifier(ref.read),
);

class UpcomingStreamListStateNotifier
    extends StateNotifier<ApiResult<List<UpcomingGridItem>>> {
  final Reader read;

  List<UpcomingGridItem> allClubs = [];

  late bool loadingPage;
  final pageSize = 10;
  int page = 1;
  bool allLoaded = false;

  List<int> rsvped = [];

  UpcomingStreamListStateNotifier(this.read) : super(ApiResult.loading()) {
    try {
      getInitialData();
    } catch (_) {}
  }

  Future<void> getInitialData() async {
    final response = await read(conversationRepositoryProvider).getAllClubs();

    if (response.isLeft()) {
      // throw response.swap().getOrElse(() => ServerFailure());
      return;
    }

    final webinars = response.getOrElse(() => List<Webinar>.empty());

    allClubs = webinars
        .map((e) {
          final isRSVPed = (rsvped.contains(e.id)) ? (true) : isWebinarRSVP(e);
          return UpcomingGridItem(
            conversation: e,
            type: GridItemType.upcoming,
            rsvped: isRSVPed,
          );
        })
        .skipWhile((value) => value.rsvped == true)
        .toList();

    state = ApiResult.data(allClubs);
  }

  Future<void> getNextPageData() async {}

  Future<Either<Failure, ConversationRequest>> postRequestToJoinGroup(
    int groupId,
  ) async {
    final request = ConversationRequest(
      group: groupId,
      participantType: ParticpantType.attendee,
      status: RequestStatus.accepted,
    );
    final response = await read(conversationRepositoryProvider)
        .postRequestToJoinGroup(request);

    rsvped.add(groupId);

    final rows = allClubs.map((e) {
      final isRSVPed =
          (rsvped.contains(e.conversation!.id)) ? (true) : (e.rsvped ?? false);
      return UpcomingGridItem(
        conversation: e.conversation,
        type: GridItemType.upcoming,
        rsvped: isRSVPed,
      );
    });
    state = ApiResult.data(rows.toList());

    return response;
  }
}
