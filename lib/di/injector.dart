import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/features/chat_inbox/presentation/bloc/chat_inbox/chat_inbox_bloc.dart';
import 'package:worknetwork/features/chat_inbox/presentation/bloc/chat_search/chat_search_bloc.dart';

import '../api/auth/auth_api_service.dart';
import '../constants/app_constants.dart';
import '../core/features/websocket/data/datasources/weboscket_local_datasource.dart';
import '../core/features/websocket/data/datasources/weboscket_remote_datasource.dart';
import '../core/features/websocket/data/repository/websocket_repository_impl.dart';
import '../core/features/websocket/domain/repository/websocket_repository.dart';
import '../core/features/websocket/domain/usecase/add_message_to_sink.dart';
import '../core/features/websocket/domain/usecase/get_websocket_state.dart';
import '../core/features/websocket/domain/usecase/websocket_connect_usecase.dart';
import '../core/features/websocket/presentation/bloc/websocket_bloc.dart';
import '../features/auth/data/datasources/auth_local_datasource.dart';
import '../features/auth/data/datasources/auth_remote_datasource.dart';
import '../features/auth/data/repository/auth_repository_impl.dart';
import '../features/auth/domain/repository/auth_repository.dart';
import '../features/auth/domain/usecase/get_persisted_user_usercase.dart';
import '../features/auth/domain/usecase/google_auth_usecase.dart';
import '../features/auth/domain/usecase/linked_auth_usecase.dart';
import '../features/auth/domain/usecase/login_email_usercase.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/chat/data/datasources/chat_local_datasource.dart';
import '../features/chat/data/datasources/chat_remote_datasource.dart';
import '../features/chat/data/repository/chat_repository_impl.dart';
import '../features/chat/domain/repository/chat_repository.dart';
import '../features/chat/domain/usecases/persist_received_message.dart';
import '../features/chat/domain/usecases/received_set_chat_with_user.dart';
import '../features/chat/domain/usecases/send_message_to_user_usecase.dart';
import '../features/chat/domain/usecases/send_user_typing.dart';
import '../features/chat/domain/usecases/set_chat_with_user_usecase.dart';
import '../features/chat/presentation/bloc/chat_bloc.dart';
import '../features/chat_inbox/data/datasources/chat_inbox_local_datasource.dart';
import '../features/chat_inbox/data/datasources/chat_inbox_remote_datasource.dart';
import '../features/chat_inbox/data/repository/chat_inbox_repository_impl.dart';
import '../features/chat_inbox/domain/repository/chat_inbox_repository.dart';
import '../features/chat_inbox/domain/usecase/get_all_chat_users_usecase.dart';
import '../features/chat_inbox/domain/usecase/received_all_chat_users_usecase.dart';
import '../features/chat_inbox/domain/usecase/received_star_user_changed_usecase.dart';
import '../features/chat_inbox/domain/usecase/send_star_chat_user_usecase.dart';
import '../features/social_auth/data/datasources/social_auth_remote_datasource.dart';
import '../features/social_auth/data/repository/social_auth_repository_impl.dart';
import '../features/social_auth/domain/repository/social_auth_repository.dart';
import '../features/social_auth/domain/usecase/get_social_auth_token.dart';

part 'injector.g.dart';

abstract class WebSocketInjector {
  @Register.singleton(WebsocketBloc)
  @Register.singleton(WebSocketRepository, from: WebsocketRepositoryImpl)
  @Register.singleton(WebSocketRemoteDataSource,
      from: WebSocketRemoteDataSourceImpl)
  @Register.singleton(WebSocketLocalDataSource,
      from: WebsocketLocalDataSourceImpl)
  @Register.singleton(UCWebsocketConnect)
  @Register.singleton(UCWebSocketGetConnection)
  @Register.singleton(UCWebSocketAddToSink)
  void configure();
}

abstract class AuthInjector {
  @Register.singleton(AuthBloc)
  @Register.singleton(AuthApiService, from: AuthApiServiceImpl)
  @Register.singleton(AuthRepository, from: AuthRepositoryImpl)
  @Register.singleton(AuthRemoteDataSource, from: AuthRemoteDataSourceImpl)
  @Register.singleton(AuthLocalDataSource, from: AuthLocalDataSourceImpl)
  @Register.singleton(UCGetPersistedUser)
  @Register.singleton(UCGoogleAuth)
  @Register.singleton(UCLoginEmail)
  @Register.singleton(UCAuthLinkedIn)
  void configure();
}

abstract class SocialAuthInjector {
  @Register.singleton(UCGetSocialAuthToken)
  @Register.singleton(SocialAuthRepository, from: SocialAuthRepositoryImpl)
  @Register.singleton(SocialAuthRemoteDataSource,
      from: SocialAuthRemoteDataSourceImpl)
  void configure();
}

abstract class ChatInboxInjector {
  @Register.factory(ChatInboxBloc)
  @Register.factory(ChatSearchBloc)
  @Register.singleton(ChatInboxRepository, from: ChatInboxRepositoryImpl)
  @Register.singleton(ChatInboxLocalDataSource,
      from: ChatInboxLocalDataSourceImpl)
  @Register.singleton(ChatInboxRemoteDataSource,
      from: ChatInboxRemoteDataSourceImpl)
  @Register.singleton(UCGetAllChatUsers)
  @Register.singleton(UCRecievedAllChatUsers)
  @Register.singleton(UCSendStarChatUser)
  @Register.singleton(UCReceivedStarUserChanged)
  void configure();
}

abstract class ChatInjector {
  @Register.factory(ChatBloc)
  @Register.singleton(ChatRepository, from: ChatRepositoryImpl)
  @Register.singleton(ChatLocalDataSource, from: ChatLocalDataSourceImpl)
  @Register.singleton(ChatRemoteDataSource, from: ChatRemoteDataSourceImpl)
  @Register.singleton(UCSetChatWithUser)
  @Register.singleton(UCSendChatToUser)
  @Register.singleton(UCReceivedSetChatWithUser)
  @Register.singleton(UCSendUserIsTyping)
  @Register.singleton(UCPersistReceivedMessage)
  void configure();
}

class Di {
  static void setup() {
    final container = KiwiContainer();
    final authInjector = _$AuthInjector();
    final socialAuthInjector = _$SocialAuthInjector();
    final websocketInjector = _$WebSocketInjector();
    final chatInboxInjector = _$ChatInboxInjector();
    final chatInjector = _$ChatInjector();

    /// [Core]
    ///
    /// Weboscket
    websocketInjector.configure();

    /// [Features]
    ///
    // Auth
    authInjector.configure();

    // Social Auth
    socialAuthInjector.configure();

    // Chat Inbox
    chatInboxInjector.configure();

    // Chat
    chatInjector.configure();

    // Externals
    container.registerInstance(GoogleSignIn(
      scopes: AppConstants.googleAuthScope,
    ));
    container.registerInstance(GlobalKey<NavigatorState>());
  }
}
