import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:worknetwork/blocs/inbox/repo/inbox_repository.dart';
import 'package:worknetwork/blocs/websocket/repo/websocket_repository.dart';
import 'package:worknetwork/models/chat/chat_model.dart';
import 'package:worknetwork/models/websocket/response/ws_response.dart';
import 'package:worknetwork/models/websocket/requests/ws_requests.dart';

part 'inbox_event.dart';
part 'inbox_state.dart';

class InboxBloc extends Bloc<InboxEvent, InboxState> {
  final WebSocketRepository webSocketRepository;
  InboxRepository _inboxRepository;
  StreamSubscription _inboxSocketSub;

  // Connect to stream listener
  InboxBloc({@required this.webSocketRepository}) : super(InboxInitial()) {
    _inboxRepository = InboxRepository(webSocketRepository.channel);
    _inboxSocketSub ??=
        webSocketRepository.streamController.stream.listen((snapShot) {
      final json = jsonDecode(snapShot.toString()) as Map<String, dynamic>;
      final WSResponseType type = WSResponse.getEnumFromJson(json["type"]);

      switch (type) {
        case WSResponseType.loadAllUsers:
          add(InboxGetAllUsersLoaded(
              response: WSGetAllUsersResponse.fromJson(json)));
          break;
        default:
          // ignore: avoid_print
          print(json);
          break;
      }
    });
  }

  @override
  Future<void> close() async {
    await _inboxSocketSub.cancel();
    return super.close();
  }

  @override
  Stream<InboxState> mapEventToState(
    InboxEvent event,
  ) async* {
    if (event is InboxGetAllUsers) {
      _inboxRepository.getAllUsersRequest(event.request);
    }

    // Socket Stream onResponse Events
    if (event is InboxGetAllUsersLoaded) {
      yield* _mapAllUserstoState(event);
    }
  }

  Stream<InboxState> _mapAllUserstoState(InboxGetAllUsersLoaded event) async* {
    final resposne = event.response;
    yield AllUsersLoaded(
      page: resposne.page,
      pages: resposne.pages,
      users: resposne.results,
    );
  }
}
