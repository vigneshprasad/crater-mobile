import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/core/error/failures/failures.dart';
import 'package:worknetwork/features/auth/data/repository/auth_repository_impl.dart';
import 'package:worknetwork/features/conversations/domain/entity/conversation_entity/conversation_entity.dart';
import 'package:worknetwork/features/meeting/data/models/dyte_meeting_model.dart';
import 'package:worknetwork/features/meeting/domain/repository/dyte_repository.dart';

final getDyteCredsNotifierProvider = StateNotifierProvider.autoDispose
    .family<GetDyteCredsNotifier, AsyncValue<_DyteMeetingScreenState>, int>(
        (ref, meetingId) {
  final meetingRepository = KiwiContainer().resolve<DyteRepository>();

  return GetDyteCredsNotifier(ref.read, meetingRepository, meetingId);
});

class GetDyteCredsNotifier
    extends StateNotifier<AsyncValue<_DyteMeetingScreenState>> {
  final DyteRepository _meetingRepository;
  final int _meetingId;
  final Reader read;

  GetDyteCredsNotifier(
    this.read, 
    this._meetingRepository,
    this._meetingId,
  ) : super(const AsyncValue<_DyteMeetingScreenState>.loading()) {
    retrieveProfile();
  }

  Future<void> retrieveProfile() async {
    state = const AsyncValue<_DyteMeetingScreenState>.loading();

    // final response = await _meetingRepository.getDyteCredsRequest(_meetingId);

    final response = await _meetingRepository.getRoom(_meetingId);

    if (response.isLeft()) {
      state = AsyncValue<_DyteMeetingScreenState>.error(
          ServerFailure(message: 'something went wrong'));
      return;
    }

    final permissionResponse = await read(authRepositoryProvider).getUserPermission();

    final dyteInfo = response.getOrElse(() => DyteMeeting());
    final permission = permissionResponse.getOrElse(() => UserPermission(allowChat: false, allowCreateStream: false));

    final _profileScreenState = _DyteMeetingScreenState(
      room: dyteInfo.dyteMeetingDetail?.roomName ?? '',
      token: dyteInfo.authToken ?? '',
      allowChat: permission.allowChat ?? false,
    );
    state = AsyncValue<_DyteMeetingScreenState>.data(_profileScreenState);
  }

}

class _DyteMeetingScreenState extends Equatable {
  final String token;
  final String room;
  final bool allowChat;

  const _DyteMeetingScreenState({
    required this.token,
    required this.room,
    required this.allowChat,
  });

  @override
  List<Object> get props => [
        token,
        room,
        allowChat,
      ];
}
