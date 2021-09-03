import 'package:chopper/chopper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/config_reader/config_reader.dart';
import '../interceptors/authorized_interceptor.dart';

part 'meets_api_service.chopper.dart';

final meetsApiServiceProvider = Provider((_) => MeetsApiService.create());

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

  @Get(path: 'meetings/preferences/my/')
  Future<Response> getMyMeetingPrefrences();

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

  @Get(path: 'meetings/reschedule/availability_slots/')
  Future<Response> getRecheduleTimeSlots();

  @Get(path: 'meetings/reschedule/{meetingId}/')
  Future<Response> getRescheduleRequest(@Path() int meetingId);

  @Post(path: 'meetings/reschedule/accepted/')
  Future<Response> postConfirmRescheduleRequest(
      @Body() Map<String, dynamic> body);

  @Post(path: 'meetings/request/')
  Future<Response> postMeetingRequest(@Body() Map<String, dynamic> body);

  @Get(path: 'meetings/request/users/')
  Future<Response> getMeetingRequestUsers();

  @Get(path: 'meetings/request/{meetingRequestId}/')
  Future<Response> getMeetingRequest(@Path() int meetingRequestId);

  @Get(path: 'meetings/request/my/')
  Future<Response> getMyMeetingRequest(@Body() Map<String, dynamic> body);

  @Post(path: 'meetings/request/accepted/')
  Future<Response> postAcceptMeetingRequest(@Body() Map<String, dynamic> body);

  @Post(path: 'meetings/request/declined/')
  Future<Response> postDeclineMeetingRequest(@Body() Map<String, dynamic> body);
}
