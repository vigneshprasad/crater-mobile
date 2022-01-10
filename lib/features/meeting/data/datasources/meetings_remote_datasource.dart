import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/meeting/data/models/meeting_request_model.dart';
import 'package:worknetwork/features/meeting/data/models/requests_by_date_model.dart';
import 'package:worknetwork/features/meeting/domain/entity/meeting_request_entity.dart';
import 'package:worknetwork/features/meeting/domain/entity/requests_by_date_entity.dart';
import 'package:worknetwork/features/profile/domain/entity/profile_entity/profile_entity.dart';

import '../../../../api/meets/meets_api_service.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entity/meeting_config_entity.dart';
import '../../domain/entity/meeting_entity.dart';
import '../../domain/entity/meeting_interest_entity.dart';
import '../../domain/entity/meeting_objective_entity.dart';
import '../../domain/entity/meeting_rsvp_entity.dart';
import '../../domain/entity/meetings_by_date_entity.dart';
import '../../domain/entity/reschedule_request_entity.dart';
import '../../domain/entity/time_slot_entity.dart';
import '../../domain/entity/user_meeting_preference_entity.dart';
import '../models/meeting_config_model.dart';
import '../models/meeting_interest_model.dart';
import '../models/meeting_model.dart';
import '../models/meeting_objective_model.dart';
import '../models/meeting_rsvp_model.dart';
import '../models/meetings_by_date_model.dart';
import '../models/reschedule_request_model.dart';
import '../models/user_meeting_preference_model.dart';

abstract class MeetingRemoteDatasource {
  Future<MeetingConfig?> getMeetingConfigFromRemote();
  Future<UserMeetingPreference> postUserMeetingPreferencesToRemote(
    List<MeetingInterest> interests,
    MeetingConfig config,
    List<MeetingObjective> objectives,
    List<TimeSlot> timeSlots,
  );
  Future<List<Meeting>> getMeetingsFromRemote();
  Future<List<MeetingObjective>> getMeetingObjectivesFromRemote();
  Future<List<MeetingInterest>> getMeetingInterestFromRemote();
  Future<UserMeetingPreference?> getMeetingPreferenceFromRemote();
  Future<UserMeetingPreference?> getPastMeetingPreferenceFromRemote();
  Future<List<MeetingsByDate>> getMeetingsByDateFromRemote({bool? past});
  Future<Meeting> retrieveMeetingDetailFromRemote(int meetingId);
  Future<MeetingRsvp> postRsvpStatusToRemote(
    MeetingRsvpStatus status,
    int meetingId,
  );
  Future<List<List<DateTime>>> getRescheduleSlotsFromRemote();
  Future<RescheduleRequest> postRecheduleRsvpStatusToRemote(
    int oldMeeting,
    String requestedBy,
    List<DateTime> timeSlots,
  );
  Future<RescheduleRequest> getRescheduleRequestFromRemote(int meetingId);
  Future<bool> postConfirmRescheduleRequestToRemote(
      DateTime timeSlot, int rescheduleRequest);
  Future<bool> postMeetingRequestToRemote(
      List<DateTime> timeSlot, String requestedBy, String requestedTo);
  Future<List<Profile>> getMeetingRequestUsersFromRemote({String? tag});
  Future<List<List<DateTime>>> getMeetingRequestSlotsFromRemote(
      String requestedTo);
  Future<MeetingRequest> getMeetingRequestFromRemote(int meetingRequestId);
  Future<List<RequestsByDate>> getMyMeetingRequestFromRemote();

  Future<bool> postAcceptMeetingRequestToRemote(
      int meetingRequestId, DateTime timeSlot);
  Future<bool> postDeclineMeetingRequestToRemote(int meetingRequestId);
}

final meetingRemoteDatasourceProvider =
    Provider<MeetingRemoteDatasource>((ref) {
  final apiService = ref.read(meetsApiServiceProvider);
  return MeetingRemoteDatasourceImpl(apiService);
});

class MeetingRemoteDatasourceImpl implements MeetingRemoteDatasource {
  final MeetsApiService apiService;

  MeetingRemoteDatasourceImpl(this.apiService);

  @override
  Future<MeetingConfig?> getMeetingConfigFromRemote() async {
    final response = await apiService.getMeetingsConfig();
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return MeetingConfigModel.fromJson(json);
    } else if (response.statusCode == 204) {
      return null;
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<UserMeetingPreference> postUserMeetingPreferencesToRemote(
    List<MeetingInterest> interests,
    MeetingConfig config,
    List<MeetingObjective> objectives,
    List<TimeSlot> timeSlots,
  ) async {
    final body = {
      "meeting": config.pk,
      "interests": interests.map((e) => e.pk).toList(),
      "objectives": objectives.map((e) => e.pk).toList(),
      "time_slots": timeSlots.map((e) => e.pk).toList(),
    };
    final response = await apiService.postMeetingPreferences(body);
    if (response.statusCode == 201) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return UserMeetingPreferenceModel.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<List<Meeting>> getMeetingsFromRemote() async {
    final response = await apiService.getMeetings();
    if (response.statusCode == 200) {
      final Iterable json = jsonDecode(response.bodyString) as Iterable;
      return json
          .map((item) => MeetingModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<List<MeetingInterest>> getMeetingInterestFromRemote() async {
    final response = await apiService.getMeetingInterests();
    if (response.statusCode == 200) {
      final Iterable json = jsonDecode(response.bodyString) as Iterable;
      return json
          .map((interest) =>
              MeetingInterestModel.fromJson(interest as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<List<MeetingObjective>> getMeetingObjectivesFromRemote() async {
    final response = await apiService.getMeetingObjectives();
    if (response.statusCode == 200) {
      final Iterable json = jsonDecode(response.bodyString) as Iterable;
      return json
          .map((objective) =>
              MeetingObjectiveModel.fromJson(objective as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<UserMeetingPreference?> getMeetingPreferenceFromRemote() async {
    final response = await apiService.getMeetingPreferences();
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return UserMeetingPreferenceModel.fromJson(json);
    } else if (response.statusCode == 204) {
      return null;
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<UserMeetingPreference?> getPastMeetingPreferenceFromRemote() async {
    final response = await apiService.getPastMeetingPreferences();
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return UserMeetingPreferenceModel.fromJson(json);
    } else if (response.statusCode == 204) {
      return null;
    } else {
      throw ServerException(response.error);
    }
  }

  Future<Response<dynamic>> _getMeetingsData({bool? past}) {
    if (past == true) {
      return apiService.getPastMeetings();
    } else {
      return apiService.getUpcomingMeetings();
    }
  }

  @override
  Future<List<MeetingsByDate>> getMeetingsByDateFromRemote({bool? past}) async {
    final response = await _getMeetingsData(past: past);
    if (response.statusCode == 200) {
      final Iterable json = jsonDecode(response.bodyString) as Iterable;
      return json
          .map((data) =>
              MeetingsByDateModel.fromJson(data as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<Meeting> retrieveMeetingDetailFromRemote(int meetingId) async {
    final response = await apiService.retrieveMeetingDetail(meetingId);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;

      return MeetingModel.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<MeetingRsvp> postRsvpStatusToRemote(
      MeetingRsvpStatus status, int meetingId) async {
    final response = await _postRsvpStatus(status, meetingId);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return MeetingRsvpModel.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }

  Future<Response> _postRsvpStatus(MeetingRsvpStatus status, int meetingId) {
    final data = {
      'meeting': meetingId,
    };
    if (status == MeetingRsvpStatus.attending) {
      return apiService.postRsvpAttendingStatus(data);
    } else if (status == MeetingRsvpStatus.notAttending) {
      return apiService.postRsvpCancelledStatus(data);
    } else {
      throw ServerException('Incorrect rsvp status');
    }
  }

  @override
  Future<List<List<DateTime>>> getRescheduleSlotsFromRemote() async {
    final response = await apiService.getRecheduleTimeSlots();
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Iterable;
      return json.map((slots) {
        final slotsList = slots as Iterable;
        return slotsList.map((slot) => DateTime.parse(slot as String)).toList();
      }).toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<RescheduleRequest> postRecheduleRsvpStatusToRemote(
      int oldMeeting, String requestedBy, List<DateTime> timeSlots) async {
    final body = {
      'old_meeting': oldMeeting,
      'requested_by': requestedBy,
      'time_slots': timeSlots.map((slot) => slot.toIso8601String()).toList(),
    };

    final response = await apiService.postRsvpRescheduleStatus(body);
    if (response.statusCode == 201) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return RescheduleRequestModel.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<RescheduleRequest> getRescheduleRequestFromRemote(
      int meetingId) async {
    final response = await apiService.getRescheduleRequest(meetingId);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return RescheduleRequestModel.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<bool> postConfirmRescheduleRequestToRemote(
      DateTime timeSlot, int rescheduleRequest) async {
    final body = {
      'time_slot': timeSlot.toIso8601String(),
      'reschedule_request': rescheduleRequest,
    };
    final response = await apiService.postConfirmRescheduleRequest(body);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw ServerException(response.body);
    }
  }

  @override
  Future<bool> postMeetingRequestToRemote(
      List<DateTime> timeSlot, String requestedBy, String requestedTo) async {
    final body = {
      'time_slots': timeSlot.map((e) => e.toIso8601String()).toList(),
      'requested_by': requestedBy,
      'requested_to': requestedTo,
    };
    final response = await apiService.postMeetingRequest(body);
    if (response.statusCode == 201) {
      return true;
    } else {
      throw ServerException(response.body);
    }
  }

  @override
  Future<List<Profile>> getMeetingRequestUsersFromRemote({String? tag}) async {
    final response = await apiService.getMeetingRequestUsers({'tags': tag});
    if (response.statusCode == 200) {
      if (response.bodyString == "[]") {
        return List.empty();
      }
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      final jsonList = json['results'] as List;
      return jsonList
          .map((json) => Profile.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<List<List<DateTime>>> getMeetingRequestSlotsFromRemote(
      String requestedTo) async {
    final body = {'requested_to': requestedTo};
    final response = await apiService.getMeetingRequestSlots(body);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as List;
      return json.map((dates) {
        final d = dates as List;
        return dates.map((times) {
          return DateTime.tryParse(times as String)!;
        }).toList();
      }).toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<MeetingRequest> getMeetingRequestFromRemote(
      int meetingRequestId) async {
    final response = await apiService.getMeetingRequest(meetingRequestId);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return MeetingRequestModel.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<List<RequestsByDate>> getMyMeetingRequestFromRemote() async {
    final body = {'status': 'pending_approval'};
    final response = await apiService.getMyMeetingRequest(body);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as List;

      return json
          .map((json) =>
              RequestsByDateModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<bool> postAcceptMeetingRequestToRemote(
      int meetingRequestId, DateTime timeSlot) async {
    final body = {
      'meeting_request': meetingRequestId,
      'time_slot': timeSlot.toIso8601String(),
    };
    final response = await apiService.postAcceptMeetingRequest(body);
    if (response.statusCode == 201) {
      return true;
    } else {
      throw ServerException(response.bodyString);
    }
  }

  @override
  Future<bool> postDeclineMeetingRequestToRemote(int meetingRequestId) async {
    final body = {'meeting_request': meetingRequestId};
    final response = await apiService.postDeclineMeetingRequest(body);
    if (response.statusCode == 201) {
      return true;
    } else {
      throw ServerException(response.bodyString);
    }
  }
}
