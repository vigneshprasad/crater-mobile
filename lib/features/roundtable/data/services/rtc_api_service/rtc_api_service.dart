import 'package:chopper/chopper.dart';
import 'package:hooks_riverpod/all.dart';

import '../../../../../api/interceptors/authorized_interceptor.dart';
import '../../../../../core/config_reader/config_reader.dart';

part 'rtc_api_service.chopper.dart';

final rtcApiServiceProvider = Provider((_) => RtcApiService.create());

@ChopperApi(baseUrl: "/integrations/agora/")
abstract class RtcApiService extends ChopperService {
  static RtcApiService create() {
    final client = ChopperClient(
      baseUrl: ConfigReader.getApiBaseUrl(),
      interceptors: [AuthorizedInterceptor()],
      services: [_$RtcApiService()],
      converter: const JsonConverter(),
    );

    return _$RtcApiService(client);
  }

  @Get(path: "token/")
  Future<Response> getRtcInfo(@Body() Map<String, dynamic> body);

  @Get(path: "user/{uid}")
  Future<Response> getRtcUserInfo(@Path() String uid);
}
