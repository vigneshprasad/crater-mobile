// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meets_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$MeetsApiService extends MeetsApiService {
  _$MeetsApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = MeetsApiService;

  @override
  Future<Response<dynamic>> getMeetingsConfig() {
    final $url = '/resources/meetings/config/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMeetingPreferences() {
    final $url = '/resources/meetings/preferences/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getPastMeetingPreferences() {
    final $url = '/resources/meetings/preferences/past/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMyMeetingPrefrences() {
    final $url = '/resources/meetings/preferences/my/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postMeetingPreferences(Map<String, dynamic> body) {
    final $url = '/resources/meeting-preferences/';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> patchMeetingPreferences(
      int id, Map<String, dynamic> body) {
    final $url = '/resources/meeting-preferences/$id/';
    final $body = body;
    final $request = Request('PATCH', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMeetings() {
    final $url = '/resources/meetings/meeting/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMeetingObjectives() {
    final $url = '/resources/meetings/objectives/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMeetingInterests() {
    final $url = '/resources/meetings/interests/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> retrieveMeetingDetail(int id) {
    final $url = '/resources/meetings/meeting/$id/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getUpcomingMeetings() {
    final $url = '/resources/meetings/meeting/upcoming/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getPastMeetings() {
    final $url = '/resources/meetings/meeting/past/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postRsvpAttendingStatus(Map<String, dynamic> data) {
    final $url = '/resources/meetings/rsvp/confirmed/';
    final $body = data;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postRsvpCancelledStatus(Map<String, dynamic> data) {
    final $url = '/resources/meetings/rsvp/cancelled/';
    final $body = data;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postRsvpRescheduleStatus(
      Map<String, dynamic> data) {
    final $url = '/resources/meetings/rsvp/reschedule/';
    final $body = data;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getRecheduleTimeSlots() {
    final $url = '/resources/meetings/reschedule/availability_slots/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getRescheduleRequest(int meetingId) {
    final $url = '/resources/meetings/reschedule/$meetingId/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postConfirmRescheduleRequest(
      Map<String, dynamic> body) {
    final $url = '/resources/meetings/reschedule/accepted/';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postMeetingRequest(Map<String, dynamic> body) {
    final $url = '/resources/meetings/request/';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMeetingRequestUsers() {
    final $url = '/resources/meetings/request/users/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMeetingRequestSlots(Map<String, dynamic> body) {
    final $url = '/resources/meetings/request/slots/';
    final $params = body;
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMeetingRequest(int meetingRequestId) {
    final $url = '/resources/meetings/request/$meetingRequestId/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMyMeetingRequest(Map<String, dynamic> body) {
    final $url = '/resources/meetings/request/my/';
    final $params = body;
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postAcceptMeetingRequest(
      Map<String, dynamic> body) {
    final $url = '/resources/meetings/request/accepted/';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postDeclineMeetingRequest(
      Map<String, dynamic> body) {
    final $url = '/resources/meetings/request/declined/';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
