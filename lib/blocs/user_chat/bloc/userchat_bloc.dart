import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:worknetwork/models/chat/chat_model.dart';

part 'userchat_event.dart';
part 'userchat_state.dart';

class UserchatBloc extends Bloc<UserchatEvent, UserchatState> {
  UserchatBloc() : super(const UserchatInitial());

  @override
  Stream<UserchatState> mapEventToState(
    UserchatEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
