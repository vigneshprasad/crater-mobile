import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/features/websocket/data/models/ws_response.dart';
import '../../../../../core/features/websocket/presentation/bloc/websocket_bloc.dart';
import '../../../data/models/responses.dart';
import '../../../domain/entity/chat_user_entity.dart';
import '../../../domain/usecase/get_all_chat_users_usecase.dart';

part 'chat_search_event.dart';
part 'chat_search_state.dart';

class ChatSearchBloc extends Bloc<ChatSearchEvent, ChatSearchState> {
  final WebsocketBloc websocketBloc;
  final UCGetAllChatUsers getAllChatUsers;
  StreamSubscription _websocketBlocSub;
  StreamSubscription _socketStreamSub;

  ChatSearchBloc({
    @required this.websocketBloc,
    @required this.getAllChatUsers,
  }) : super(const ChatSearchInitial()) {
    if (websocketBloc.state is WebSocketConnected) {
      add(const WebSocketBlocConnected());
    } else {
      _websocketBlocSub ??= websocketBloc.listen((websocketblocState) {
        if (websocketblocState is WebSocketConnected) {
          add(const WebSocketBlocConnected());
        }
      });
    }
  }

  @override
  Future<void> close() {
    _socketStreamSub?.cancel();
    _websocketBlocSub?.cancel();
    return super.close();
  }

  @override
  Stream<ChatSearchState> mapEventToState(
    ChatSearchEvent event,
  ) async* {
    if (event is WebSocketBlocConnected) {
      _mapSocketStreamToEvents();
      yield state;
    } else if (event is SendSearchUsersRequestStarted) {
      yield* _mapSendSearchRequestToState(event);
    }

    // Stream Responses
    if (event is SearchResultsReceived) {
      yield* _mapSearchResultsToState(event);
    }
  }

  void _mapSocketStreamToEvents() {
    final websocketState = websocketBloc.state as WebSocketConnected;
    _socketStreamSub ??= websocketState.controller.stream.listen((snapShot) {
      final json = jsonDecode(snapShot.toString()) as Map<String, dynamic>;
      final type = WSResponse.getEnumFromJson(json["type"]);

      if (type == WSResponseType.getSearchAllUsers) {
        final response = GetSearchAllUsersResponse.fromJson(json);
        add(SearchResultsReceived(response: response));
      }
    });
  }

  Stream<ChatSearchState> _mapSearchResultsToState(
      SearchResultsReceived event) async* {
    yield ChatSearchResultsLoaded(
      error: event.response.errors,
      results: event.response.results,
      page: event.response.page,
      pages: event.response.pages,
    );
  }

  Stream<ChatSearchState> _mapSendSearchRequestToState(
      SendSearchUsersRequestStarted event) async* {
    final cacheOrError = await getAllChatUsers(GetAllUsersParams(
      search: event.search,
      page: event.page,
      latestMessage: "all",
    ));

    yield cacheOrError.fold(
      (failure) => state.copyWith(error: failure),
      (results) => ChatResultsCacheLoaded(
        // ignore: avoid_redundant_argument_values
        error: null,
        page: state.page,
        pages: state.page,
        results: results,
      ),
    );
  }
}
