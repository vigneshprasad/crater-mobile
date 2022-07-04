import 'package:chopper/chopper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/config_reader/config_reader.dart';
import '../interceptors/authorized_interceptor.dart';

part 'devices_api_service.chopper.dart';

final devicesApiServiceProvider = Provider((_) => DevicesApiService.create());

@ChopperApi(baseUrl: '/integrations/')
abstract class DevicesApiService extends ChopperService {
  static DevicesApiService create() {
    final client = ChopperClient(
      baseUrl: ConfigReader.getApiBaseUrl(),
      services: [_$DevicesApiService()],
      interceptors: [AuthorizedInterceptor()],
      converter: const JsonConverter(),
    );
    return _$DevicesApiService(client);
  }

  @Post(path: 'onesignal/devices/register/')
  Future<Response> registerDevice(@Body() Map<String, dynamic> body);
}
