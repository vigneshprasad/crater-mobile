import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kiwi/kiwi.dart';

import '../../../../../core/error/failures/failures.dart';
import '../../../../meeting/domain/entity/meetings_by_date_entity.dart';
import '../../../../meeting/domain/entity/requests_by_date_entity.dart';
import '../../../../meeting/domain/repository/meeting_repository.dart';
import '../../../data/models/calendar_week_data/calendar_week_data.dart';
import '../../../data/repository/conversation_repository_impl.dart';
import '../../../domain/entity/conversation_entity/conversation_entity.dart';
import '../../../domain/entity/optin_entity/optin_entity.dart';

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
    final _end = _start.add(const Duration(days: 7));

    if (type == ConversationTabType.all) {
      final futures = [
        read(conversationRepositoryProvider).getAllConversations(_start, _end),
        KiwiContainer()
            .resolve<MeetingRepository>()
            .getMeetingsByDate(past: false),
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

      state = [
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
      ];
    } else {
      final futures = [
        read(conversationRepositoryProvider).getMyConversations(_start, _end),
        read(conversationRepositoryProvider).getAllConversationOptinsByDate(),
        KiwiContainer()
            .resolve<MeetingRepository>()
            .getMeetingsByDate(past: false),
        KiwiContainer().resolve<MeetingRepository>().getMyMeetingRequest(),
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
      final optins = response[1].getOrElse(() => List<OptinsByDate>.empty())
          as List<OptinsByDate>;
      final meetings = response[2].getOrElse(() => List<MeetingsByDate>.empty())
          as List<MeetingsByDate>;
      final requests = response[3].getOrElse(() => List<RequestsByDate>.empty())
          as List<RequestsByDate>;

      state = [
        CalendarWeekData(
          future: false,
          start: _start,
          end: _end,
          conversations: conversations,
        ),
        CalendarWeekData(
          future: true,
          start: _start,
          end: _end,
          meetings: meetings,
        ),
        CalendarWeekData(
          future: true,
          start: _start,
          end: _end,
          optins: optins,
        ),
        CalendarWeekData(
          future: true,
          start: _start,
          end: _end,
          requests: requests,
        )
      ];
    }
  }

  Future<Either<Failure, List<ConversationByDate>>>
      getPreviousWeekData() async {
    final _start = state[0].start?.subtract(const Duration(days: 7));
    final _end = state[0].start?.subtract(const Duration(days: 1));
    Either<Failure, List<ConversationByDate>> response;

    if (type == ConversationTabType.all) {
      response = await read(conversationRepositoryProvider)
          .getAllConversations(_start!, _end!);
    } else {
      response = await read(conversationRepositoryProvider)
          .getMyConversations(_start!, _end!);
    }

    response.fold(
      (failure) {
        throw failure;
      },
      (data) {
        final weekData = CalendarWeekData(
          future: false,
          start: _start,
          end: _end,
          conversations: data,
        );
        state = state..insert(0, weekData);
      },
    );

    return response;
  }
}
