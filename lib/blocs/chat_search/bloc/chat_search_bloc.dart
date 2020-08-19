import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:worknetwork/blocs/chat/repo/chat_repository.dart';
import 'package:worknetwork/blocs/websocket/repo/websocket_repository.dart';
import 'package:worknetwork/models/chat/chat_model.dart';
import 'package:worknetwork/models/websocket/requests/ws_requests.dart';
import 'package:worknetwork/models/websocket/response/ws_response.dart';

part 'chat_search_event.dart';
part 'chat_search_state.dart';

class ChatSearchBloc extends Bloc<ChatSearchEvent, ChatSearchState> {
  final WebSocketRepository webSocketRepository;
  ChatRepository _chatRepository;
  StreamSubscription _chatSearchSubscription;

  ChatSearchBloc({@required this.webSocketRepository})
      : super(ChatSearchInitial()) {
    _chatRepository = ChatRepository(webSocketRepository.channel);

    _chatSearchSubscription ??=
        webSocketRepository.streamController.stream.listen((snapShot) {
      final json = jsonDecode(snapShot.toString()) as Map<String, dynamic>;
      final WSResponseType type = WSResponse.getEnumFromJson(json["type"]);
      if (type == WSResponseType.loadAllUsers) {
        final response = WSGetAllUsersResponse.fromJson(json);
        add(ChatSearchResultsReceived(response: response));
      }
    });
  }

  @override
  Future<void> close() {
    _chatSearchSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<ChatSearchState> mapEventToState(
    ChatSearchEvent event,
  ) async* {
    if (event is ChatSearchUsersStarted) {
      yield* _mapSearchRequestState(event);
    }

    if (event is ChatSearchResultsReceived) {
      yield* _mapResultsToState(event);
      yield ChatSearchListening();
    }
  }

  Stream<ChatSearchState> _mapSearchRequestState(
      ChatSearchUsersStarted event) async* {
    _chatRepository.searchAllUsers(event.options);
  }

  Stream<ChatSearchState> _mapResultsToState(
      ChatSearchResultsReceived event) async* {
    final users = event.response;
    yield ChatSearchResultsLoaded(users: users.results);
    yield ChatSearchListening();
  }
}
