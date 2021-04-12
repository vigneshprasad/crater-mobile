import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/error/exceptions.dart';
import '../../../meeting/domain/entity/meeting_config_entity.dart';
import '../../../meeting/domain/entity/meeting_interest_entity.dart';
import '../../../meeting/domain/entity/time_slot_entity.dart';
import '../../domain/entity/conversation_entity/conversation_entity.dart';
import '../../domain/entity/conversation_request_entity/conversation_request_entity.dart';
import '../../domain/entity/conversation_rtc_info_entity/conversation_rtc_info_entity.dart';
import '../../domain/entity/optin_entity/optin_entity.dart';
import '../../domain/entity/topic_entity/topic_entity.dart';
import '../services/conversation_api_service/conversation_api_service.dart';
import '../services/rtc_api_service/rtc_api_service.dart';

final conversationRemoteDatasourceProvider =
    Provider<ConversationRemoteDatasource>(
        (_) => ConversationRemoteDatasourceImpl(_.read));

abstract class ConversationRemoteDatasource {
  /// Get List of All Topcics from Remote server
  /// filter based on [parent] topic id.
  /// Throws [ServerException]
  Future<List<Topic>> getAllTopicsFromRemote(int parent);

  /// Get All Conversation for user from start to end date
  /// Throws [ServerException] on error
  Future<List<ConversationByDate>> getAllConversationsByDatefromRemote(
      DateTime start, DateTime end);

  /// Get All Conversation by id
  /// Throws [ServerException] on error
  Future<Conversation> retrieveConversationFromRemote(int id);

  /// Retrieve RoundTable RTC Info from Remote server by [tableId]
  /// Throws [ServerException]
  Future<ConversationRtcInfo> getConversationRtcInfoFromRemote(int tableId);

  /// Post Opt-in for Group Meeting to Remote Server
  /// Throws [ServerException]
  Future<Optin> postGroupOptinToRemote(
    List<MeetingInterest> interests,
    List<TimeSlot> timeslots,
    MeetingConfig config,
    Topic topic,
  );

  // Post Group request data to Remote Server
  /// Throws [ServerException]
  Future<ConversationRequest> postGroupRequestToRemote(
      ConversationRequest request);
}

class ConversationRemoteDatasourceImpl implements ConversationRemoteDatasource {
  final Reader read;

  ConversationRemoteDatasourceImpl(this.read);

  @override
  Future<List<Topic>> getAllTopicsFromRemote(int parent) async {
    final response =
        await read(conversationApiServiceProvider).getAllTopics(parent);
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.bodyString) as Iterable;
      return jsonList
          .map((topic) => Topic.fromJson(topic as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<List<ConversationByDate>> getAllConversationsByDatefromRemote(
      DateTime start, DateTime end) async {
    final response = await read(conversationApiServiceProvider)
        .getConversationsByDate(start, end);
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.bodyString) as Iterable;
      return jsonList
          .map((json) =>
              ConversationByDate.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<Conversation> retrieveConversationFromRemote(int id) async {
    final response =
        await read(conversationApiServiceProvider).retrieveConversation(id);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return Conversation.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<ConversationRtcInfo> getConversationRtcInfoFromRemote(
      int tableId) async {
    final body = {
      "channel_id": tableId,
    };
    final response = await read(rtcApiServiceProvider).getRtcInfo(body);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return ConversationRtcInfo.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<Optin> postGroupOptinToRemote(List<MeetingInterest> interests,
      List<TimeSlot> timeslots, MeetingConfig config, Topic topic) async {
    final body = {
      "interests": interests.map((interest) => interest.pk).toList(),
      "time_slots": timeslots.map((slot) => slot.pk).toList(),
      "meeting": config.pk,
      "topic": topic.id,
    };
    final response =
        await read(conversationApiServiceProvider).postConversationOptin(body);
    if (response.statusCode == 201) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return Optin.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<ConversationRequest> postGroupRequestToRemote(
      ConversationRequest request) async {
    final body = request.toJson();
    final response = await read(conversationApiServiceProvider)
        .postConversationRequest(body);
    if (response.statusCode == 201) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return ConversationRequest.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }
}
