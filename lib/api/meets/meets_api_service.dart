import 'package:chopper/chopper.dart';

import '../../core/config_reader/config_reader.dart';
import '../interceptors/authorized_interceptor.dart';

part 'meets_api_service.chopper.dart';

@ChopperApi(baseUrl: '/resources/')
abstract class MeetsApiService extends ChopperService {
  static MeetsApiService create() {
    final client = ChopperClient(
      baseUrl: ConfigReader.getApiBaseUrl(),
      interceptors: [AuthorizedInterceptor()],
      services: [_$MeetsApiService()],
      converter: const JsonConverter(),
    );
    return _$MeetsApiService(client);
  }

  @Get(path: 'meetings/config/')
  Future<Response> getMeetingsConfig();

  @Get(path: 'meetings/preferences/')
  Future<Response> getMeetingPreferences();

  @Get(path: 'meetings/preferences/past/')
  Future<Response> getPastMeetingPreferences();

  @Post(path: 'meeting-preferences/')
  Future<Response> postMeetingPreferences(@Body() Map<String, dynamic> body);

  @Patch(path: 'meeting-preferences/{id}/')
  Future<Response> patchMeetingPreferences(
    @Path() int id,
    @Body() Map<String, dynamic> body,
  );

  @Get(path: 'meetings/meeting/')
  Future<Response> getMeetings();

  @Get(path: 'meetings/objectives/')
  Future<Response> getMeetingObjectives();

  @Get(path: 'meetings/interests/')
  Future<Response> getMeetingInterests();

  @Get(path: 'meetings/meeting/{id}/')
  Future<Response> retrieveMeetingDetail(@Path() int id);

  @Get(path: 'meetings/meeting/upcoming/')
  Future<Response> getUpcomingMeetings();

  @Get(path: 'meetings/meeting/past/')
  Future<Response> getPastMeetings();

  @Post(path: 'meetings/rsvp/confirmed/')
  Future<Response> postRsvpAttendingStatus(@Body() Map<String, dynamic> data);

  @Post(path: 'meetings/rsvp/cancelled/')
  Future<Response> postRsvpCancelledStatus(@Body() Map<String, dynamic> data);

  @Post(path: 'meetings/rsvp/reschedule/')
  Future<Response> postRsvpRescheduleStatus(@Body() Map<String, dynamic> data);
}
