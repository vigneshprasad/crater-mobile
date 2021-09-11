import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/core/api_result/api_result.dart';
import 'package:worknetwork/features/conversations/data/models/calendar_week_data/calendar_week_data.dart';
import 'package:worknetwork/features/conversations/data/repository/conversation_repository_impl.dart';
import 'package:worknetwork/features/conversations/domain/entity/conversation_entity/conversation_entity.dart';

import '../../../../../core/error/failures/failures.dart';
import '../../../../meeting/domain/entity/meetings_by_date_entity.dart';
import '../../../../meeting/domain/repository/meeting_repository.dart';

final clubsStateProvider = StateNotifierProvider<ClubsStateNotifier,
    ApiResult<List<CalendarWeekData>>>((ref) => ClubsStateNotifier(ref.read));

class ClubsStateNotifier
    extends StateNotifier<ApiResult<List<CalendarWeekData>>> {
  final Reader read;

  ClubsStateNotifier(this.read)
      : super(ApiResult<List<CalendarWeekData>>.loading()) {
    getInitialData();
  }

  Future<void> getInitialData() async {
    // final _start = DateTime.now();
    // final _end = _start.add(const Duration(days: 7));
    final _start = DateTime.now().subtract(const Duration(days: 30));
    final _end = _start;

    final futures = [
      read(conversationRepositoryProvider).getAllConversations(_start, _end),
      KiwiContainer()
          .resolve<MeetingRepository>()
          .getMeetingsByDate(past: true),
    ];

    final response = await Future.wait(futures);

    for (final result in response) {
      if (result.isLeft()) {
        throw result.swap().getOrElse(() => ServerFailure());
      }
    }

    final conversations =
        response[0].getOrElse(() => List<ConversationByDate>.empty())
            as List<ConversationByDate>;
    final meetings = response[1].getOrElse(() => List<MeetingsByDate>.empty())
        as List<MeetingsByDate>;

    state = ApiResult.data([
      CalendarWeekData(
        future: false,
        start: _start,
        end: _end,
        conversations: conversations,
      ),
      CalendarWeekData(
        future: false,
        start: _start,
        end: _end,
        meetings: meetings,
      )
    ]);
  }
}
