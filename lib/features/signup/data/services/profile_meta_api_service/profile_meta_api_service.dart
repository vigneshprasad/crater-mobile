import 'package:chopper/chopper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/api/interceptors/authorized_interceptor.dart';
import 'package:worknetwork/core/config_reader/config_reader.dart';

part 'profile_meta_api_service.chopper.dart';

final profileMetaApiServiceProvider =
    Provider((_) => ProfileMetaApiService.create());

@ChopperApi(baseUrl: '/user/meta/')
abstract class ProfileMetaApiService extends ChopperService {
  static ProfileMetaApiService create() {
    final client = ChopperClient(
      baseUrl: ConfigReader.getApiBaseUrl(),
      services: [
        _$ProfileMetaApiService(),
      ],
      converter: const JsonConverter(),
      interceptors: [
        AuthorizedInterceptor(),
        HttpLoggingInterceptor(),
      ],
    );
    return _$ProfileMetaApiService(client);
  }

  @Get(path: "profile/{id}/tag_extra_info/")
  Future<Response> getProfileExtraFormMeta(@Path() int id);
}
