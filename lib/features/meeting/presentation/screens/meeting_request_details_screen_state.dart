import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/api_result/api_result.dart';
import 'package:worknetwork/core/error/failures.dart';
import 'package:worknetwork/features/meeting/data/repository/meeting_respository_impl.dart';
import 'package:worknetwork/features/meeting/domain/entity/meeting_request_entity.dart';

final meetingRequestStateProvider = StateNotifierProvider.family<
        MeetingRequestStateNotifier, ApiResult<MeetingRequest>, int>(
    (ref, meetingRequestId) =>
        MeetingRequestStateNotifier(ref.read, meetingRequestId));

class MeetingRequestStateNotifier
    extends StateNotifier<ApiResult<MeetingRequest>> {
  final Reader read;
  final int meetingRequestId;
  late bool loadingPage;

  MeetingRequestStateNotifier(
    this.read,
    this.meetingRequestId,
  ) : super(ApiResult<MeetingRequest>.loading()) {
    getConnectableProfileList(meetingRequestId);
  }

  Future<Either<Failure, MeetingRequest>> getConnectableProfileList(
      int meetingRequestId) async {
    state = ApiResult<MeetingRequest>.loading();
    final response = await read(meetingRepositoryProvider)
        .getMeetingRequest(meetingRequestId);

    state = response.fold(
      (failure) {
        return ApiResult<MeetingRequest>.error(null);
      },
      (profiles) {
        return ApiResult<MeetingRequest>.data(profiles);
      },
    );

    return response;
  }
}
