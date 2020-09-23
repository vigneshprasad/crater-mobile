// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$CoreInjector extends CoreInjector {
  void configure() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton<NetworkInfo>(
        (c) => NetworkInfoImpl(connectionChecker: c<DataConnectionChecker>()));
    container
        .registerSingleton<PushNotifications>((c) => PushNotificationsImpl());
    container.registerSingleton<DeepLinkManager>((c) => DeepLinkManagerImpl());
    container.registerSingleton<LocalStorage>((c) => LocalStorageImpl());
    container.registerSingleton<Analytics>((c) => AnalyticsImpl(
        c<PushNotifications>(), c<AuthLocalDataSource>(), c<NetworkInfo>()));
    container.registerSingleton<Logger>((c) => LoggerImpl(c<SentryClient>()));
  }
}

class _$WebSocketInjector extends WebSocketInjector {
  void configure() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => WebsocketBloc(
        connectionState: c<UCWebSocketGetConnection>(),
        connect: c<UCWebsocketConnect>(),
        addToSink: c<UCWebSocketAddToSink>(),
        authBloc: c<AuthBloc>(),
        socketClose: c<UCWebSocketClose>()));
    container.registerSingleton<WebSocketRepository>((c) =>
        WebsocketRepositoryImpl(
            localDataSource: c<WebSocketLocalDataSource>(),
            remoteDataSource: c<WebSocketRemoteDataSource>(),
            authRepository: c<AuthRepository>(),
            authLocalDataSource: c<AuthLocalDataSource>()));
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
    container.registerSingleton(
        (c) => UCWebSocketClose(repository: c<WebSocketRepository>()));
  }
}

class _$AuthInjector extends AuthInjector {
  void configure() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => AuthBloc(
        getUser: c<UCGetUser>(),
        getUserProfile: c<UCGetUserProfile>(),
        pushNotifications: c<PushNotifications>(),
        getAuthentication: c<UCGetAuthentication>(),
        authLinkedIn: c<UCAuthLinkedIn>(),
        authGoogle: c<UCGoogleAuth>(),
        authWithApple: c<UCAuthWithApple>(),
        authFacebook: c<UCFacebookAuth>(),
        loginEmail: c<UCLoginEmail>(),
        socialAuthToken: c<UCGetSocialAuthToken>(),
        registerEmail: c<UCRegisterEmail>(),
        analytics: c<Analytics>()));
    container.registerSingleton<AuthRepository>((c) => AuthRepositoryImpl(
        c<AuthRemoteDataSource>(), c<AuthLocalDataSource>(), c<NetworkInfo>()));
    container.registerSingleton<AuthRemoteDataSource>((c) =>
        AuthRemoteDataSourceImpl(c<AuthApiService>(), c<UserApiService>()));
    container.registerSingleton<AuthLocalDataSource>(
        (c) => AuthLocalDataSourceImpl());
    container.registerSingleton((c) => UCGetUser(c<AuthRepository>()));
    container.registerSingleton(
        (c) => UCGetAuthentication(repository: c<AuthRepository>()));
    container.registerSingleton(
        (c) => UCGoogleAuth(repository: c<AuthRepository>()));
    container.registerSingleton((c) => UCFacebookAuth(c<AuthRepository>()));
    container.registerSingleton((c) => UCAuthWithApple(c<AuthRepository>()));
    container.registerSingleton(
        (c) => UCLoginEmail(repository: c<AuthRepository>()));
    container.registerSingleton(
        (c) => UCAuthLinkedIn(repository: c<AuthRepository>()));
    container.registerSingleton((c) => UCRegisterEmail(c<AuthRepository>()));
    container
        .registerSingleton((c) => UCPatchUser(repository: c<AuthRepository>()));
    container.registerSingleton((c) => UCPostUserProfile(c<AuthRepository>()));
    container.registerSingleton((c) => UCGetUserProfile(c<AuthRepository>()));
  }
}

class _$SignupInjector extends SignupInjector {
  void configure() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory((c) => ObjectivesBloc(
        getUserObjectives: c<UCGetUserObjectives>(),
        patchUser: c<UCPatchUser>(),
        analytics: c<Analytics>()));
    container.registerFactory((c) => ProfileSetupBloc(
        getUserTags: c<UCGetUserTags>(),
        postUserProfile: c<UCPostUserProfile>(),
        analytics: c<Analytics>()));
    container.registerFactory((c) => PhoneVerifyBloc(
        postNewPhoneNumber: c<UCPostNewPhoneNumber>(),
        postSmsCode: c<UCPostSmsCode>(),
        analytics: c<Analytics>()));
    container.registerSingleton<SignupRepository>(
        (c) => SignupRepositoryImpl(c<SignupRemoteDatasource>()));
    container.registerSingleton<SignupRemoteDatasource>((c) =>
        SignupRemoteDatasourceImpl(c<TagsApiService>(), c<UserApiService>()));
    container
        .registerSingleton((c) => UCGetUserObjectives(c<SignupRepository>()));
    container.registerSingleton((c) => UCGetUserTags(c<SignupRepository>()));
    container
        .registerSingleton((c) => UCPostNewPhoneNumber(c<SignupRepository>()));
    container.registerSingleton((c) => UCPostSmsCode(c<SignupRepository>()));
  }
}

class _$SocialAuthInjector extends SocialAuthInjector {
  void configure() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton(
        (c) => UCGetSocialAuthToken(repository: c<SocialAuthRepository>()));
    container.registerSingleton<SocialAuthRepository>(
        (c) => SocialAuthRepositoryImpl(c<SocialAuthRemoteDataSource>()));
    container.registerSingleton<SocialAuthRemoteDataSource>((c) =>
        SocialAuthRemoteDataSourceImpl(
            googleSignIn: c<GoogleSignIn>(),
            facebookLogin: c<FacebookLogin>()));
  }
}

class _$CommunityInjector extends CommunityInjector {
  void configure() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory((c) => CommunityBloc(
        getPostsPage: c<UCGetPostsPage>(),
        deletePost: c<UCDeletePost>(),
        createLikePost: c<UCCreateLikePost>(),
        deleteLikePost: c<UCDeleteLikePost>()));
    container.registerFactory((c) => PostBloc(
        getPost: c<UCGetPost>(),
        getCommentsPage: c<UCGetCommentsPage>(),
        createComment: c<UCCreateCommentPost>()));
    container.registerFactory((c) => CreatePostBloc(
        createPost: c<UCCreatePost>(), analytics: c<Analytics>()));
    container.registerSingleton<CommunityRepository>((c) =>
        CommunityRepositoryImpl(
            remoteDatasource: c<CommunityRemoteDatasource>(),
            localDatasource: c<CommunityLocalDatasource>(),
            networkInfo: c<NetworkInfo>()));
    container.registerSingleton<CommunityLocalDatasource>(
        (c) => CommunityLocalDatasourceImpl());
    container.registerSingleton<CommunityRemoteDatasource>(
        (c) => CommunityRemoteDatasourceImpl(apiService: c<PostApiService>()));
    container
        .registerSingleton((c) => UCGetPostsPage(c<CommunityRepository>()));
    container.registerSingleton((c) => UCGetPost(c<CommunityRepository>()));
    container.registerSingleton((c) => UCCreatePost(c<CommunityRepository>()));
    container.registerSingleton(
        (c) => UCDeletePost(repository: c<CommunityRepository>()));
    container.registerSingleton(
        (c) => UCCreateLikePost(repository: c<CommunityRepository>()));
    container.registerSingleton(
        (c) => UCDeleteLikePost(repository: c<CommunityRepository>()));
    container
        .registerSingleton((c) => UCGetCommentsPage(c<CommunityRepository>()));
    container.registerSingleton(
        (c) => UCCreateCommentPost(c<CommunityRepository>()));
  }
}

class _$ChatInboxInjector extends ChatInboxInjector {
  void configure() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory((c) => ChatInboxBloc(
        websocketBloc: c<WebsocketBloc>(),
        getAllChatUsers: c<UCGetAllChatUsers>(),
        persistChatUsers: c<UCPersistChatUsers>(),
        starChatUser: c<UCSendStarChatUser>(),
        starUserChanged: c<UCReceivedStarUserChanged>()));
    container.registerFactory((c) => ChatSearchBloc(
        websocketBloc: c<WebsocketBloc>(),
        getAllChatUsers: c<UCSearchAllUsers>()));
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
        (c) => UCSearchAllUsers(repository: c<ChatInboxRepository>()));
    container.registerSingleton(
        (c) => UCSendStarChatUser(repository: c<ChatInboxRepository>()));
    container.registerSingleton(
        (c) => UCReceivedStarUserChanged(repository: c<ChatInboxRepository>()));
    container
        .registerSingleton((c) => UCPersistChatUsers(c<ChatInboxRepository>()));
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

class _$ArticleInjector extends ArticleInjector {
  void configure() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory((c) => ArticleBloc(
        getArticles: c<UCGetArticlesPage>(),
        getArticleWebsites: c<UCGetArticleWebsites>()));
    container.registerSingleton<ArticleRepository>((c) => ArticleRepositoryImpl(
        remoteDatasource: c<ArticleRemoteDatasource>(),
        localDatasource: c<ArticleLocalDatasource>(),
        networkInfo: c<NetworkInfo>()));
    container.registerSingleton<ArticleRemoteDatasource>((c) =>
        ArticleRemoteDatasourceImpl(
            apiService: c<ArticlesApiService>(),
            tagsApiService: c<TagsApiService>()));
    container.registerSingleton<ArticleLocalDatasource>(
        (c) => ArticleLocalDatasourceImpl());
    container
        .registerSingleton((c) => UCGetArticlesPage(c<ArticleRepository>()));
    container
        .registerSingleton((c) => UCGetArticleWebsites(c<ArticleRepository>()));
  }
}

class _$VideoInjector extends VideoInjector {
  void configure() {
    final KiwiContainer container = KiwiContainer();
    container
        .registerFactory((c) => VideoBloc(getVideos: c<UCGetVideosListPage>()));
    container.registerFactory((c) => VideoPlayerBloc(
        getVideoItem: c<UCGetVideoItem>(),
        getVideosList: c<UCGetVideosListPage>()));
    container.registerSingleton<VideoRepository>((c) => VideoRepositoryImpl(
        networkInfo: c<NetworkInfo>(),
        localDataSource: c<VideoLocalDataSource>(),
        remoteDatasource: c<VideoRemoteDatasource>()));
    container.registerSingleton<VideoLocalDataSource>(
        (c) => VideoLocalDataSourceImpl());
    container.registerSingleton<VideoRemoteDatasource>((c) =>
        VideoRemoteDatasourceImpl(apiService: c<MasterClassApiService>()));
    container.registerSingleton(
        (c) => UCGetVideosListPage(repository: c<VideoRepository>()));
    container.registerSingleton(
        (c) => UCGetVideoItem(repository: c<VideoRepository>()));
  }
}

class _$MeetingInjector extends MeetingInjector {
  void configure() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory((c) => MeetingBloc(
        getMeetingConfig: c<UCGetMeetingConfig>(),
        postMeetingPreferences: c<UCPostMeetingPreferences>(),
        patchMeetingPreferences: c<UCPatchMeetingPreferences>(),
        postUserProfile: c<UCPostUserProfile>()));
    container.registerSingleton<MeetingRepository>((c) => MeetingRepositoryImpl(
        remoteDatasource: c<MeetingRemoteDatasource>(),
        networkInfo: c<NetworkInfo>()));
    container.registerSingleton<MeetingRemoteDatasource>(
        (c) => MeetingRemoteDatasourceImpl(c<MeetsApiService>()));
    container
        .registerSingleton((c) => UCGetMeetingConfig(c<MeetingRepository>()));
    container.registerSingleton(
        (c) => UCPostMeetingPreferences(c<MeetingRepository>()));
    container.registerSingleton(
        (c) => UCPatchMeetingPreferences(c<MeetingRepository>()));
  }
}

class _$PointsInjector extends PointsInjector {
  void configure() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory(
        (c) => PointsBloc(getPoints: c<UCGetSelfUserPoints>()));
    container.registerSingleton<PointsRepository>((c) => PointsRepositoryImpl(
        localDatasource: c<PointsLocalDatasource>(),
        remoteDatasource: c<PointsRemoteDatasource>(),
        networkInfo: c<NetworkInfo>()));
    container.registerSingleton<PointsLocalDatasource>((c) =>
        PointsLocalDatasourceImpl(
            authLocalDataSource: c<AuthLocalDataSource>()));
    container.registerSingleton<PointsRemoteDatasource>(
        (c) => PointsRemoteDatasourceImpl(apiService: c<PointsApiService>()));
    container.registerSingleton(
        (c) => UCGetSelfUserPoints(repository: c<PointsRepository>()));
  }
}

class _$NotificationInjector extends NotificationInjector {
  void configure() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory((c) =>
        NotificationBloc(getNotifications: c<UCGetNotificationPageRequest>()));
    container.registerSingleton<NotificationRepository>((c) =>
        NotificationRepositoryImpl(
            localDatasource: c<NotificationLocalDatasource>(),
            remotDatasource: c<NotificationRemotDatasource>(),
            networkInfo: c<NetworkInfo>()));
    container.registerSingleton<NotificationLocalDatasource>(
        (c) => NotificationLocalDatasourceImpl());
    container.registerSingleton<NotificationRemotDatasource>((c) =>
        NotificationRemotDatasourceImpl(
            apiService: c<NotificationApiService>()));
    container.registerSingleton((c) =>
        UCGetNotificationPageRequest(repository: c<NotificationRepository>()));
  }
}
