import 'package:chopper/chopper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/api/interceptors/authorized_interceptor.dart';
import 'package:worknetwork/core/config_reader/config_reader.dart';

part 'profile_api_service.chopper.dart';

final profileApiServiceProvider =
    Provider<ProfileApiService>((ref) => ProfileApiService.create(ref.read));

@ChopperApi(baseUrl: '/user/auth/')
abstract class ProfileApiService extends ChopperService {
  static ProfileApiService create(Reader read) {
    final client = ChopperClient(
      baseUrl: ConfigReader.getApiBaseUrl(),
      services: [
        _$ProfileApiService(),
      ],
      converter: const JsonConverter(),
      interceptors: [
        read(authInterceptorProvider),
        HttpLoggingInterceptor(),
      ],
    );
    return _$ProfileApiService(client);
  }

  @Post(path: "profile/")
  Future<Response> postUserProfile(@Body() Map<String, dynamic> body);
}
