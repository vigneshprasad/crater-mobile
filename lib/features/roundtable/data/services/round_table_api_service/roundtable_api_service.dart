import 'package:chopper/chopper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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

  @Get(path: 'topic/for_groups/')
  Future<Response> getAllRootTopicsForGroups();

  @Get(path: 'groups/')
  Future<Response> getRoundTables(@Body() Map<String, dynamic> body);

  @Get(path: 'groups/{id}/')
  Future<Response> retrieveRoundTable(@Path() int id);

  @Get(path: 'groups/my/')
  Future<Response> getMyRoundTables(@Body() Map<String, dynamic> body);

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
