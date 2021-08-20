import 'package:chopper/chopper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/config_reader/config_reader.dart';

part 'otp_api_service.chopper.dart';

final otpApiServiceProvider = Provider((_) => OtpApiService.create());

@ChopperApi(baseUrl: '/crater/auth/')
abstract class OtpApiService extends ChopperService {
  static OtpApiService create() {
    final client = ChopperClient(
      baseUrl: ConfigReader.getApiBaseUrl(),
      services: [
        _$OtpApiService(),
      ],
      converter: const JsonConverter(),
      interceptors: [
        HttpLoggingInterceptor(),
      ],
    );
    return _$OtpApiService(client);
  }

  @Post(path: 'verify/')
  Future<Response> verifyOtp(@Body() Map<String, dynamic> body);

  @Post(path: 'otp/')
  Future<Response> sendOtp(@Body() Map<String, dynamic> body);
}
