import 'package:chopper/chopper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../api/interceptors/authorized_interceptor.dart';
import '../../../../../core/config_reader/config_reader.dart';

part 'conversation_api_service.chopper.dart';

final conversationApiServiceProvider =
    Provider((_) => ConversationApiService.create());

@ChopperApi(baseUrl: '/groups/')
abstract class ConversationApiService extends ChopperService {
  static ConversationApiService create() {
    final client = ChopperClient(
      baseUrl: ConfigReader.getApiBaseUrl(),
      interceptors: [AuthorizedInterceptor()],
      services: [_$ConversationApiService()],
      converter: const JsonConverter(),
    );

    return _$ConversationApiService(client);
  }

  @Get(path: 'conversation/calendar/')
  Future<Response> getConversationsByDate(
      @Query() DateTime start, @Query() DateTime end);

  @Get(path: 'conversation/calendar/my/')
  Future<Response> getMyConversationsByDate(
      @Query() DateTime start, @Query() DateTime end);

  @Get(path: 'topic/')
  Future<Response> getAllTopics(@Query() int? parent);

  @Get(path: 'topic/ama/')
  Future<Response> getAllAMATopics();

  @Get(path: 'topic/articles/')
  Future<Response> getAllArticleTopics();

  @Get(path: 'topic/for_groups/')
  Future<Response> getAllRootTopicsForConversations();

  @Get(path: 'groups/')
  Future<Response> getConversations(@Body() Map<String, dynamic> body);

  @Get(path: 'groups/my/')
  Future<Response> getMyConversations(@Body() Map<String, dynamic> body);

  @Get(path: 'groups/{id}/')
  Future<Response> retrieveConversation(@Path() int id);

  @Post(path: 'groups/instant/')
  Future<Response> postInstantConversation(@Body() Map<String, dynamic> body);

  @Get(path: 'groups/instant_time_slots/')
  Future<Response> getInstantConversationTimeSlots();

  @Get(path: 'conversations/chatreactions/')
  Future<Response> getChatReactions();

  @Get(path: 'conversations/chatreactions/{id}')
  Future<Response> getChatReactionDetail(@Path() String id);

  @Post(path: 'optin/')
  Future<Response> postConversationOptin(@Body() Map<String, dynamic> body);

  @Get(path: 'optin/')
  Future<Response> getAllMyOptins();

  @Get(path: 'optin/by_date/')
  Future<Response> getOptinsByDate();

  @Post(path: 'requests/')
  Future<Response> postConversationRequest(@Body() Map<String, dynamic> body);

  @Post(path: 'topic/suggest/')
  Future<Response> postTopicSuggestionRequest(
      @Body() Map<String, dynamic> body);

  @Get(path: 'public/conversations/webinars/live')
  Future<Response> getLiveClubs(@Query() String? host);

  @Get(path: 'public/conversations/webinars/upcoming')
  Future<Response> getUpcomingClubs(@Query() String? host);

  @Get(path: 'public/conversations/webinars/past')
  Future<Response> getPastClubs(@Query() String? host, @Query() int? page, @Query('page_size') int? pageSize);

  @Get(path: 'public/conversations/webinars/featured')
  Future<Response> getFeaturedClubs(@Query() String? host, @Query() int? page, @Query('page_size') int? pageSize);

  @Get(path: 'conversations/webinars/{id}/')
  Future<Response> retrieveWebinar(@Path() int id);

  @Get(path: 'public/conversations/series/')
  Future<Response> getSeries(@Query() int? page, @Query('page_size') int? pageSize);

  @Get(path: 'public/conversations/series/{id}')
  Future<Response> getSeriesDetails(@Path() int id);

  @Post(path: 'conversations/series/requests/')
  Future<Response> postSeriesRequest(@Body() Map<String, dynamic> body);

}
