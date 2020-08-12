import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:worknetwork/api/masterclass/masterclass_api_service.dart';
import 'package:worknetwork/blocs/masterclass/repo/masterclass_repository.dart';

part 'masterclass_event.dart';
part 'masterclass_state.dart';

class MasterclassBloc extends Bloc<MasterclassEvent, MasterclassState> {
  final MasterClassRepository _masterClassRepository = MasterClassRepository();

  MasterclassBloc() : super(MasterclassInitial());

  @override
  Stream<MasterclassState> mapEventToState(
    MasterclassEvent event,
  ) async* {
    if (event is MasterclassGetStarted) {
      yield* _mapGetList();
    }
  }

  Stream<MasterclassState> _mapGetList() async* {
    try {
      yield const MasterclassGetLoading();
      final respose = await _masterClassRepository.getMasterClassList();
      yield MasterclassGetSuccess(response: respose);
    } catch (error) {
      yield MasterclassGetError(error: error);
    }
  }

  @override
  Future<void> close() {
    _masterClassRepository.dispose();
    return super.close();
  }
}
