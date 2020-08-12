import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:worknetwork/api/meets/meets_api_service.dart';
import 'package:worknetwork/blocs/meeting/repo/meeting_repository.dart';
import 'package:worknetwork/models/meeting/meeting_model.dart';

part 'meeting_event.dart';
part 'meeting_state.dart';

class MeetingBloc extends Bloc<MeetingEvent, MeetingState> {
  final MeetingRepository _meetingRepository = MeetingRepository();

  MeetingBloc() : super(MeetingInitial());

  @override
  Stream<MeetingState> mapEventToState(
    MeetingEvent event,
  ) async* {
    if (event is MeetingGetStarted) {
      yield* _mapMeetingGet();
    }
  }

  Stream<MeetingState> _mapMeetingGet() async* {
    try {
      yield const MeetingGetLoading();
      final response = await _meetingRepository.getMeetings();
      yield MeetingGetSucess(response: response);
    } catch (error) {
      MeetingGetError(error: error);
    }
  }

  @override
  Future<void> close() {
    _meetingRepository.dispose();
    return super.close();
  }
}
