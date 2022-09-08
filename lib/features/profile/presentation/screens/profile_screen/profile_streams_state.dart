import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/api_result/api_result.dart';
import 'package:worknetwork/core/error/failures/failures.dart';
import 'package:worknetwork/features/club/domain/entity/upcoming_grid_item.dart';
import 'package:worknetwork/features/connection/data/models/creator_response.dart';
import 'package:worknetwork/features/conversations/data/repository/conversation_repository_impl.dart';
import 'package:worknetwork/features/conversations/domain/entity/webinar_entity/webinar_entity.dart';

final profileLiveStreamsStateProvider = StateNotifierProvider.family<
    ProfileLiveStreamsStateNotifier,
    ApiResult<List<UpcomingGridItem>>,
    String>((ref, userId) => ProfileLiveStreamsStateNotifier(ref.read, userId));

class ProfileLiveStreamsStateNotifier
    extends StateNotifier<ApiResult<List<UpcomingGridItem>>> {
  final Reader read;
  final String userId;

  ProfileLiveStreamsStateNotifier(this.read, this.userId)
      : super(ApiResult<List<UpcomingGridItem>>.loading()) {
    getData();
  }

  Future<void> getData() async {
    final response =
        await read(conversationRepositoryProvider).getLiveClubs(userId: userId);

    if (response.isLeft()) {
      throw response
          .swap()
          .getOrElse(() => ServerFailure('Something went wrong'));
    }

    final webinars = response.getOrElse(() => List<Webinar>.empty());

    final upcomingClubs = webinars
        .map(
          (e) => UpcomingGridItem(
            conversation: e,
            type: GridItemType.live,
          ),
        )
        .toList();

    state = ApiResult.data(upcomingClubs);
  }
}

final profileUpcomingStreamsStateProvider = StateNotifierProvider.family<
    ProfileUpcomingStateNotifier,
    ApiResult<List<UpcomingGridItem>>,
    String>((ref, userId) => ProfileUpcomingStateNotifier(ref.read, userId));

class ProfileUpcomingStateNotifier
    extends StateNotifier<ApiResult<List<UpcomingGridItem>>> {
  final Reader read;
  final String userId;

  List<UpcomingGridItem> liveClubs = [];

  ProfileUpcomingStateNotifier(this.read, this.userId)
      : super(ApiResult<List<UpcomingGridItem>>.loading()) {
    getData();
  }

  Future<void> getData() async {
    final response = await read(conversationRepositoryProvider)
        .getUpcomingClubs(userId: userId);

    response.fold((l) {
      state = ApiResult.error(l);
    }, (pageData) {
      final upcomingClubs = pageData.results
          .map(
            (e) => UpcomingGridItem(
              conversation: e,
              type: GridItemType.upcoming,
            ),
          )
          .toList();

      state = ApiResult.data(upcomingClubs);
    });
  }
}

final profilePastStreamsStateProvider = StateNotifierProvider.family<
    ProfilePastStateNotifier,
    ApiResult<List<UpcomingGridItem>>,
    String>((ref, userId) => ProfilePastStateNotifier(ref.read, userId));

class ProfilePastStateNotifier
    extends StateNotifier<ApiResult<List<UpcomingGridItem>>> {
  final Reader read;
  final String userId;

  List<UpcomingGridItem> liveClubs = [];

  ProfilePastStateNotifier(this.read, this.userId)
      : super(ApiResult<List<UpcomingGridItem>>.loading()) {
    getData();
  }

  Future<void> getData() async {
    final response =
        await read(conversationRepositoryProvider).getPastClubs(userId: userId);

    if (response.isLeft()) {
      throw response
          .swap()
          .getOrElse(() => ServerFailure('Something went wrong'));
    }

    final webinars = response.getOrElse(() => List<Webinar>.empty());

    final upcomingClubs = webinars
        .map(
          (e) => UpcomingGridItem(
            conversation: e,
            type: GridItemType.past,
          ),
        )
        .toList();

    state = ApiResult.data(upcomingClubs);
  }
}
