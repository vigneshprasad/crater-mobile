import 'package:chopper/chopper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/api/interceptors/authorized_interceptor.dart';
import 'package:worknetwork/core/config_reader/config_reader.dart';

part 'devices_api_service.chopper.dart';

final devicesApiServiceProvider =
    Provider((ref) => DevicesApiService.create(ref.read));

@ChopperApi(baseUrl: '/integrations/')
abstract class DevicesApiService extends ChopperService {
  static DevicesApiService create(Reader read) {
    final client = ChopperClient(
      baseUrl: ConfigReader.getApiBaseUrl(),
      services: [_$DevicesApiService()],
      interceptors: [
        read(authInterceptorProvider),
      ],
      converter: const JsonConverter(),
    );
    return _$DevicesApiService(client);
  }

  @Post(path: 'onesignal/devices/register/')
  Future<Response> registerDevice(@Body() Map<String, dynamic> body);
}
