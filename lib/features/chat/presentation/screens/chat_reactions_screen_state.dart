import 'package:dartz/dartz.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/api_result/api_result.dart';
import 'package:worknetwork/core/error/failures/failures.dart';
import 'package:worknetwork/features/conversations/data/repository/conversation_repository_impl.dart';
import 'package:worknetwork/features/conversations/domain/entity/chat_reaction_entity/chat_reaction_entity.dart';


final reactionStateProvider = StateNotifierProvider.autoDispose
    .family<ReactionScreenState, ApiResult<List<ChatReaction>>, String>(
  (ref, id) => ReactionScreenState(ref.read, id),
);

class ReactionScreenState extends StateNotifier<ApiResult<List<ChatReaction>>> {
  final Reader read;
  final String webinarId;

  ReactionScreenState(this.read, this.webinarId)
      : super(ApiResult<List<ChatReaction>>.loading()) {
    retrieveChatReactions();
  }

  Future<Either<Failure, List<ChatReaction>>> retrieveChatReactions() async {
    final response =
        await read(conversationRepositoryProvider).getChatReactions();

    state = response.fold(
      (failure) => ApiResult<List<ChatReaction>>.error(failure),
      (group) {
        return ApiResult<List<ChatReaction>>.data(group);
      },
    );

    return response;
  }
}
