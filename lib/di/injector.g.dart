// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$WebSocketInjector extends WebSocketInjector {
  void configure() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => WebsocketBloc(
        connectionState: c<UCWebSocketGetConnection>(),
        connect: c<UCWebsocketConnect>(),
        addToSink: c<UCWebSocketAddToSink>(),
        authBloc: c<AuthBloc>()));
    container.registerSingleton<WebSocketRepository>((c) =>
        WebsocketRepositoryImpl(
            localDataSource: c<WebSocketLocalDataSource>(),
            remoteDataSource: c<WebSocketRemoteDataSource>(),
            authRepository: c<AuthRepository>()));
    container.registerSingleton<WebSocketRemoteDataSource>(
        (c) => WebSocketRemoteDataSourceImpl());
    container.registerSingleton<WebSocketLocalDataSource>(
        (c) => WebsocketLocalDataSourceImpl());
    container.registerSingleton(
        (c) => UCWebsocketConnect(repository: c<WebSocketRepository>()));
    container.registerSingleton(
        (c) => UCWebSocketGetConnection(repository: c<WebSocketRepository>()));
    container.registerSingleton(
        (c) => UCWebSocketAddToSink(repository: c<WebSocketRepository>()));
  }
}

class _$AuthInjector extends AuthInjector {
  void configure() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => AuthBloc(
        persistedUser: c<UCGetPersistedUser>(),
        authLinkedIn: c<UCAuthLinkedIn>(),
        authGoogle: c<UCGoogleAuth>(),
        loginEmail: c<UCLoginEmail>(),
        socialAuthToken: c<UCGetSocialAuthToken>()));
    container.registerSingleton<AuthApiService>((c) => AuthApiServiceImpl());
    container.registerSingleton<AuthRepository>((c) => AuthRepositoryImpl(
        c<AuthRemoteDataSource>(), c<AuthLocalDataSource>()));
    container.registerSingleton<AuthRemoteDataSource>(
        (c) => AuthRemoteDataSourceImpl(c<AuthApiService>()));
    container.registerSingleton<AuthLocalDataSource>(
        (c) => AuthLocalDataSourceImpl());
    container.registerSingleton(
        (c) => UCGetPersistedUser(repository: c<AuthRepository>()));
    container.registerSingleton(
        (c) => UCGoogleAuth(repository: c<AuthRepository>()));
    container.registerSingleton(
        (c) => UCLoginEmail(repository: c<AuthRepository>()));
    container.registerSingleton(
        (c) => UCAuthLinkedIn(repository: c<AuthRepository>()));
  }
}

class _$SocialAuthInjector extends SocialAuthInjector {
  void configure() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton(
        (c) => UCGetSocialAuthToken(repository: c<SocialAuthRepository>()));
    container.registerSingleton<SocialAuthRepository>(
        (c) => SocialAuthRepositoryImpl(c<SocialAuthRemoteDataSource>()));
    container.registerSingleton<SocialAuthRemoteDataSource>(
        (c) => SocialAuthRemoteDataSourceImpl(googleSignIn: c<GoogleSignIn>()));
  }
}

class _$ChatInboxInjector extends ChatInboxInjector {
  void configure() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory((c) => ChatInboxBloc(
        websocketBloc: c<WebsocketBloc>(),
        getAllChatUsers: c<UCGetAllChatUsers>(),
        recievedAllChatUsers: c<UCRecievedAllChatUsers>(),
        starChatUser: c<UCSendStarChatUser>(),
        starUserChanged: c<UCReceivedStarUserChanged>()));
    container.registerFactory((c) => ChatSearchBloc(
        websocketBloc: c<WebsocketBloc>(),
        getAllChatUsers: c<UCGetAllChatUsers>()));
    container.registerSingleton<ChatInboxRepository>((c) =>
        ChatInboxRepositoryImpl(
            localDataSource: c<ChatInboxLocalDataSource>(),
            remoteDataSource: c<ChatInboxRemoteDataSource>()));
    container.registerSingleton<ChatInboxLocalDataSource>(
        (c) => ChatInboxLocalDataSourceImpl());
    container.registerSingleton<ChatInboxRemoteDataSource>((c) =>
        ChatInboxRemoteDataSourceImpl(
            webSocketRepository: c<WebSocketRepository>()));
    container.registerSingleton(
        (c) => UCGetAllChatUsers(repository: c<ChatInboxRepository>()));
    container.registerSingleton(
        (c) => UCRecievedAllChatUsers(repository: c<ChatInboxRepository>()));
    container.registerSingleton(
        (c) => UCSendStarChatUser(repository: c<ChatInboxRepository>()));
    container.registerSingleton(
        (c) => UCReceivedStarUserChanged(repository: c<ChatInboxRepository>()));
  }
}

class _$ChatInjector extends ChatInjector {
  void configure() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory((c) => ChatBloc(
        websocketBloc: c<WebsocketBloc>(),
        setChatWithUser: c<UCSetChatWithUser>(),
        sendMessage: c<UCSendChatToUser>(),
        receivedSetChatWithUser: c<UCReceivedSetChatWithUser>(),
        sendUserIsTyping: c<UCSendUserIsTyping>(),
        persistReceivedMessage: c<UCPersistReceivedMessage>()));
    container.registerSingleton<ChatRepository>((c) => ChatRepositoryImpl(
        repository: c<WebSocketRepository>(),
        localDataSource: c<ChatLocalDataSource>(),
        remoteDataSource: c<ChatRemoteDataSource>()));
    container.registerSingleton<ChatLocalDataSource>(
        (c) => ChatLocalDataSourceImpl());
    container.registerSingleton<ChatRemoteDataSource>(
        (c) => ChatRemoteDataSourceImpl(repository: c<WebSocketRepository>()));
    container.registerSingleton(
        (c) => UCSetChatWithUser(repository: c<ChatRepository>()));
    container.registerSingleton(
        (c) => UCSendChatToUser(repository: c<ChatRepository>()));
    container.registerSingleton(
        (c) => UCReceivedSetChatWithUser(repository: c<ChatRepository>()));
    container.registerSingleton(
        (c) => UCSendUserIsTyping(repository: c<ChatRepository>()));
    container.registerSingleton(
        (c) => UCPersistReceivedMessage(repository: c<ChatRepository>()));
  }
}
