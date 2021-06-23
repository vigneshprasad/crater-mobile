import 'package:auto_route/auto_route_annotations.dart';
import 'package:chopper/chopper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../api/interceptors/authorized_interceptor.dart';
import '../../../../../core/config_reader/config_reader.dart';

part 'profile_api_service.chopper.dart';

final profileApiServiceProvider = Provider((_) => ProfileApiService.create());

@ChopperApi(baseUrl: '/user/auth/')
abstract class ProfileApiService extends ChopperService {
  static ProfileApiService create() {
    final client = ChopperClient(
      baseUrl: ConfigReader.getApiBaseUrl(),
      interceptors: [AuthorizedInterceptor()],
      services: [_$ProfileApiService()],
      converter: const JsonConverter(),
    );
    return _$ProfileApiService(client);
  }

  @Get(path: 'network/')
  Future<Response> retrieveProfiles(
    @Query() String tags,
    @Query() String search,
    @Query() String page,
    @Query('page_size') String pageSize,
  );

  @Get(path: 'network/{profileId}/')
  Future<Response> retrieveProfile(@Path() String profileId);

  @Get(path: 'profile/{profileId}/connections/')
  Future<Response> getUserConnections(@Path() String profileId);
}
