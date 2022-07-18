import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/error/exceptions.dart';
import 'package:worknetwork/core/error/failures/failures.dart';
import 'package:worknetwork/features/connection/data/models/creator_response.dart';
import 'package:worknetwork/features/conversations/data/datasources/conversation_remote_datasource.dart';
import 'package:worknetwork/features/conversations/data/models/conversation_exceptions/conversation_exceptions.dart';
import 'package:worknetwork/features/conversations/data/models/conversation_failures/conversation_failures.dart';
import 'package:worknetwork/features/conversations/domain/entity/chat_reaction_entity/chat_reaction_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/conversation_entity/conversation_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/conversation_request_entity/conversation_request_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/series_entity/series_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/series_request_entity/series_request_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/topic_entity/topic_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/webinar_entity/webinar_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/webinar_entity/webinar_request_entity.dart';
import 'package:worknetwork/features/conversations/domain/repository/conversation_repository.dart';

final conversationRepositoryProvider = Provider<ConversationRepository>(
  (ref) => ConversationRepositoryImpl(ref.read),
);

class ConversationRepositoryImpl implements ConversationRepository {
  final Reader read;

  ConversationRepositoryImpl(this.read);

  @override
  Future<Either<Failure, List<ConversationByDate>>> getAllConversations(
    DateTime start,
    DateTime end,
  ) async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .getAllConversationsByDatefromRemote(start, end);
      return Right(response);
    } on ServerException {
      final failure = ServerFailure("Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<ConversationByDate>>> getMyConversations(
    DateTime start,
    DateTime end,
  ) async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .getMyConversationsByDatefromRemote(start, end);
      return Right(response);
    } on ServerException {
      final failure = ServerFailure("Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Topic>>> getAllTopics(int? parent) async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .getAllTopicsFromRemote(parent);
      return Right(response);
    } on ServerException {
      final failure = ServerFailure("Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Topic>>> getAllAMATopics() async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .getAllAMATopicsFromRemote();
      return Right(response);
    } on ServerException {
      final failure = ServerFailure("Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Topic>>> getAllArticleTopics() async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .getAllArticleTopicsFromRemote();
      return Right(response);
    } on ServerException {
      final failure = ServerFailure("Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Conversation>> retreiveConversation(int id) async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .retrieveConversationFromRemote(id);
      return Right(response);
    } on ServerException {
      final failure = ServerFailure("Something went wrong");
      return Left(failure);
    } on GroupNotFoundException {
      return Left(
        ConversationFailure(
          message: "This seems to be an incorrect link. Return to home screen.",
          errorCode: ConversationFailuresType.groupNotFound,
        ),
      );
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, ConversationRequest>> getWebinarRSVPRequest(
    int webinarId,
  ) async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .getWebinarRSVPRequestFromRemote(webinarId);
      return Right(response);
    } on ServerException {
      final failure = ServerFailure("Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, ConversationRequest>> postRequestToJoinGroup(
    ConversationRequest request,
  ) async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .postGroupRequestToRemote(request);
      return Right(response);
    } on ServerException catch (error) {
      final message =
          jsonDecode(error.message as String) as Map<String, dynamic>;
      final failure = ConversationFailure.fromJson(message);
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<DateTime>>>
      getInstantConversationTimeSlots() async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .getInstantConversationTimeSlotsFromRemote();
      return Right(response);
    } on ServerException {
      final failure = ServerFailure("Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Conversation>> postCreateInstantConversation(
    Conversation conversation,
  ) async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .postCreateInstantConversationToRemote(conversation);
      return Right(response);
    } on ServerException {
      final failure = ServerFailure("Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Topic>> postTopicSuggestion(Topic topic) async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .postTopicSuggestionToRemote(topic);
      return Right(response);
    } on ServerException {
      final failure = ServerFailure("Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Webinar>>> getAllClubs() async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .getAllClubsfromRemote();
      return Right(response);
    } on ServerException {
      final failure = ServerFailure("Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Webinar>>> getLiveClubs({String? userId}) async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .getLiveClubsfromRemote(userId: userId);
      return Right(response);
    } on ServerException {
      final failure = ServerFailure("Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, FollowCreatorResponse>> getUpcomingClubs({
    String? userId,
    int? page,
    int? pageSize,
  }) async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .getUpcomingClubsfromRemote(
        userId: userId,
        page: page,
        pageSize: pageSize,
      );
      return Right(response);
    } on ServerException {
      final failure = ServerFailure("Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Webinar>>> getPastClubs({
    String? userId,
    int? page,
    int? pageSize,
    int? categoryId,
  }) async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .getPastClubsfromRemote(
        userId: userId,
        page: page,
        pageSize: pageSize,
        categoryId: categoryId,
      );
      return Right(response);
    } on ServerException {
      final failure = ServerFailure("Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, FollowCreatorResponse>> getFeaturedClubs({
    String? userId,
    int? page,
    int? pageSize,
  }) async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .getFeaturedClubsfromRemote(
        userId: userId,
        page: page,
        pageSize: pageSize,
      );
      return Right(response);
    } on ServerException {
      final failure = ServerFailure("Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<ChatReaction>>> getChatReactions() async {
    try {
      final response =
          await read(conversationRemoteDatasourceProvider).getChatReactions();
      return Right(response);
    } on ServerException {
      final failure = ServerFailure("Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, ChatReaction>> getChatReactionDetail(String id) async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .getChatReactionDetail(id);
      return Right(response);
    } on ServerException {
      final failure = ServerFailure("Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Webinar>>> getSeries({
    int? page,
    int? pageSize,
  }) async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .getSeriesFromRemote(page: page, pageSize: pageSize);
      return Right(response);
    } on ServerException {
      final failure = ServerFailure("Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Series>> getSeriesDetails(int id) async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .getSeriesDetailsFromRemote(id);
      return Right(response);
    } on ServerException catch (error) {
      final _ = jsonDecode(error.message as String) as Map<String, dynamic>;
      final failure = ServerFailure("Something went wrong");
      return Left(failure);
    } on GroupNotFoundException {
      return Left(
        ConversationFailure(
          message: "This seems to be an incorrect link. Return to home screen.",
          errorCode: ConversationFailuresType.groupNotFound,
        ),
      );
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, SeriesRequest>> postRequestToRSVPSeries(
    SeriesRequest request,
  ) async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .postSeriesRequestToRemote(request);
      return Right(response);
    } on ServerException catch (error) {
      final message =
          jsonDecode(error.message as String) as Map<String, dynamic>;
      final failure = ConversationFailure.fromJson(message);
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<CategoriesDetailList>>>
      getWebinarCategories() async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .getWebinarCategoriesFromRemote();
      return Right(response);
    } on ServerException {
      final failure = ServerFailure("Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, FollowCreatorResponse>> getCreators({
    int? page,
    int? pageSize,
  }) async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .getCreatorsFromRemote(page: page, pageSize: pageSize);
      return Right(response);
    } on ServerException {
      final failure = ServerFailure("Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Webinar>> postWebinar(WebinarRequest request) async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .postWebinarToRemote(request);
      return Right(response);
    } on ServerException catch (error) {
      final message =
          jsonDecode(error.message as String) as Map<String, dynamic>;
      if (message.containsKey('error_code')) {
        final failure = ConversationFailure.fromJson(message);
        return Left(failure);
      } else {
        final failure = ConversationFailure(
          errorCode: ConversationFailuresType.genericError,
          message: message.toString(),
        );
        return Left(failure);
      }
    } on SocketException {
      return Left(NetworkFailure());
    }
  }
}
