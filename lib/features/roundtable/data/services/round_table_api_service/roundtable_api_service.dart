import 'package:chopper/chopper.dart';
import 'package:hooks_riverpod/all.dart';

import '../../../../../api/interceptors/authorized_interceptor.dart';
import '../../../../../core/config_reader/config_reader.dart';

part 'roundtable_api_service.chopper.dart';

final roundTableApiServiceProvider =
    Provider<RoundTableApiService>((_) => RoundTableApiService.create());

@ChopperApi(baseUrl: '/groups/')
abstract class RoundTableApiService extends ChopperService {
  static RoundTableApiService create() {
    final client = ChopperClient(
      baseUrl: ConfigReader.getApiBaseUrl(),
      interceptors: [AuthorizedInterceptor()],
      services: [_$RoundTableApiService()],
      converter: const JsonConverter(),
    );

    return _$RoundTableApiService(client);
  }

  @Get(path: 'topic/')
  Future<Response> getAllTopics(@Query() int parent);

  @Get(path: 'topic/{id}/root/')
  Future<Response> getRootTopic(@Path() int id);

  @Get(path: 'topic/')
  Future<Response> getAllCategoriesForTables();

  @Get(path: 'topic/my_groups/')
  Future<Response> getUserTableCategories();

  @Get(path: 'category/all/')
  Future<Response> getAllCategories();

  @Get(path: 'groups/')
  Future<Response> getRoundTables();

  @Get(path: 'groups/{id}/')
  Future<Response> retrieveRoundTable(@Path() int id);

  @Get(path: 'groups/my/')
  Future<Response> getMyRoundTables();

  @Get(path: 'groups/')
  Future<Response> getAllRoundTables();

  @Get(path: 'groups/agendas/{categoryId}')
  Future<Response> getAgendaByCategory(@Path() int categoryId);

  @Post(path: 'optin/')
  Future<Response> postGroupOptin(@Body() Map<String, dynamic> body);

  @Get(path: 'optin/')
  Future<Response> getAlMyOptins();

  @Post(path: 'requests/')
  Future<Response> postGroupRequest(@Body() Map<String, dynamic> body);
}
