import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/api_result/api_result.dart';
import '../../../../../core/error/failures/failures.dart';
import '../../../data/repository/conversation_repository_impl.dart';
import '../../../domain/entity/conversation_entity/conversation_entity.dart';
import 'conversation_calendar_tab.dart';

final conversationCalendarTabStateProvider = StateNotifierProvider.autoDispose
    .family<ConversationCalendarStateNofier, ConversationTabType>(
        (ref, type) => ConversationCalendarStateNofier(type, ref.read));

class ConversationCalendarStateNofier
    extends StateNotifier<ApiResult<List<ConversationByDate>>> {
  final Reader read;
  final ConversationTabType type;

  ConversationCalendarStateNofier(this.type, this.read)
      : super(ApiResult<List<ConversationByDate>>.loading()) {
    final start = DateTime.now();
    final end = start.add(Duration(days: 7));
    getConversationForDateRange(start, end);
  }

  Future<Either<Failure, List<ConversationByDate>>> getConversationForDateRange(
      DateTime start, DateTime end) async {
    state = ApiResult<List<ConversationByDate>>.loading();

    final response = await read(conversationRepositoryProvider)
        .getAllConversations(start, end);

    state = response.fold(
      (failure) => ApiResult<List<ConversationByDate>>.error(failure),
      (data) => ApiResult<List<ConversationByDate>>.data(data),
    );

    return response;
  }
}
