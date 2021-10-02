import 'package:chopper/chopper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/config_reader/config_reader.dart';

part 'connection_api_service.chopper.dart';

final connectionApiServiceProvider =
    Provider((_) => ConnectionApiService.create());

@ChopperApi(baseUrl: '/crater/')
abstract class ConnectionApiService extends ChopperService {
  static ConnectionApiService create() {
    final client = ChopperClient(
      baseUrl: ConfigReader.getApiBaseUrl(),
      services: [
        _$ConnectionApiService(),
      ],
      converter: const JsonConverter(),
      interceptors: [
        HttpLoggingInterceptor(),
      ],
    );
    return _$ConnectionApiService(client);
  }

  @Get(path: 'creator/{id}')
  Future<Response> getCreator(@Path() String id);

  @Get(path: 'creator/')
  Future<Response> getCreators(@QueryMap() Map<String, dynamic> body);
}
