import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/core/error/failures.dart';
import 'package:worknetwork/features/meeting/domain/entity/time_slot_entity.dart';

import '../../../../meeting/domain/repository/meeting_repository.dart';

part 'timeslots_screen_state.freezed.dart';

final getTimeslotsNotifier = StateNotifierProvider.autoDispose
    .family<GetTimeSlotsNotifier, TimeSlotsState, String>((ref, requestedTo) {
  final meetingRepository = KiwiContainer().resolve<MeetingRepository>();
  return GetTimeSlotsNotifier(meetingRepository, requestedTo, ref.read);
});

@freezed
abstract class TimeSlotsState with _$TimeSlotsState {
  factory TimeSlotsState.loading() = _TimeSlotsStateLoading;
  factory TimeSlotsState.data(List<TimeSlot> timeslots) = _TimeSlotsStateData;
  factory TimeSlotsState.error(Failure error, [StackTrace? stackTrace]) =
      _TimeSlotsStateError;
}

class GetTimeSlotsNotifier extends StateNotifier<TimeSlotsState> {
  final MeetingRepository _meetingRepository;
  final Reader read;
  final String requestedTo;

  GetTimeSlotsNotifier(
    this._meetingRepository,
    this.requestedTo,
    this.read,
  ) : super(TimeSlotsState.loading()) {
    getInitialData();
  }

  Future<void> getInitialData() async {
    state = TimeSlotsState.loading();

    final futures = [
      _meetingRepository.getMeetingRequestSlots(requestedTo),
    ];

    final response = await Future.wait(futures);

    for (final result in response) {
      if (result.isLeft()) {
        final failure = result.swap().getOrElse(() => ServerFailure());
        state = TimeSlotsState.error(failure);
        return;
      }
    }

    final slots = response[0].getOrElse(() => List<TimeSlot>.empty());

    state = TimeSlotsState.data(slots);
  }
}
