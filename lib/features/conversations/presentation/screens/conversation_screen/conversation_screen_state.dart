import 'package:dartz/dartz.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:worknetwork/core/api_result/api_result.dart';
import 'package:worknetwork/core/error/failures/failures.dart';
import 'package:worknetwork/features/conversations/data/repository/conversation_repository_impl.dart';
import 'package:worknetwork/features/conversations/domain/entity/conversation_entity/conversation_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/conversation_request_entity/conversation_request_entity.dart';

class ConversationScreenData {
  final Conversation conversation;
  final bool isRSVPed;

  ConversationScreenData(this.conversation, this.isRSVPed);
}

final conversationStateProvider = StateNotifierProvider.autoDispose
    .family<ConversationState, ApiResult<ConversationScreenData>, int>(
  (ref, id) => ConversationState(ref.read, id),
);

class ConversationState
    extends StateNotifier<ApiResult<ConversationScreenData>> {
  final Reader read;
  final int _groupId;

  ConversationState(this.read, this._groupId) : super(ApiResult.loading()) {
    retrieveConversation();
  }

  Future<Either<Failure, Conversation>> retrieveConversation({
    bool justRSVPed = false,
  }) async {
    final response = await read(conversationRepositoryProvider)
        .retreiveConversation(_groupId);

    final requestResponse = await read(conversationRepositoryProvider)
        .getWebinarRSVPRequest(_groupId);

    if (!mounted) {
      return response;
    }

    state = response.fold(
      (failure) => ApiResult.error(failure),
      (group) {
        final isRSVPed = justRSVPed || requestResponse.isRight();
        final data = ConversationScreenData(group, isRSVPed);
        return ApiResult.data(data);
      },
    );

    return response;
  }

  Future<Either<Failure, ConversationRequest>> postRequestToJoinGroup() async {
    final request = ConversationRequest(
      group: _groupId,
      participantType: ParticpantType.attendee,
      status: RequestStatus.accepted,
    );
    final response = await read(conversationRepositoryProvider)
        .postRequestToJoinGroup(request);

    return response;
  }
}
