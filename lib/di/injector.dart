import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kiwi/kiwi.dart';
import 'package:sentry/sentry.dart';
import 'package:worknetwork/api/profile_intro/profile_intro_api_service.dart';
import 'package:worknetwork/features/auth/domain/usecase/post_new_password_usecase.dart';
import 'package:worknetwork/features/auth/presentation/bloc/new_password/new_password_bloc.dart';
import 'package:worknetwork/features/meeting/domain/usecase/get_reschedule_request_usecase.dart';
import 'package:worknetwork/features/meeting/domain/usecase/post_confirm_reschedule_request_usecase.dart';
import 'package:worknetwork/features/signup/data/datasources/profile_intro_remote_datasource.dart';
import 'package:worknetwork/features/signup/data/repository/profile_intro_repository_impl.dart';
import 'package:worknetwork/features/signup/domain/repository/profile_intro_repository.dart';
import 'package:worknetwork/features/signup/domain/usecase/get_profile_intro_companies.dart';
import 'package:worknetwork/features/signup/domain/usecase/get_profile_intro_educations.dart';
import 'package:worknetwork/features/signup/domain/usecase/get_profile_intro_experiences.dart';
import 'package:worknetwork/features/signup/domain/usecase/get_profile_intro_questions.dart';
import 'package:worknetwork/features/signup/domain/usecase/get_profile_intro_sectors.dart';
import 'package:worknetwork/features/signup/domain/usecase/post_user_profile_intro.dart';
import 'package:worknetwork/features/signup/presentation/bloc/profile_intro/profile_intro_bloc.dart';

import '../api/articles/articles_api_service.dart';
import '../api/auth/auth_api_service.dart';
import '../api/masterclass/masterclass_api_service.dart';
import '../api/meets/meets_api_service.dart';
import '../api/notifications/notifications_api_service.dart';
import '../api/points/points_api_service.dart';
import '../api/post/post_api_service.dart';
import '../api/rewards/rewards_api_service.dart';
import '../api/tags/tags_api_service.dart';
import '../api/user/user_api_service.dart';
import '../constants/app_constants.dart';
import '../core/analytics/analytics.dart';
import '../core/config_reader/config_reader.dart';
import '../core/custom_tabs/custom_tabs.dart';
import '../core/features/websocket/data/datasources/weboscket_local_datasource.dart';
import '../core/features/websocket/data/datasources/weboscket_remote_datasource.dart';
import '../core/features/websocket/data/repository/websocket_repository_impl.dart';
import '../core/features/websocket/domain/repository/websocket_repository.dart';
import '../core/features/websocket/domain/usecase/add_message_to_sink.dart';
import '../core/features/websocket/domain/usecase/close_websocket_connection.dart';
import '../core/features/websocket/domain/usecase/get_websocket_state.dart';
import '../core/features/websocket/domain/usecase/websocket_connect_usecase.dart';
import '../core/features/websocket/presentation/bloc/websocket_bloc.dart';
import '../core/local_storage/local_storage.dart';
import '../core/logger/logger.dart';
import '../core/network_info/network_info.dart';
import '../core/push_notfications/push_notifications.dart';
import '../features/article/data/datasources/article_local_datasource.dart';
import '../features/article/data/datasources/article_remote_datasource.dart';
import '../features/article/data/repository/article_repository_impl.dart';
import '../features/article/domain/repository/article_repository.dart';
import '../features/article/domain/usecase/get_article_websites_usecase.dart';
import '../features/article/domain/usecase/get_articles_page_usecase.dart';
import '../features/article/presentation/bloc/article_bloc.dart';
import '../features/auth/data/datasources/auth_local_datasource.dart';
import '../features/auth/data/datasources/auth_remote_datasource.dart';
import '../features/auth/data/repository/auth_repository_impl.dart';
import '../features/auth/domain/repository/auth_repository.dart';
import '../features/auth/domain/usecase/apple_auth_usecase.dart';
import '../features/auth/domain/usecase/facebook_auth_usecase.dart';
import '../features/auth/domain/usecase/get_authentication_usecase.dart';
import '../features/auth/domain/usecase/get_user_profile_usecase.dart';
import '../features/auth/domain/usecase/get_user_usecase.dart';
import '../features/auth/domain/usecase/google_auth_usecase.dart';
import '../features/auth/domain/usecase/linked_auth_usecase.dart';
import '../features/auth/domain/usecase/login_email_usercase.dart';
import '../features/auth/domain/usecase/patch_user_usecase.dart';
import '../features/auth/domain/usecase/post_password_reset_usecase.dart';
import '../features/auth/domain/usecase/post_user_profile_usecase.dart';
import '../features/auth/domain/usecase/register_email_usecase.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/auth/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import '../features/chat/data/datasources/chat_local_datasource.dart';
import '../features/chat/data/datasources/chat_remote_datasource.dart';
import '../features/chat/data/repository/chat_repository_impl.dart';
import '../features/chat/domain/repository/chat_repository.dart';
import '../features/chat/domain/usecases/persist_received_message.dart';
import '../features/chat/domain/usecases/received_set_chat_with_user.dart';
import '../features/chat/domain/usecases/send_message_to_user_usecase.dart';
import '../features/chat/domain/usecases/send_read_user_messaged.dart';
import '../features/chat/domain/usecases/send_user_typing.dart';
import '../features/chat/domain/usecases/set_chat_with_user_usecase.dart';
import '../features/chat/presentation/bloc/chat_bloc.dart';
import '../features/chat_inbox/data/datasources/chat_inbox_local_datasource.dart';
import '../features/chat_inbox/data/datasources/chat_inbox_remote_datasource.dart';
import '../features/chat_inbox/data/repository/chat_inbox_repository_impl.dart';
import '../features/chat_inbox/domain/repository/chat_inbox_repository.dart';
import '../features/chat_inbox/domain/usecase/get_all_chat_users_usecase.dart';
import '../features/chat_inbox/domain/usecase/persist_chat_users.dart';
import '../features/chat_inbox/domain/usecase/received_star_user_changed_usecase.dart';
import '../features/chat_inbox/domain/usecase/search_all_users_usecase.dart';
import '../features/chat_inbox/domain/usecase/send_star_chat_user_usecase.dart';
import '../features/chat_inbox/presentation/bloc/chat_inbox/chat_inbox_bloc.dart';
import '../features/chat_inbox/presentation/bloc/chat_search/chat_search_bloc.dart';
import '../features/community/data/datasources/community_local_datasource.dart';
import '../features/community/data/datasources/community_remote_datasource.dart';
import '../features/community/data/repository/community_repository_impl.dart';
import '../features/community/domain/repository/community_repository.dart';
import '../features/community/domain/usecase/create_comment_post_usercase.dart';
import '../features/community/domain/usecase/create_like_post_usecase.dart';
import '../features/community/domain/usecase/create_post_usecase.dart';
import '../features/community/domain/usecase/delete_like_post_usecase.dart';
import '../features/community/domain/usecase/delete_post_usecase.dart';
import '../features/community/domain/usecase/get_comments_page_usecase.dart';
import '../features/community/domain/usecase/get_post_usecase.dart';
import '../features/community/domain/usecase/get_posts_page_usecase.dart';
import '../features/community/presentation/bloc/community/community_bloc.dart';
import '../features/community/presentation/bloc/create_post/create_post_bloc.dart';
import '../features/community/presentation/bloc/post/post_bloc.dart';
import '../features/meeting/data/datasources/meetings_remote_datasource.dart';
import '../features/meeting/data/repository/meeting_respository_impl.dart';
import '../features/meeting/domain/repository/meeting_repository.dart';
import '../features/meeting/domain/usecase/get_meeting_interests_usecase.dart';
import '../features/meeting/domain/usecase/get_meeting_objectives_usecase.dart';
import '../features/meeting/domain/usecase/get_meeting_preferences_usecase.dart';
import '../features/meeting/domain/usecase/get_meetings_by_date_usecase.dart';
import '../features/meeting/domain/usecase/get_meetings_config_usecase.dart';
import '../features/meeting/domain/usecase/get_past_meeting_preferences_usecase.dart';
import '../features/meeting/domain/usecase/get_reschedule_request_usecase.dart';
import '../features/meeting/domain/usecase/get_reschedule_time_slots.dart';
import '../features/meeting/domain/usecase/post_confirm_reschedule_request_usecase.dart';
import '../features/meeting/domain/usecase/post_meeting_preferences_usecase.dart';
import '../features/meeting/domain/usecase/post_rechedule_rsvp_status_usecase.dart';
import '../features/meeting/domain/usecase/post_rsvp_status_update_usecase.dart';
import '../features/meeting/domain/usecase/retrieve_meeting_details_usecase.dart';
import '../features/meeting/presentation/bloc/meeting_bloc.dart';
import '../features/notification/data/datasources/notfication_local_datasource.dart';
import '../features/notification/data/datasources/notification_remote_datasource.dart';
import '../features/notification/data/repository/notification_repository_impl.dart';
import '../features/notification/domain/repository/notfication_repository.dart';
import '../features/notification/domain/usecases/get_notifications_page_usecase.dart';
import '../features/notification/presentation/bloc/notification_bloc.dart';
import '../features/points/data/datasources/points_local_datasource.dart';
import '../features/points/data/datasources/points_remote_datasource.dart';
import '../features/points/data/repository/points_repository_impl.dart';
import '../features/points/domain/repository/points_repository.dart';
import '../features/points/domain/usecases/get_points_faq_usecase.dart';
import '../features/points/domain/usecases/get_points_rule_usecase.dart';
import '../features/points/domain/usecases/get_self_user_points.dart';
import '../features/points/presentation/bloc/points_bloc.dart';
import '../features/rewards/data/datasources/rewards_local_datasource.dart';
import '../features/rewards/data/datasources/rewards_remote_datasource.dart';
import '../features/rewards/data/repository/rewards_repository_impl.dart';
import '../features/rewards/domain/repository/rewards_repository.dart';
import '../features/rewards/domain/usecases/get_package_usecase.dart';
import '../features/rewards/domain/usecases/get_packages_list_usecase.dart';
import '../features/rewards/domain/usecases/post_package_request_usecase.dart';
import '../features/rewards/presentation/bloc/rewards_bloc.dart';
import '../features/signup/data/datasources/signup_remote_datasource.dart';
import '../features/signup/data/repository/signup_repository_impl.dart';
import '../features/signup/domain/repository/signup_repository.dart';
import '../features/signup/domain/usecase/get_user_objectives.dart';
import '../features/signup/domain/usecase/get_user_tags_usecase.dart';
import '../features/signup/domain/usecase/post_new_phone_number_usecase.dart';
import '../features/signup/domain/usecase/post_sms_code_usecase.dart';
import '../features/signup/presentation/bloc/objectives/objectives_bloc.dart';
import '../features/signup/presentation/bloc/phone_verify/phone_verify_bloc.dart';
import '../features/signup/presentation/bloc/profile_setup/profile_setup_bloc.dart';
import '../features/social_auth/data/datasources/social_auth_remote_datasource.dart';
import '../features/social_auth/data/repository/social_auth_repository_impl.dart';
import '../features/social_auth/domain/repository/social_auth_repository.dart';
import '../features/social_auth/domain/usecase/get_social_auth_token.dart';
import '../features/videos/data/datasources/video_remote_datasource.dart';
import '../features/videos/data/datasources/videos_local_datasource.dart';
import '../features/videos/data/repository/video_repository_impl.dart';
import '../features/videos/domain/repository/video_repository.dart';
import '../features/videos/domain/usecase/get_video_item_usecase.dart';
import '../features/videos/domain/usecase/get_videos_list_usecase.dart';
import '../features/videos/presentation/bloc/video/video_bloc.dart';
import '../features/videos/presentation/bloc/video_player/video_player_bloc.dart';

part 'injector.g.dart';

abstract class CoreInjector {
  @Register.singleton(CustomTabs, from: CustomTabImpl)
  @Register.singleton(NetworkInfo, from: NetworkInfoImpl)
  @Register.singleton(PushNotifications, from: PushNotificationsImpl)
  @Register.singleton(LocalStorage, from: LocalStorageImpl)
  @Register.singleton(Analytics, from: AnalyticsImpl)
  @Register.singleton(Logger, from: LoggerImpl)
  void configure();
}

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
  @Register.singleton(UCWebSocketClose)
  void configure();
}

abstract class AuthInjector {
  @Register.singleton(AuthBloc)
  @Register.factory(ForgotPasswordBloc)
  @Register.factory(NewPasswordBloc)
  @Register.singleton(AuthRepository, from: AuthRepositoryImpl)
  @Register.singleton(AuthRemoteDataSource, from: AuthRemoteDataSourceImpl)
  @Register.singleton(AuthLocalDataSource, from: AuthLocalDataSourceImpl)
  @Register.singleton(UCGetUser)
  @Register.singleton(UCGetAuthentication)
  @Register.singleton(UCGoogleAuth)
  @Register.singleton(UCFacebookAuth)
  @Register.singleton(UCAuthWithApple)
  @Register.singleton(UCLoginEmail)
  @Register.singleton(UCAuthLinkedIn)
  @Register.singleton(UCRegisterEmail)
  @Register.singleton(UCPatchUser)
  @Register.singleton(UCPostUserProfile)
  @Register.singleton(UCGetUserProfile)
  @Register.singleton(UCPostPasswordReset)
  @Register.singleton(UCPostNewPassword)
  void configure();
}

abstract class SignupInjector {
  @Register.factory(ObjectivesBloc)
  @Register.factory(ProfileSetupBloc)
  @Register.factory(PhoneVerifyBloc)
  @Register.factory(ProfileIntroBloc)
  @Register.singleton(SignupRepository, from: SignupRepositoryImpl)
  @Register.singleton(SignupRemoteDatasource, from: SignupRemoteDatasourceImpl)
  @Register.singleton(ProfileIntroRemoteDatasource,
      from: ProfileIntroRemoteDatasourceImpl)
  @Register.singleton(ProfileIntroRepository, from: ProfileIntroRepositoryImpl)
  @Register.singleton(UCGetUserObjectives)
  @Register.singleton(UCGetUserTags)
  @Register.singleton(UCPostNewPhoneNumber)
  @Register.singleton(UCPostSmsCode)
  @Register.singleton(UCGetProfileIntroQuestions)
  @Register.singleton(UCGetProfileIntroCompanies)
  @Register.singleton(UCGetProfileIntroEducations)
  @Register.singleton(UCGetProfileIntroExperiences)
  @Register.singleton(UCGetProfileIntroSectors)
  @Register.singleton(UCPostUserProfileIntro)
  void configure();
}

abstract class SocialAuthInjector {
  @Register.singleton(UCGetSocialAuthToken)
  @Register.singleton(SocialAuthRepository, from: SocialAuthRepositoryImpl)
  @Register.singleton(SocialAuthRemoteDataSource,
      from: SocialAuthRemoteDataSourceImpl)
  void configure();
}

abstract class CommunityInjector {
  @Register.factory(CommunityBloc)
  @Register.factory(PostBloc)
  @Register.factory(CreatePostBloc)
  @Register.singleton(CommunityRepository, from: CommunityRepositoryImpl)
  @Register.singleton(CommunityLocalDatasource,
      from: CommunityLocalDatasourceImpl)
  @Register.singleton(CommunityRemoteDatasource,
      from: CommunityRemoteDatasourceImpl)
  @Register.singleton(UCGetPostsPage)
  @Register.singleton(UCGetPost)
  @Register.singleton(UCCreatePost)
  @Register.singleton(UCDeletePost)
  @Register.singleton(UCCreateLikePost)
  @Register.singleton(UCDeleteLikePost)
  @Register.singleton(UCGetCommentsPage)
  @Register.singleton(UCCreateCommentPost)
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
  @Register.singleton(UCSearchAllUsers)
  @Register.singleton(UCSendStarChatUser)
  @Register.singleton(UCReceivedStarUserChanged)
  @Register.singleton(UCPersistChatUsers)
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
  @Register.singleton(UCSendReadUserMessage)
  void configure();
}

abstract class ArticleInjector {
  @Register.factory(ArticleBloc)
  @Register.singleton(ArticleRepository, from: ArticleRepositoryImpl)
  @Register.singleton(ArticleRemoteDatasource,
      from: ArticleRemoteDatasourceImpl)
  @Register.singleton(ArticleLocalDatasource, from: ArticleLocalDatasourceImpl)
  @Register.singleton(UCGetArticlesPage)
  @Register.singleton(UCGetArticleWebsites)
  void configure();
}

abstract class VideoInjector {
  @Register.factory(VideoBloc)
  @Register.factory(VideoPlayerBloc)
  @Register.singleton(VideoRepository, from: VideoRepositoryImpl)
  @Register.singleton(VideoLocalDataSource, from: VideoLocalDataSourceImpl)
  @Register.singleton(VideoRemoteDatasource, from: VideoRemoteDatasourceImpl)
  @Register.singleton(UCGetVideosListPage)
  @Register.singleton(UCGetVideoItem)
  void configure();
}

abstract class MeetingInjector {
  @Register.factory(MeetingBloc)
  @Register.singleton(MeetingRepository, from: MeetingRepositoryImpl)
  @Register.singleton(MeetingRemoteDatasource,
      from: MeetingRemoteDatasourceImpl)
  @Register.singleton(UCGetMeetingInterests)
  @Register.singleton(UCGetMeetingObjectives)
  @Register.singleton(UCGetMeetingConfig)
  @Register.singleton(UCGetMeetingPreferences)
  @Register.singleton(UCPostMeetingPreferences)
  @Register.singleton(UCGetPastMeetingPreferences)
  @Register.singleton(UCGetMeetingsByDate)
  @Register.singleton(UCRetrieveMeetingDetails)
  @Register.singleton(UCPostRsvpStatus)
  @Register.singleton(UCGetRescheduleTimeSlots)
  @Register.singleton(UCPostRecheduleRsvpStatus)
  @Register.singleton(UCGetRescheduleRequest)
  @Register.singleton(UCPostConfirmRescheduleRequest)
  void configure();
}

abstract class PointsInjector {
  @Register.factory(PointsBloc)
  @Register.singleton(PointsRepository, from: PointsRepositoryImpl)
  @Register.singleton(PointsLocalDatasource, from: PointsLocalDatasourceImpl)
  @Register.singleton(PointsRemoteDatasource, from: PointsRemoteDatasourceImpl)
  @Register.singleton(UCGetSelfUserPoints)
  @Register.singleton(UCGetPointsRules)
  @Register.singleton(UCGetPointsFaq)
  void configure();
}

abstract class NotificationInjector {
  @Register.factory(NotificationBloc)
  @Register.singleton(NotificationRepository, from: NotificationRepositoryImpl)
  @Register.singleton(NotificationLocalDatasource,
      from: NotificationLocalDatasourceImpl)
  @Register.singleton(NotificationRemotDatasource,
      from: NotificationRemotDatasourceImpl)
  @Register.singleton(UCGetNotificationPageRequest)
  void configure();
}

abstract class RewardsInjector {
  @Register.factory(RewardsBloc)
  @Register.singleton(RewardsRepository, from: RewardsRepositoryImpl)
  @Register.singleton(RewardsLocalDatasource, from: RewardsLocalDatasourceImpl)
  @Register.singleton(RewardsRemoteDatasource,
      from: RewardsRemoteDatasourceImpl)
  @Register.singleton(UCGetPackagesList)
  @Register.singleton(UCGetPackage)
  @Register.singleton(UCPostPackageRequest)
  void configure();
}

class Di {
  static void setup() {
    final container = KiwiContainer();
    final coreInjector = _$CoreInjector();
    final authInjector = _$AuthInjector();
    final signupInjector = _$SignupInjector();
    final socialAuthInjector = _$SocialAuthInjector();
    final websocketInjector = _$WebSocketInjector();
    final chatInboxInjector = _$ChatInboxInjector();
    final chatInjector = _$ChatInjector();
    final articleInjector = _$ArticleInjector();
    final videoInjector = _$VideoInjector();
    final pointsInjector = _$PointsInjector();
    final notficationInjector = _$NotificationInjector();
    final communityInjector = _$CommunityInjector();
    final meetingInjector = _$MeetingInjector();
    final rewardsInjector = _$RewardsInjector();

    /// [Core]
    ///
    /// Weboscket
    coreInjector.configure();
    websocketInjector.configure();

    /// [Features]
    ///
    // Auth
    authInjector.configure();

    //Signup
    signupInjector.configure();

    // Social Auth
    socialAuthInjector.configure();

    // Community
    communityInjector.configure();

    // Chat Inbox
    chatInboxInjector.configure();

    // Chat
    chatInjector.configure();

    // Article
    articleInjector.configure();

    // Videos
    videoInjector.configure();

    // Meeting
    meetingInjector.configure();

    // Points
    pointsInjector.configure();

    // Notifications
    notficationInjector.configure();

    // Rewards
    rewardsInjector.configure();

    // Api Services
    container.registerInstance(AuthApiService.create());
    container.registerInstance(UserApiService.create());
    container.registerInstance(MasterClassApiService.create());
    container.registerInstance(PointsApiService.create());
    container.registerInstance(NotificationApiService.create());
    container.registerInstance(PostApiService.create());
    container.registerInstance(ArticlesApiService.create());
    container.registerInstance(MeetsApiService.create());
    container.registerInstance(TagsApiService.create());
    container.registerInstance(RewardsApiService.create());
    container.registerInstance(ProfileIntroApiService.create());

    // Externals
    container.registerInstance(DataConnectionChecker());
    container.registerInstance(GoogleSignIn(
      scopes: AppConstants.googleAuthScope,
    ));
    container.registerInstance(SentryClient(dsn: ConfigReader.getSentryDsn()));
    container.registerInstance(FacebookLogin());
    container.registerInstance(GlobalKey<NavigatorState>());
  }
}
