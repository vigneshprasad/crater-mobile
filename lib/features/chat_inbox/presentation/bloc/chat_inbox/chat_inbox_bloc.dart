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
import '../../../domain/usecase/persist_chat_users.dart';
import '../../../domain/usecase/received_star_user_changed_usecase.dart';
import '../../../domain/usecase/send_star_chat_user_usecase.dart';

part 'chat_inbox_event.dart';
part 'chat_inbox_state.dart';

class ChatInboxBloc extends Bloc<ChatInboxEvent, ChatInboxState> {
  final WebsocketBloc websocketBloc;
  final UCGetAllChatUsers getAllChatUsers;
  final UCPersistChatUsers persistChatUsers;
  final UCSendStarChatUser starChatUser;
  final UCReceivedStarUserChanged starUserChanged;
  StreamSubscription _websocketBlocSub;
  StreamSubscription _socketStreamSub;

  ChatInboxBloc({
    @required this.websocketBloc,
    @required this.getAllChatUsers,
    @required this.persistChatUsers,
    @required this.starChatUser,
    @required this.starUserChanged,
  }) : super(const ChatInboxInitial()) {
    if (websocketBloc.state is WebSocketConnected) add(const WebSocketOnline());
    _websocketBlocSub ??= websocketBloc.listen((websocketState) {
      if (websocketState is WebSocketConnected) {
        add(const WebSocketOnline());
      }
    });
  }

  @override
  Future<void> close() {
    _websocketBlocSub?.cancel();
    _socketStreamSub?.cancel();
    return super.close();
  }

  @override
  Stream<ChatInboxState> mapEventToState(
    ChatInboxEvent event,
  ) async* {
    if (event is WebSocketOnline) {
      _mapSocketStreamToEvents();
    } else if (event is AllChatUsersReceived) {
      yield* _mapReceivedChatUsersToState(event);
    } else if (event is StarUserChangeRecieved) {
      yield* _mapReceivedStarUserChangeToState(event);
    }

    // Requests
    if (event is GetAllChatUsersRequest) {
      yield* _mapGetAllChatUsersToState(event);
    } else if (event is StarUserRequestStarted) {
      yield* _mapStarUserRequestToState(event);
    }
  }

  void _mapSocketStreamToEvents() {
    final state = websocketBloc.state as WebSocketConnected;
    _socketStreamSub ??= state.controller.stream.listen((snapShot) {
      final json = jsonDecode(snapShot.toString()) as Map<String, dynamic>;
      final type = WSResponse.getEnumFromJson(json["type"]);

      if (type == WSResponseType.loadAllUsers) {
        final response = GetAllUsersResponse.fromJson(json);
        add(AllChatUsersReceived(response: response));
      } else if (type == WSResponseType.starUser ||
          type == WSResponseType.unstarUser) {
        final isStarred = type == WSResponseType.starUser;
        add(StarUserChangeRecieved(
          user: json["user"] as String,
          isStarred: isStarred,
        ));
      }
    });
  }

  Stream<ChatInboxState> _mapGetAllChatUsersToState(
      GetAllChatUsersRequest event) async* {
    final usersOrError = await getAllChatUsers(GetAllUsersParams(
      filter: event.filter,
      page: event.page,
      search: event.search,
    ));

    yield usersOrError.fold(
      (failure) => ChatInboxError(error: failure),
      (fromCache) => ChatInboxUsersResponseReceived(
        users: const [],
        page: fromCache.page,
        pages: fromCache.pages,
        fromCache: true,
      ),
    );
  }

  Stream<ChatInboxState> _mapReceivedChatUsersToState(
      AllChatUsersReceived event) async* {
    final usersOrError = await persistChatUsers(PersistChatUsersParaams(
      users: event.response.results,
    ));

    yield usersOrError.fold(
      (failure) => ChatInboxError(error: failure),
      (users) => ChatInboxUsersResponseReceived(
        fromCache: false,
        page: event.response.page,
        pages: event.response.pages,
        users: event.response.results,
      ),
    );
  }

  Stream<ChatInboxState> _mapStarUserRequestToState(
      StarUserRequestStarted event) async* {
    await starChatUser(
        SendStarChatUserParams(user: event.user, isStarred: event.isStarred));
  }

  Stream<ChatInboxState> _mapReceivedStarUserChangeToState(
      StarUserChangeRecieved event) async* {
    final userOrError = await starUserChanged(
        ReceivedStarUserParams(isStarred: event.isStarred, user: event.user));
    yield userOrError.fold(
      (failure) => ChatInboxError(error: failure),
      (user) => ChatInboxStarChangeReceived(user: user),
    );
  }
}
