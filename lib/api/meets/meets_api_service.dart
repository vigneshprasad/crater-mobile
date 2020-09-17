import 'package:chopper/chopper.dart';

import 'package:worknetwork/api/interceptors/authorized_interceptor.dart';
import 'package:worknetwork/constants/app_constants.dart';

part 'meets_api_service.chopper.dart';

@ChopperApi(baseUrl: '/resources/')
abstract class MeetsApiService extends ChopperService {
  static MeetsApiService create() {
    final client = ChopperClient(
      baseUrl: AppConstants.apiBaseUrl,
      interceptors: [AuthorizedInterceptor()],
      services: [_$MeetsApiService()],
      converter: const JsonConverter(),
    );
    return _$MeetsApiService(client);
  }

  @Get(path: 'meetings/')
  Future<Response> getMeetings();

  @Post(path: 'meeting-preferences/')
  Future<Response> postMeetingPreferences(@Body() Map<String, dynamic> body);

  @Patch(path: 'meeting-preferences/{id}/')
  Future<Response> patchMeetingPreferences(@Path() int id);
}
