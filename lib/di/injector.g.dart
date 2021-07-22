// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$CoreInjector extends CoreInjector {
  @override
  void configure() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton<CustomTabs>((c) => CustomTabImpl())
      ..registerSingleton<NetworkInfo>(
          (c) => NetworkInfoImpl(connectionChecker: c<dynamic>()))
      ..registerSingleton<PushNotifications>((c) => PushNotificationsImpl())
      ..registerSingleton<LocalStorage>((c) => LocalStorageImpl())
      ..registerSingleton<Analytics>((c) => AnalyticsImpl(
          c<PushNotifications>(), c<AuthLocalDataSource>(), c<NetworkInfo>()))
      ..registerSingleton<Logger>((c) => LoggerImpl(c<SentryClient>()));
  }
}

class _$WebSocketInjector extends WebSocketInjector {
  @override
  void configure() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton((c) => WebsocketBloc(
          connectionState: c<UCWebSocketGetConnection>(),
          connect: c<UCWebsocketConnect>(),
          addToSink: c<UCWebSocketAddToSink>(),
          authBloc: c<AuthBloc>(),
          socketClose: c<UCWebSocketClose>()))
      ..registerSingleton<WebSocketRepository>((c) => WebsocketRepositoryImpl(
          localDataSource: c<WebSocketLocalDataSource>(),
          remoteDataSource: c<WebSocketRemoteDataSource>(),
          authRepository: c<AuthRepository>(),
          authLocalDataSource: c<AuthLocalDataSource>()))
      ..registerSingleton<WebSocketRemoteDataSource>(
          (c) => WebSocketRemoteDataSourceImpl())
      ..registerSingleton<WebSocketLocalDataSource>(
          (c) => WebsocketLocalDataSourceImpl())
      ..registerSingleton(
          (c) => UCWebsocketConnect(repository: c<WebSocketRepository>()))
      ..registerSingleton(
          (c) => UCWebSocketGetConnection(repository: c<WebSocketRepository>()))
      ..registerSingleton(
          (c) => UCWebSocketAddToSink(repository: c<WebSocketRepository>()))
      ..registerSingleton(
          (c) => UCWebSocketClose(repository: c<WebSocketRepository>()));
  }
}

class _$AuthInjector extends AuthInjector {
  @override
  void configure() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton((c) => AuthBloc(
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
          analytics: c<Analytics>()))
      ..registerFactory(
          (c) => ForgotPasswordBloc(passwordReset: c<UCPostPasswordReset>()))
      ..registerFactory(
          (c) => NewPasswordBloc(postNewPassword: c<UCPostNewPassword>()))
      ..registerSingleton<AuthRepository>((c) => AuthRepositoryImpl(
          c<AuthRemoteDataSource>(),
          c<AuthLocalDataSource>(),
          c<NetworkInfo>()))
      ..registerSingleton<AuthRemoteDataSource>((c) =>
          AuthRemoteDataSourceImpl(c<AuthApiService>(), c<UserApiService>()))
      ..registerSingleton<AuthLocalDataSource>((c) => AuthLocalDataSourceImpl())
      ..registerSingleton((c) => UCGetUser(c<AuthRepository>()))
      ..registerSingleton(
          (c) => UCGetAuthentication(repository: c<AuthRepository>()))
      ..registerSingleton((c) => UCGoogleAuth(repository: c<AuthRepository>()))
      ..registerSingleton((c) => UCFacebookAuth(c<AuthRepository>()))
      ..registerSingleton((c) => UCAuthWithApple(c<AuthRepository>()))
      ..registerSingleton((c) => UCLoginEmail(repository: c<AuthRepository>()))
      ..registerSingleton(
          (c) => UCAuthLinkedIn(repository: c<AuthRepository>()))
      ..registerSingleton((c) => UCRegisterEmail(c<AuthRepository>()))
      ..registerSingleton((c) => UCPatchUser(repository: c<AuthRepository>()))
      ..registerSingleton((c) => UCPostUserProfile(c<AuthRepository>()))
      ..registerSingleton((c) => UCGetUserProfile(c<AuthRepository>()))
      ..registerSingleton((c) => UCPostPasswordReset(c<AuthRepository>()))
      ..registerSingleton((c) => UCPostNewPassword(c<AuthRepository>()));
  }
}

class _$SignupInjector extends SignupInjector {
  @override
  void configure() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory((c) => ObjectivesBloc(
          getUserObjectives: c<UCGetUserObjectives>(),
          patchUser: c<UCPatchUser>(),
          analytics: c<Analytics>()))
      ..registerFactory((c) => ProfileSetupBloc(
          getUserTags: c<UCGetUserTags>(),
          postUserProfile: c<UCPostUserProfile>(),
          analytics: c<Analytics>()))
      ..registerFactory((c) => PhoneVerifyBloc(
          postNewPhoneNumber: c<UCPostNewPhoneNumber>(),
          postSmsCode: c<UCPostSmsCode>(),
          analytics: c<Analytics>()))
      ..registerFactory((c) => ProfileIntroBloc(
          getProfileIntroQuestions: c<UCGetProfileIntroQuestions>(),
          getProfileIntroCompanies: c<UCGetProfileIntroCompanies>(),
          getProfileIntroEducations: c<UCGetProfileIntroEducations>(),
          getProfileIntroExperiences: c<UCGetProfileIntroExperiences>(),
          getProfileIntroSectors: c<UCGetProfileIntroSectors>(),
          postUserProfile: c<UCPostUserProfileIntro>(),
          patchUser: c<UCPatchUser>(),
          analytics: c<Analytics>()))
      ..registerFactory((c) => ProfileBasicBloc(
          postUserProfile: c<UCPostUserProfileIntro>(),
          patchUser: c<UCPatchUser>(),
          analytics: c<Analytics>()))
      ..registerFactory((c) => ProfileTagsBloc(
          getUserTags: c<UCGetUserTags>(),
          postUserProfile: c<UCPostUserProfileIntro>(),
          analytics: c<Analytics>()))
      ..registerSingleton<SignupRepository>(
          (c) => SignupRepositoryImpl(c<SignupRemoteDatasource>()))
      ..registerSingleton<SignupRemoteDatasource>((c) =>
          SignupRemoteDatasourceImpl(c<TagsApiService>(), c<UserApiService>()))
      ..registerSingleton<ProfileIntroRemoteDatasource>(
          (c) => ProfileIntroRemoteDatasourceImpl(c<ProfileIntroApiService>()))
      ..registerSingleton<ProfileIntroRepository>((c) =>
          ProfileIntroRepositoryImpl(
              c<ProfileIntroRemoteDatasource>(), c<AuthLocalDataSource>()))
      ..registerSingleton((c) => UCGetUserObjectives(c<SignupRepository>()))
      ..registerSingleton((c) => UCGetUserTags(c<SignupRepository>()))
      ..registerSingleton((c) => UCPostNewPhoneNumber(c<SignupRepository>()))
      ..registerSingleton((c) => UCPostSmsCode(c<SignupRepository>()))
      ..registerSingleton(
          (c) => UCGetProfileIntroQuestions(c<ProfileIntroRepository>()))
      ..registerSingleton(
          (c) => UCGetProfileIntroCompanies(c<ProfileIntroRepository>()))
      ..registerSingleton(
          (c) => UCGetProfileIntroEducations(c<ProfileIntroRepository>()))
      ..registerSingleton(
          (c) => UCGetProfileIntroExperiences(c<ProfileIntroRepository>()))
      ..registerSingleton(
          (c) => UCGetProfileIntroSectors(c<ProfileIntroRepository>()))
      ..registerSingleton(
          (c) => UCPostUserProfileIntro(c<ProfileIntroRepository>()));
  }
}

class _$SocialAuthInjector extends SocialAuthInjector {
  @override
  void configure() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton(
          (c) => UCGetSocialAuthToken(repository: c<SocialAuthRepository>()))
      ..registerSingleton<SocialAuthRepository>(
          (c) => SocialAuthRepositoryImpl(c<SocialAuthRemoteDataSource>()))
      ..registerSingleton<SocialAuthRemoteDataSource>((c) =>
          SocialAuthRemoteDataSourceImpl(googleSignIn: c<GoogleSignIn>()));
  }
}

class _$CommunityInjector extends CommunityInjector {
  @override
  void configure() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory((c) => CommunityBloc(
          getPostsPage: c<UCGetPostsPage>(),
          deletePost: c<UCDeletePost>(),
          createLikePost: c<UCCreateLikePost>(),
          deleteLikePost: c<UCDeleteLikePost>()))
      ..registerFactory((c) => PostBloc(
          getPost: c<UCGetPost>(),
          getCommentsPage: c<UCGetCommentsPage>(),
          createComment: c<UCCreateCommentPost>()))
      ..registerFactory((c) => CreatePostBloc(
          createPost: c<UCCreatePost>(), analytics: c<Analytics>()))
      ..registerSingleton<CommunityRepository>((c) => CommunityRepositoryImpl(
          remoteDatasource: c<CommunityRemoteDatasource>(),
          localDatasource: c<CommunityLocalDatasource>(),
          networkInfo: c<NetworkInfo>()))
      ..registerSingleton<CommunityLocalDatasource>(
          (c) => CommunityLocalDatasourceImpl())
      ..registerSingleton<CommunityRemoteDatasource>(
          (c) => CommunityRemoteDatasourceImpl(apiService: c<PostApiService>()))
      ..registerSingleton((c) => UCGetPostsPage(c<CommunityRepository>()))
      ..registerSingleton((c) => UCGetPost(c<CommunityRepository>()))
      ..registerSingleton((c) => UCCreatePost(c<CommunityRepository>()))
      ..registerSingleton(
          (c) => UCDeletePost(repository: c<CommunityRepository>()))
      ..registerSingleton(
          (c) => UCCreateLikePost(repository: c<CommunityRepository>()))
      ..registerSingleton(
          (c) => UCDeleteLikePost(repository: c<CommunityRepository>()))
      ..registerSingleton((c) => UCGetCommentsPage(c<CommunityRepository>()))
      ..registerSingleton((c) => UCCreateCommentPost(c<CommunityRepository>()));
  }
}

class _$ChatInboxInjector extends ChatInboxInjector {
  @override
  void configure() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory((c) => ChatInboxBloc(
          websocketBloc: c<WebsocketBloc>(),
          getAllChatUsers: c<UCGetAllChatUsers>(),
          persistChatUsers: c<UCPersistChatUsers>(),
          starChatUser: c<UCSendStarChatUser>(),
          starUserChanged: c<UCReceivedStarUserChanged>()))
      ..registerFactory((c) => ChatSearchBloc(
          websocketBloc: c<WebsocketBloc>(),
          getAllChatUsers: c<UCSearchAllUsers>()))
      ..registerSingleton<ChatInboxRepository>((c) => ChatInboxRepositoryImpl(
          localDataSource: c<ChatInboxLocalDataSource>(),
          remoteDataSource: c<ChatInboxRemoteDataSource>()))
      ..registerSingleton<ChatInboxLocalDataSource>(
          (c) => ChatInboxLocalDataSourceImpl())
      ..registerSingleton<ChatInboxRemoteDataSource>((c) =>
          ChatInboxRemoteDataSourceImpl(
              webSocketRepository: c<WebSocketRepository>()))
      ..registerSingleton(
          (c) => UCGetAllChatUsers(repository: c<ChatInboxRepository>()))
      ..registerSingleton(
          (c) => UCSearchAllUsers(repository: c<ChatInboxRepository>()))
      ..registerSingleton(
          (c) => UCSendStarChatUser(repository: c<ChatInboxRepository>()))
      ..registerSingleton((c) =>
          UCReceivedStarUserChanged(repository: c<ChatInboxRepository>()))
      ..registerSingleton((c) => UCPersistChatUsers(c<ChatInboxRepository>()));
  }
}

class _$ChatInjector extends ChatInjector {
  @override
  void configure() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory((c) => ChatBloc(
          websocketBloc: c<WebsocketBloc>(),
          setChatWithUser: c<UCSetChatWithUser>(),
          sendMessage: c<UCSendChatToUser>(),
          receivedSetChatWithUser: c<UCReceivedSetChatWithUser>(),
          sendUserIsTyping: c<UCSendUserIsTyping>(),
          persistReceivedMessage: c<UCPersistReceivedMessage>(),
          sendReadUserMessage: c<UCSendReadUserMessage>()))
      ..registerSingleton<ChatRepository>((c) => ChatRepositoryImpl(
          repository: c<WebSocketRepository>(),
          localDataSource: c<ChatLocalDataSource>(),
          remoteDataSource: c<ChatRemoteDataSource>()))
      ..registerSingleton<ChatLocalDataSource>((c) => ChatLocalDataSourceImpl())
      ..registerSingleton<ChatRemoteDataSource>(
          (c) => ChatRemoteDataSourceImpl(repository: c<WebSocketRepository>()))
      ..registerSingleton(
          (c) => UCSetChatWithUser(repository: c<ChatRepository>()))
      ..registerSingleton(
          (c) => UCSendChatToUser(repository: c<ChatRepository>()))
      ..registerSingleton(
          (c) => UCReceivedSetChatWithUser(repository: c<ChatRepository>()))
      ..registerSingleton(
          (c) => UCSendUserIsTyping(repository: c<ChatRepository>()))
      ..registerSingleton(
          (c) => UCPersistReceivedMessage(repository: c<ChatRepository>()))
      ..registerSingleton(
          (c) => UCSendReadUserMessage(repository: c<ChatRepository>()));
  }
}

class _$ArticleInjector extends ArticleInjector {
  @override
  void configure() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory((c) => ArticleBloc(
          getArticles: c<UCGetArticlesPage>(),
          getArticleWebsites: c<UCGetArticleWebsites>()))
      ..registerSingleton<ArticleRepository>((c) => ArticleRepositoryImpl(
          remoteDatasource: c<ArticleRemoteDatasource>(),
          localDatasource: c<ArticleLocalDatasource>(),
          networkInfo: c<NetworkInfo>()))
      ..registerSingleton<ArticleRemoteDatasource>((c) =>
          ArticleRemoteDatasourceImpl(
              apiService: c<ArticlesApiService>(),
              tagsApiService: c<TagsApiService>()))
      ..registerSingleton<ArticleLocalDatasource>(
          (c) => ArticleLocalDatasourceImpl())
      ..registerSingleton((c) => UCGetArticlesPage(c<ArticleRepository>()))
      ..registerSingleton((c) => UCGetArticleWebsites(c<ArticleRepository>()));
  }
}

class _$VideoInjector extends VideoInjector {
  @override
  void configure() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory((c) => VideoBloc(getVideos: c<UCGetVideosListPage>()))
      ..registerFactory((c) => VideoPlayerBloc(
          getVideoItem: c<UCGetVideoItem>(),
          getVideosList: c<UCGetVideosListPage>()))
      ..registerSingleton<VideoRepository>((c) => VideoRepositoryImpl(
          networkInfo: c<NetworkInfo>(),
          localDataSource: c<VideoLocalDataSource>(),
          remoteDatasource: c<VideoRemoteDatasource>()))
      ..registerSingleton<VideoLocalDataSource>(
          (c) => VideoLocalDataSourceImpl())
      ..registerSingleton<VideoRemoteDatasource>((c) =>
          VideoRemoteDatasourceImpl(apiService: c<MasterClassApiService>()))
      ..registerSingleton(
          (c) => UCGetVideosListPage(repository: c<VideoRepository>()))
      ..registerSingleton(
          (c) => UCGetVideoItem(repository: c<VideoRepository>()));
  }
}

class _$MeetingInjector extends MeetingInjector {
  @override
  void configure() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory((c) => MeetingBloc(
          getMeetingInterests: c<UCGetMeetingInterests>(),
          getMeetingObjectives: c<UCGetMeetingObjectives>(),
          getMeetingConfig: c<UCGetMeetingConfig>(),
          getMeetingPreferences: c<UCGetMeetingPreferences>(),
          postMeetingPreferences: c<UCPostMeetingPreferences>(),
          getPastMeetingPreferences: c<UCGetPastMeetingPreferences>(),
          getMeetingsByDate: c<UCGetMeetingsByDate>(),
          retrieveMeetingDetails: c<UCRetrieveMeetingDetails>(),
          postRsvpStatus: c<UCPostRsvpStatus>(),
          getRescheduleTimeSlots: c<UCGetRescheduleTimeSlots>(),
          postRecheduleRsvpStatus: c<UCPostRecheduleRsvpStatus>(),
          getRescheduleRequest: c<UCGetRescheduleRequest>(),
          postConfirmRescheduleRequest: c<UCPostConfirmRescheduleRequest>()))
      ..registerSingleton<MeetingRepository>((c) => MeetingRepositoryImpl(
          remoteDatasource: c<MeetingRemoteDatasource>(),
          networkInfo: c<NetworkInfo>()))
      ..registerSingleton<MeetingRemoteDatasource>(
          (c) => MeetingRemoteDatasourceImpl(c<MeetsApiService>()))
      ..registerSingleton((c) => UCGetMeetingInterests(c<MeetingRepository>()))
      ..registerSingleton((c) => UCGetMeetingObjectives(c<MeetingRepository>()))
      ..registerSingleton((c) => UCGetMeetingConfig(c<MeetingRepository>()))
      ..registerSingleton(
          (c) => UCGetMeetingPreferences(c<MeetingRepository>()))
      ..registerSingleton(
          (c) => UCPostMeetingPreferences(c<MeetingRepository>()))
      ..registerSingleton(
          (c) => UCGetPastMeetingPreferences(c<MeetingRepository>()))
      ..registerSingleton((c) => UCGetMeetingsByDate(c<MeetingRepository>()))
      ..registerSingleton(
          (c) => UCRetrieveMeetingDetails(c<MeetingRepository>()))
      ..registerSingleton((c) => UCPostRsvpStatus(c<MeetingRepository>()))
      ..registerSingleton(
          (c) => UCGetRescheduleTimeSlots(c<MeetingRepository>()))
      ..registerSingleton(
          (c) => UCPostRecheduleRsvpStatus(c<MeetingRepository>()))
      ..registerSingleton((c) => UCGetRescheduleRequest(c<MeetingRepository>()))
      ..registerSingleton(
          (c) => UCPostConfirmRescheduleRequest(c<MeetingRepository>()));
  }
}

class _$PointsInjector extends PointsInjector {
  @override
  void configure() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory((c) => PointsBloc(
          getPoints: c<UCGetSelfUserPoints>(),
          getPointsFaq: c<UCGetPointsFaq>(),
          pointsRules: c<UCGetPointsRules>()))
      ..registerSingleton<PointsRepository>((c) => PointsRepositoryImpl(
          localDatasource: c<PointsLocalDatasource>(),
          remoteDatasource: c<PointsRemoteDatasource>(),
          networkInfo: c<NetworkInfo>()))
      ..registerSingleton<PointsLocalDatasource>((c) =>
          PointsLocalDatasourceImpl(
              authLocalDataSource: c<AuthLocalDataSource>()))
      ..registerSingleton<PointsRemoteDatasource>((c) =>
          PointsRemoteDatasourceImpl(
              apiService: c<PointsApiService>(),
              tagsApiService: c<TagsApiService>()))
      ..registerSingleton(
          (c) => UCGetSelfUserPoints(repository: c<PointsRepository>()))
      ..registerSingleton((c) => UCGetPointsRules(c<PointsRepository>()))
      ..registerSingleton((c) => UCGetPointsFaq(c<PointsRepository>()));
  }
}

class _$NotificationInjector extends NotificationInjector {
  @override
  void configure() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory((c) =>
          NotificationBloc(getNotifications: c<UCGetNotificationPageRequest>()))
      ..registerSingleton<NotificationRepository>((c) =>
          NotificationRepositoryImpl(
              localDatasource: c<NotificationLocalDatasource>(),
              remotDatasource: c<NotificationRemotDatasource>(),
              networkInfo: c<NetworkInfo>()))
      ..registerSingleton<NotificationLocalDatasource>(
          (c) => NotificationLocalDatasourceImpl())
      ..registerSingleton<NotificationRemotDatasource>((c) =>
          NotificationRemotDatasourceImpl(
              apiService: c<NotificationApiService>()))
      ..registerSingleton((c) => UCGetNotificationPageRequest(
          repository: c<NotificationRepository>()));
  }
}

class _$RewardsInjector extends RewardsInjector {
  @override
  void configure() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory((c) => RewardsBloc(
          getPackagesList: c<UCGetPackagesList>(),
          getPackage: c<UCGetPackage>(),
          packageRequest: c<UCPostPackageRequest>(),
          analytics: c<Analytics>()))
      ..registerSingleton<RewardsRepository>((c) => RewardsRepositoryImpl(
          networkInfo: c<NetworkInfo>(),
          localDatasource: c<RewardsLocalDatasource>(),
          remoteDatasource: c<RewardsRemoteDatasource>()))
      ..registerSingleton<RewardsLocalDatasource>(
          (c) => RewardsLocalDatasourceImpl())
      ..registerSingleton<RewardsRemoteDatasource>((c) =>
          RewardsRemoteDatasourceImpl(apiService: c<RewardsApiService>()))
      ..registerSingleton(
          (c) => UCGetPackagesList(repository: c<RewardsRepository>()))
      ..registerSingleton((c) => UCGetPackage(c<RewardsRepository>()))
      ..registerSingleton((c) => UCPostPackageRequest(c<RewardsRepository>()));
  }
}
