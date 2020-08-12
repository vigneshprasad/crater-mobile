import 'package:chopper/chopper.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:worknetwork/api/interceptors/authorized_interceptor.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/models/meeting/meeting_model.dart';

part 'meets_api_service.chopper.dart';
part 'meets_api_service.g.dart';

@JsonSerializable()
class MeetingsResponse {
  final int pk;

  final String title;

  @JsonKey(name: 'week_start_date')
  final String weekStartDate;

  @JsonKey(name: 'week_end_date')
  final String weekEndDate;

  @JsonKey(name: 'is_registration_open')
  final bool isRegistrationOpen;

  @JsonKey(name: 'is_active')
  final bool isActive;

  @JsonKey(name: 'available_time_slots')
  final Map<String, List<TimeSlot>> availableTimeSlots;

  final List<MeetingObjective> objectives;

  final List<Interest> interests;

  @JsonKey(name: 'user_preferences', nullable: true)
  final UserMeetingPreference userPreferences;

  MeetingsResponse({
    this.pk,
    this.title,
    this.weekStartDate,
    this.weekEndDate,
    this.isRegistrationOpen,
    this.isActive,
    this.availableTimeSlots,
    this.objectives,
    this.interests,
    this.userPreferences,
  });

  factory MeetingsResponse.fromJson(Map<String, dynamic> json) =>
      _$MeetingsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MeetingsResponseToJson(this);
}

@ChopperApi(baseUrl: '/resources/')
abstract class MeetsApiService extends ChopperService {
  static MeetsApiService create() {
    final client = ChopperClient(
      baseUrl: AppConstants.apiBaseUrl,
      interceptors: [AuthorizedInterceptor()],
      services: [_$MeetsApiService()],
    );
    return _$MeetsApiService(client);
  }

  @Get(path: 'meetings/')
  Future<Response> getMeetings();

  @Post(path: 'meeting-preferences/')
  Future<Response> postMeetingPreferences();

  @Patch(path: 'meeting-preferences/{id}/')
  Future<Response> patchMeetingPreferences(@Path() int id);
}
