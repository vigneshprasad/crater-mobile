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

  @Get(path: 'category/')
  Future<Response> getAllCategories();

  @Get(path: 'category/my_groups/')
  Future<Response> getUserTableCategories();

  @Get(path: 'category/upcoming/')
  Future<Response> getUpcomingTableCategories();

  @Get(path: 'groups/meta/')
  Future<Response> getRoundTablesMeta();

  @Get(path: 'groups/')
  Future<Response> getRoundTables();

  @Get(path: 'groups/{id}/')
  Future<Response> retrieveRoundTable(@Path() int id);

  @Get(path: 'groups/my_groups/')
  Future<Response> getMyRoundTables();
}
