import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc() : super(const CommentInitial());

  @override
  Stream<CommentState> mapEventToState(
    CommentEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
