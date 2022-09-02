import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/error/exceptions.dart';
import 'package:worknetwork/features/connection/data/models/creator_response.dart';
import 'package:worknetwork/features/conversations/data/models/conversation_exceptions/conversation_exceptions.dart';
import 'package:worknetwork/features/conversations/data/services/conversation_api_service/conversation_api_service.dart';
import 'package:worknetwork/features/conversations/domain/entity/chat_reaction_entity/chat_reaction_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/conversation_entity/conversation_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/conversation_request_entity/conversation_request_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/series_entity/series_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/series_request_entity/series_request_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/topic_entity/topic_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/webinar_entity/webinar_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/webinar_entity/webinar_request_entity.dart';

final conversationRemoteDatasourceProvider =
    Provider<ConversationRemoteDatasource>(
  (_) => ConversationRemoteDatasourceImpl(_.read),
);

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
    DateTime start,
    DateTime end,
  );

  /// Get My Conversation for user from start to end date
  /// Throws [ServerException] on error
  Future<List<ConversationByDate>> getMyConversationsByDatefromRemote(
    DateTime start,
    DateTime end,
  );

  /// Get All Conversation by id
  /// Throws [ServerException] on error
  Future<Webinar> retrieveConversationFromRemote(int id);

  Future<ConversationRequest> getWebinarRSVPRequestFromRemote(int webinarId);

  // Post Group request data to Remote Server
  /// Throws [ServerException]
  Future<ConversationRequest> postGroupRequestToRemote(
    ConversationRequest request,
  );

  // Get List of DateTimes for instant conversations
  /// Throws [ServerException]
  Future<List<DateTime>> getInstantConversationTimeSlotsFromRemote();

  // Post an instant conversation to remote server
  /// Throws [ServerException]
  Future<Conversation> postCreateInstantConversationToRemote(
    Conversation conversation,
  );

  // Post an instant conversation to remote server
  /// Throws [ServerException]
  Future<Topic> postTopicSuggestionToRemote(Topic topic);

  /// Get All Conversation for user from start to end date
  /// Throws [ServerException] on error
  Future<List<Webinar>> getLiveClubsfromRemote({String? userId});
  Future<List<Webinar>> getAllClubsfromRemote();

  Future<FollowCreatorResponse> getUpcomingClubsfromRemote({
    String? userId,
    int? page,
    int? pageSize,
    int? categoryId,
  });

  Future<List<Webinar>> getPastClubsfromRemote({
    String? userId,
    int? page,
    int? pageSize,
    int? categoryId,
  });

  Future<FollowCreatorResponse> getFeaturedClubsfromRemote({
    String? userId,
    int? page,
    int? pageSize,
  });

  Future<List<ChatReaction>> getChatReactions();

  Future<ChatReaction> getChatReactionDetail(String id);

  Future<List<Webinar>> getSeriesFromRemote({int? page, int? pageSize});

  Future<Series> getSeriesDetailsFromRemote(int id);

  // Post Group request data to Remote Server
  /// Throws [ServerException]
  Future<SeriesRequest> postSeriesRequestToRemote(SeriesRequest request);

  Future<List<CategoriesDetailList>> getWebinarCategoriesFromRemote();

  Future<FollowCreatorResponse> getCreatorsFromRemote({
    int? page,
    int? pageSize,
  });

  Future<Webinar> postWebinarToRemote(WebinarRequest request);
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
    DateTime start,
    DateTime end,
  ) async {
    final response = await read(conversationApiServiceProvider)
        .getConversationsByDate(start, end);
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.bodyString) as Iterable;
      return jsonList
          .map(
            (json) => ConversationByDate.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<List<ConversationByDate>> getMyConversationsByDatefromRemote(
    DateTime start,
    DateTime end,
  ) async {
    final response = await read(conversationApiServiceProvider)
        .getMyConversationsByDate(start, end);
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.bodyString) as Iterable;
      return jsonList
          .map(
            (json) => ConversationByDate.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<Webinar> retrieveConversationFromRemote(int id) async {
    final response =
        await read(conversationApiServiceProvider).retrieveWebinar(id);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return Webinar.fromJson(json);
    } else if (response.statusCode == 404) {
      throw GroupNotFoundException(response.error);
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<ConversationRequest> getWebinarRSVPRequestFromRemote(
    int webinarId,
  ) async {
    final response =
        await read(conversationApiServiceProvider).getWebinarRSVP(webinarId);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return ConversationRequest.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<ConversationRequest> postGroupRequestToRemote(
    ConversationRequest request,
  ) async {
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
    Conversation conversation,
  ) async {
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
  Future<List<Webinar>> getAllClubsfromRemote({String? userId}) async {
    final response = await read(conversationApiServiceProvider).getAllClubs();
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
  Future<FollowCreatorResponse> getUpcomingClubsfromRemote({
    String? userId,
    int? page,
    int? pageSize,
    int? categoryId,
  }) async {
    final response = await read(conversationApiServiceProvider)
        .getUpcomingClubs(userId, page, pageSize, categoryId);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return FollowCreatorResponse.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<List<Webinar>> getPastClubsfromRemote({
    String? userId,
    int? page,
    int? pageSize,
    int? categoryId,
  }) async {
    final response = await read(conversationApiServiceProvider)
        .getPastClubs(userId, page, pageSize, categoryId);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      final jsonList = json['results'] as Iterable;
      return jsonList
          .map((json) => Webinar.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<FollowCreatorResponse> getFeaturedClubsfromRemote({
    String? userId,
    int? page,
    int? pageSize,
  }) async {
    final response = await read(conversationApiServiceProvider)
        .getFeaturedClubs(userId, page, pageSize);
    if (response.statusCode == 200) {
      if (response.bodyString == "[]") {
        return FollowCreatorResponse(
          count: 0,
          currentPage: page ?? 0,
          results: [],
        );
      }
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return FollowCreatorResponse.fromJson(json);
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
      return ChatReaction.fromJson(json);
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
  Future<SeriesRequest> postSeriesRequestToRemote(SeriesRequest request) async {
    final body = request.toJson();
    final response =
        await read(conversationApiServiceProvider).postSeriesRequest(body);
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
          .map(
            (topic) =>
                CategoriesDetailList.fromJson(topic as Map<String, dynamic>),
          )
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<FollowCreatorResponse> getCreatorsFromRemote({
    int? page,
    int? pageSize,
  }) async {
    final response = await read(conversationApiServiceProvider)
        .retrieveCreators(page, pageSize);
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

  @override
  Future<Webinar> postWebinarToRemote(WebinarRequest request) async {
    final body = request.toJson();
    if (body['rtmp_link'] == '') {
      body.remove('rtmp_link');
    }
    final response =
        await read(conversationApiServiceProvider).postWebinarRequest(body);
    if (response.statusCode == 201) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      final webinar = Webinar.fromJson(json);
      return webinar;
    } else {
      throw ServerException(response.error);
    }
  }
}
