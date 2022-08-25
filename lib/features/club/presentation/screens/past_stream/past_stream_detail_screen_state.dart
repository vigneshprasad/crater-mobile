import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/api_result/api_result.dart';
import 'package:worknetwork/core/error/failures/failures.dart';
import 'package:worknetwork/features/conversations/data/repository/conversation_repository_impl.dart';
import 'package:worknetwork/features/conversations/domain/entity/webinar_entity/webinar_entity.dart';

enum RtcConnection { connected, connecting, disconnected }

final pastStreamStateProvider = StateNotifierProvider.autoDispose
    .family<PastStreamState, ApiResult<Webinar>, int>(
  (ref, id) => PastStreamState(ref.read, id),
);

class PastStreamState extends StateNotifier<ApiResult<Webinar>> {
  final Reader read;
  final int _groupId;

  PastStreamState(this.read, this._groupId)
      : super(ApiResult<Webinar>.loading()) {
    retrieveConversation();
  }

  Future<Either<Failure, Webinar>> retrieveConversation() async {
    final response = await read(conversationRepositoryProvider)
        .retreiveConversation(_groupId);

    state = response.fold(
      (failure) => ApiResult.error(failure),
      (group) {
        return ApiResult.data(group);
      },
    );

    return response;
  }
}
