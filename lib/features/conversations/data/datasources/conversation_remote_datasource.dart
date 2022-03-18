import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/connection/data/models/creator_response.dart';
import 'package:worknetwork/features/conversations/domain/entity/chat_reaction_entity/chat_reaction_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/series_entity/series_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/series_request_entity/series_request_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/webinar_entity/webinar_entity.dart';

import '../../../../core/error/exceptions.dart';
import '../../../meeting/domain/entity/meeting_config_entity.dart';
import '../../../meeting/domain/entity/meeting_interest_entity.dart';
import '../../../meeting/domain/entity/time_slot_entity.dart';
import '../../domain/entity/conversation_entity/conversation_entity.dart';
import '../../domain/entity/conversation_request_entity/conversation_request_entity.dart';
import '../../domain/entity/conversation_rtc_info_entity/conversation_rtc_info_entity.dart';
import '../../domain/entity/optin_entity/optin_entity.dart';
import '../../domain/entity/topic_entity/topic_entity.dart';
import '../models/conversation_exceptions/conversation_exceptions.dart';
import '../services/conversation_api_service/conversation_api_service.dart';
import '../services/rtc_api_service/rtc_api_service.dart';

final conversationRemoteDatasourceProvider =
    Provider<ConversationRemoteDatasource>(
        (_) => ConversationRemoteDatasourceImpl(_.read));

abstract class ConversationRemoteDatasource {
  /// Get List of All Topcics from Remote server
  /// filter based on [parent] topic id.
  /// Throws [ServerException]
  Future<List<Topic>> getAllTopicsFromRemote(int? parent);

  /// Get List of All AMA Topics from Remote server
  /// Throws [ServerException]
  Future<List<Topic>> getAllAMATopicsFromRemote();

  /// Get List of All Topcics with Articles from Remote server
  /// filter based on [parent] topic id.
  /// Throws [ServerException]
  Future<List<Topic>> getAllArticleTopicsFromRemote();

  /// Get All Conversation for user from start to end date
  /// Throws [ServerException] on error
  Future<List<ConversationByDate>> getAllConversationsByDatefromRemote(
      DateTime start, DateTime end);

  /// Get My Conversation for user from start to end date
  /// Throws [ServerException] on error
  Future<List<ConversationByDate>> getMyConversationsByDatefromRemote(
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

  Future<ConversationRequest> getWebinarRSVPRequestFromRemote(
      int webinarId);

  // Post Group request data to Remote Server
  /// Throws [ServerException]
  Future<ConversationRequest> postGroupRequestToRemote(
      ConversationRequest request);

  // Get All Options for user for future week
  /// Throws [ServerException]
  Future<List<Optin>> getAllConversationOptinsFromRemote();

  // Get All Options for user for future week by date
  /// Throws [ServerException]
  Future<List<OptinsByDate>> getAllConversationOptinsByDateFromRemote();

  // Get List of DateTimes for instant conversations
  /// Throws [ServerException]
  Future<List<DateTime>> getInstantConversationTimeSlotsFromRemote();

  // Post an instant conversation to remote server
  /// Throws [ServerException]
  Future<Conversation> postCreateInstantConversationToRemote(
      Conversation conversation);

  // Post an instant conversation to remote server
  /// Throws [ServerException]
  Future<Topic> postTopicSuggestionToRemote(Topic topic);

  /// Get All Conversation for user from start to end date
  /// Throws [ServerException] on error
  Future<List<Webinar>> getLiveClubsfromRemote({String? userId});

  Future<List<Webinar>> getUpcomingClubsfromRemote({String? userId});

  Future<List<Webinar>> getPastClubsfromRemote({String? userId, int? page, int? pageSize, int? categoryId});

  Future<List<Webinar>> getFeaturedClubsfromRemote({String? userId, int? page, int? pageSize});

  Future<List<ChatReaction>> getChatReactions();

  Future<ChatReaction> getChatReactionDetail(String id);

  Future<List<Webinar>> getSeriesFromRemote({int? page, int? pageSize});

  Future<Series> getSeriesDetailsFromRemote(int id);

  // Post Group request data to Remote Server
  /// Throws [ServerException]
  Future<SeriesRequest> postSeriesRequestToRemote(
      SeriesRequest request);

  Future<List<CategoriesDetailList>> getWebinarCategoriesFromRemote();

  Future<FollowCreatorResponse> getCreatorsFromRemote({int? page, int? pageSize});
}

class ConversationRemoteDatasourceImpl implements ConversationRemoteDatasource {
  final Reader read;

  ConversationRemoteDatasourceImpl(this.read);

  @override
  Future<List<Topic>> getAllTopicsFromRemote(int? parent) async {
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
  Future<List<Topic>> getAllAMATopicsFromRemote() async {
    final response =
        await read(conversationApiServiceProvider).getAllAMATopics();
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
  Future<List<Topic>> getAllArticleTopicsFromRemote() async {
    final response =
        await read(conversationApiServiceProvider).getAllArticleTopics();
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
  Future<List<ConversationByDate>> getMyConversationsByDatefromRemote(
      DateTime start, DateTime end) async {
    final response = await read(conversationApiServiceProvider)
        .getMyConversationsByDate(start, end);
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
        await read(conversationApiServiceProvider).retrieveWebinar(id);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return Conversation.fromJson(json);
    } else if (response.statusCode == 404) {
      throw GroupNotFoundException(response.error);
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
  Future<ConversationRequest> getWebinarRSVPRequestFromRemote(
      int webinarId) async {
    final response = await read(conversationApiServiceProvider)
        .getWebinarRSVP(webinarId);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return ConversationRequest.fromJson(json);
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

  @override
  Future<List<Optin>> getAllConversationOptinsFromRemote() async {
    final response =
        await read(conversationApiServiceProvider).getAllMyOptins();
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.bodyString) as Iterable;
      return jsonList
          .map((optin) => Optin.fromJson(optin as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<List<OptinsByDate>> getAllConversationOptinsByDateFromRemote() async {
    final response =
        await read(conversationApiServiceProvider).getOptinsByDate();
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.bodyString) as Iterable;
      return jsonList
          .map((optin) => OptinsByDate.fromJson(optin as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<List<DateTime>> getInstantConversationTimeSlotsFromRemote() async {
    final response = await read(conversationApiServiceProvider)
        .getInstantConversationTimeSlots();
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.bodyString) as Iterable;
      return jsonList.map((slot) => DateTime.parse(slot as String)).toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<Conversation> postCreateInstantConversationToRemote(
      Conversation conversation) async {
    final body = conversation.toJson();
    final response = await read(conversationApiServiceProvider)
        .postInstantConversation(body);
    if (response.statusCode == 201) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return Conversation.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<Topic> postTopicSuggestionToRemote(Topic topic) async {
    final body = {
      'topic': topic.name,
      'type': topic.type == TopicType.group ? 0 : 1,
    };
    final response = await read(conversationApiServiceProvider)
        .postTopicSuggestionRequest(body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return Topic.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<List<Webinar>> getLiveClubsfromRemote({String? userId}) async {
    final response =
        await read(conversationApiServiceProvider).getLiveClubs(userId);
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.bodyString) as Iterable;
      return jsonList
          .map((json) => Webinar.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<List<Webinar>> getUpcomingClubsfromRemote({String? userId}) async {
    final response =
        await read(conversationApiServiceProvider).getUpcomingClubs(userId);
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.bodyString) as Iterable;
      return jsonList
          .map((json) => Webinar.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<List<Webinar>> getPastClubsfromRemote({String? userId, int? page, int? pageSize, int? categoryId}) async {
    final response =
        await read(conversationApiServiceProvider).getPastClubs(userId, page, pageSize, categoryId);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as  Map<String, dynamic>;
      final jsonList = json['results'] as Iterable;
      return jsonList
          .map((json) => Webinar.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<List<Webinar>> getFeaturedClubsfromRemote({String? userId, int? page, int? pageSize}) async {
    final response =
        await read(conversationApiServiceProvider).getFeaturedClubs(userId, page, pageSize);
    if (response.statusCode == 200) {
      if (response.bodyString == "[]") {
        return List.empty();
      }
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      final jsonList = json['results'] as List;
      // final jsonList = jsonDecode(response.bodyString) as Iterable;
      return jsonList
          .map((json) => Webinar.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<List<ChatReaction>> getChatReactions() async {
    final response =
        await read(conversationApiServiceProvider).getChatReactions();
    if (response.statusCode == 200) {
      if (response.bodyString == "[]") {
        return List.empty();
      }
      final jsonList = jsonDecode(response.bodyString) as List;
      return jsonList
          .map((json) => ChatReaction.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<ChatReaction> getChatReactionDetail(String id) async {
    final response =
        await read(conversationApiServiceProvider).getChatReactionDetail(id);
    if (response.statusCode == 200) {
      if (response.bodyString == "[]") {
        return const ChatReaction();
      }
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return  ChatReaction.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<List<Webinar>> getSeriesFromRemote({int? page, int? pageSize}) async {
    final response =
        await read(conversationApiServiceProvider).getSeries(page, pageSize);
    if (response.statusCode == 200) {
      if (response.bodyString == "[]") {
        return List.empty();
      }
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      final jsonList = json['results'] as List;
      // final jsonList = jsonDecode(response.bodyString) as Iterable;
      return jsonList
          .map((json) => Webinar.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<Series> getSeriesDetailsFromRemote(int id) async {
    final response =
        await read(conversationApiServiceProvider).getSeriesDetails(id);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return Series.fromJson(json);
    } else if (response.statusCode == 404) {
      throw GroupNotFoundException(response.error);
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<SeriesRequest> postSeriesRequestToRemote(
      SeriesRequest request) async {
    final body = request.toJson();
    final response = await read(conversationApiServiceProvider)
        .postSeriesRequest(body);
    if (response.statusCode == 201) {
      // final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      // return SeriesRequest.fromJson(json);
      return request;
    } else {
      throw ServerException(response.error);
    }
  }


  @override
  Future<List<CategoriesDetailList>> getWebinarCategoriesFromRemote() async {
    final response =
        await read(conversationApiServiceProvider).getWebinarCategories();
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.bodyString) as Iterable;
      return jsonList
          .map((topic) => CategoriesDetailList.fromJson(topic as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<FollowCreatorResponse> getCreatorsFromRemote({int? page, int? pageSize}) async {
    final response =
        await read(conversationApiServiceProvider).retrieveCreators(page, pageSize);
    if (response.statusCode == 200) {
      if (response.bodyString == '[]') {
        throw ServerException('Empty');
      }
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      final result = FollowCreatorResponse.fromJson(json);
     

      return result;
    } else {
      throw ServerException(response.error);
    }
  }
}
