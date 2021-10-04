import 'package:chopper/chopper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../api/interceptors/authorized_interceptor.dart';
import '../../../../../core/config_reader/config_reader.dart';

part 'dyte_api_service.chopper.dart';

final dyteApiServiceProvider = Provider((_) => DyteApiService.create());

@ChopperApi(baseUrl: "/integrations/dyte/")
abstract class DyteApiService extends ChopperService {
  static DyteApiService create() {
    final client = ChopperClient(
      baseUrl: ConfigReader.getApiBaseUrl(),
      interceptors: [AuthorizedInterceptor()],
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
