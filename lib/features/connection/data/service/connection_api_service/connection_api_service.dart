import 'package:chopper/chopper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/api/interceptors/authorized_interceptor.dart';
import 'package:worknetwork/core/config_reader/config_reader.dart';

part 'connection_api_service.chopper.dart';

final connectionApiServiceProvider =
    Provider((_) => ConnectionApiService.create());

@ChopperApi(baseUrl: '/crater/')
abstract class ConnectionApiService extends ChopperService {

  static ConnectionApiService create() {
    final client = ChopperClient(
      baseUrl: ConfigReader.getApiBaseUrl(),
      interceptors: [
        AuthorizedInterceptor(), 
        HttpLoggingInterceptor(),
      ],
      services: [_$ConnectionApiService()],
      converter: const JsonConverter(),
    );

    return _$ConnectionApiService(client);
  }

  @Get(path: 'creator/{id}')
  Future<Response> getCreator(@Path() int id);

  @Get(path: 'creator/')
  Future<Response> getCreators(@QueryMap() Map<String, dynamic> body);

  @Get(path: 'community/members/')
  Future<Response> getCommunityMembers(@QueryMap() Map<String, dynamic> body);

  @Post(path: 'followers/follow/')
  Future<Response> followCreator(@Body() Map<String, dynamic> body);
}
