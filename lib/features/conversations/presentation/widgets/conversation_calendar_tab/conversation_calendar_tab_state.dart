import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/api_result/api_result.dart';

import '../../../data/models/calendar_week_data/calendar_week_data.dart';
import '../../../data/repository/conversation_repository_impl.dart';
import '../../../domain/entity/conversation_entity/conversation_entity.dart';

enum ConversationTabType {
  all,
  my,
}
final conversationCalendarStateProvider = StateNotifierProvider.autoDispose
    .family<ConversationCalendarStateNofier, ApiResult<List<CalendarWeekData>>,
        ConversationTabType>((ref, type) {
  return ConversationCalendarStateNofier(type, ref.read);
});

class ConversationCalendarStateNofier
    extends StateNotifier<ApiResult<List<CalendarWeekData>>> {
  final Reader read;
  final ConversationTabType type;

  ConversationCalendarStateNofier(this.type, this.read)
      : super(ApiResult.loading()) {
    getInitialData();
  }

  Future<void> getInitialData() async {
    final _start = DateTime.now();
    final _end = _start.add(const Duration(days: 365));

    final response = await read(conversationRepositoryProvider)
        .getMyConversations(_start, _end);

    if (response.isLeft()) {
      // throw response.swap().getOrElse(() => ServerFailure());
      state = ApiResult.data([
        CalendarWeekData(
          future: false,
          start: _start,
          end: _end,
          conversations: [],
        )
      ]);
      return;
    }

    final conversations =
        response.getOrElse(() => List<ConversationByDate>.empty());

    state = ApiResult.data([
      CalendarWeekData(
        future: false,
        start: _start,
        end: _end,
        conversations: conversations,
      ),
    ]);
  }
}
