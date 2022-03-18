import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/error/failures/failures.dart';
import '../../../data/models/calendar_week_data/calendar_week_data.dart';
import '../../../data/repository/conversation_repository_impl.dart';
import '../../../domain/entity/conversation_entity/conversation_entity.dart';

enum ConversationTabType {
  all,
  my,
}

final conversationCalendarStateProvider = StateNotifierProvider.family<
    ConversationCalendarStateNofier,
    List<CalendarWeekData>,
    ConversationTabType>((ref, type) {
  return ConversationCalendarStateNofier(type, ref.read);
});

final initialStateProvider =
    FutureProvider.autoDispose.family<void, ConversationTabType>((ref, type) {
  return ref
      .watch(conversationCalendarStateProvider(type).notifier)
      .getInitialData();
});

class ConversationCalendarStateNofier
    extends StateNotifier<List<CalendarWeekData>> {
  final Reader read;
  final ConversationTabType type;

  ConversationCalendarStateNofier(this.type, this.read) : super([]);

  Future<void> getInitialData() async {
    final _start = DateTime.now();
    final _end = _start.add(const Duration(days: 365));

    final response = await read(conversationRepositoryProvider)
        .getMyConversations(_start, _end);

    if (response.isLeft()) {
      // throw response.swap().getOrElse(() => ServerFailure());
      state = [
        CalendarWeekData(
          future: false,
          start: _start,
          end: _end,
          conversations: [],
        )
      ];
      return;
    }

    final conversations =
        response.getOrElse(() => List<ConversationByDate>.empty());

    state = [
      CalendarWeekData(
        future: false,
        start: _start,
        end: _end,
        conversations: conversations,
      ),
    ];
  }
}
