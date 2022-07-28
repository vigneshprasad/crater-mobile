import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/api_result/api_result.dart';
import 'package:worknetwork/core/error/failures/failures.dart';
import 'package:worknetwork/features/conversations/data/repository/conversation_repository_impl.dart';
import 'package:worknetwork/features/conversations/domain/entity/conversation_entity/conversation_entity.dart';

enum RtcConnection { connected, connecting, disconnected }

final pastStreamStateProvider = StateNotifierProvider.autoDispose
    .family<PastStreamState, ApiResult<Conversation>, int>(
  (ref, id) => PastStreamState(ref.read, id),
);

class PastStreamState extends StateNotifier<ApiResult<Conversation>> {
  final Reader read;
  final int _groupId;

  PastStreamState(this.read, this._groupId)
      : super(ApiResult<Conversation>.loading()) {
    retrieveConversation();
  }

  Future<Either<Failure, Conversation>> retrieveConversation() async {
    final response = await read(conversationRepositoryProvider)
        .retreiveConversation(_groupId);

    state = response.fold(
      (failure) => ApiResult<Conversation>.error(failure),
      (group) {
        return ApiResult<Conversation>.data(group);
      },
    );

    return response;
  }
}
