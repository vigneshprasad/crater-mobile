import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/core/error/failures/failures.dart';
import 'package:worknetwork/features/meeting/data/models/dyte_request_model.dart';
import 'package:worknetwork/features/meeting/domain/repository/dyte_repository.dart';

final getDyteCredsNotifierProvider = StateNotifierProvider.autoDispose
    .family<GetDyteCredsNotifier, AsyncValue<_DyteMeetingScreenState>, int>(
        (ref, meetingId) {
  final meetingRepository = KiwiContainer().resolve<DyteRepository>();

  return GetDyteCredsNotifier(meetingRepository, meetingId);
});

class GetDyteCredsNotifier
    extends StateNotifier<AsyncValue<_DyteMeetingScreenState>> {
  final DyteRepository _meetingRepository;
  final int _meetingId;

  GetDyteCredsNotifier(
    this._meetingRepository,
    this._meetingId,
  ) : super(const AsyncValue<_DyteMeetingScreenState>.loading()) {
    retrieveProfile();
  }

  Future<void> retrieveProfile() async {
    state = const AsyncValue<_DyteMeetingScreenState>.loading();

    final response = await _meetingRepository.getDyteCredsRequest(_meetingId);

    if (response.isLeft()) {
      state = AsyncValue<_DyteMeetingScreenState>.error(
          ServerFailure(message: 'something went wrong'));
      return;
    }

    final dyteInfo = response.getOrElse(() => DyteRequestModel());

    final _profileScreenState = _DyteMeetingScreenState(
      room: dyteInfo.meetingDetail?.room ?? '',
      token: dyteInfo.token ?? '',
    );
    state = AsyncValue<_DyteMeetingScreenState>.data(_profileScreenState);
  }
}

class _DyteMeetingScreenState extends Equatable {
  final String token;
  final String room;

  const _DyteMeetingScreenState({
    required this.token,
    required this.room,
  });

  @override
  List<Object> get props => [
        token,
        room,
      ];
}
