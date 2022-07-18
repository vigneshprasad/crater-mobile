import 'package:chopper/chopper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:worknetwork/api/interceptors/authorized_interceptor.dart';
import 'package:worknetwork/core/config_reader/config_reader.dart';

part 'profile_api_service.chopper.dart';

final profileApiServiceProvider =
    Provider((ref) => ProfileApiService.create(ref.read));

@ChopperApi(baseUrl: '/user/auth/')
abstract class ProfileApiService extends ChopperService {
  static ProfileApiService create(Reader read) {
    final client = ChopperClient(
      baseUrl: ConfigReader.getApiBaseUrl(),
      interceptors: [read(authInterceptorProvider)],
      services: [_$ProfileApiService()],
      converter: const JsonConverter(),
    );
    return _$ProfileApiService(client);
  }

  @Get(path: 'network/')
  Future<Response> retrieveProfiles(
    @Query('new_tag') String tags,
    @Query() String search,
    @Query() int page,
    @Query('page_size') int pageSize,
  );

  @Get(path: 'network/{userId}/')
  Future<Response> retrieveUserConnections(
    @Query() String tags,
    @Query() String search,
    @Query() int page,
    @Query('page_size') int pageSize,
    @Path() String profileId,
  );

  @Get(path: 'network/')
  Future<Response> retrieveAllProfiles(
    @Query() String search,
    @Query() int page,
    @Query('page_size') int pageSize,
  );

  @Get(path: 'network/{profileId}/')
  Future<Response> retrieveProfile(@Path() String profileId);

  @Get(path: 'profile/{profileId}/connections/')
  Future<Response> getUserConnections(@Path() String profileId);
}
