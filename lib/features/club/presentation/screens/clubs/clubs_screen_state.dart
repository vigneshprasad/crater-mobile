import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/api_result/api_result.dart';
import '../../../../../core/error/failures/failures.dart';
import '../../../../conversations/data/repository/conversation_repository_impl.dart';
import '../../../../conversations/domain/entity/conversation_entity/conversation_entity.dart';

final clubsStateProvider =
    StateNotifierProvider<ClubsStateNotifier, ApiResult<List<Conversation>>>(
        (ref) => ClubsStateNotifier(ref.read));

class ClubsStateNotifier extends StateNotifier<ApiResult<List<Conversation>>> {
  final Reader read;

  ClubsStateNotifier(this.read)
      : super(ApiResult<List<Conversation>>.loading()) {
    getInitialData();
  }

  Future<void> getInitialData() async {
    final _start = DateTime.now().subtract(Duration(days: 7));
    final _end = _start.add(const Duration(days: 7));

    final response = await read(conversationRepositoryProvider)
        .getAllConversations(_start, _end);

    if (response.isLeft()) {
      throw response.swap().getOrElse(() => ServerFailure());
    }

    final conversations =
        response.getOrElse(() => List<ConversationByDate>.empty());

    final c = List<Conversation>.empty(growable: true);

    for (final e in conversations) {
      c.addAll(e.conversations ?? []);
    }

    state = ApiResult.data(c);
  }
}
