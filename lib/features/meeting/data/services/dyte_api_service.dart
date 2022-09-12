import 'package:chopper/chopper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:worknetwork/api/interceptors/authorized_interceptor.dart';
import 'package:worknetwork/core/config_reader/config_reader.dart';

part 'dyte_api_service.chopper.dart';

final dyteApiServiceProvider =
    Provider((ref) => DyteApiService.create(ref.read));

@ChopperApi(baseUrl: "/integrations/dyte/")
abstract class DyteApiService extends ChopperService {
  static DyteApiService create(Reader read) {
    final client = ChopperClient(
      baseUrl: ConfigReader.getApiBaseUrl(),
      interceptors: [read(authInterceptorProvider)],
      services: [_$DyteApiService()],
      converter: const JsonConverter(),
    );

    return _$DyteApiService(client);
  }

  @Get(path: 'participants/{meetingId}/')
  Future<Response> getDyteCredsRequest(@Path() int meetingId);

  @Post(path: 'participant/{meetingId}/connect/', optionalBody: true)
  Future<Response> getRoomRequest(@Path() int meetingId);
}
