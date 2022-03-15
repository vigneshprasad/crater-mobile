import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/conversations/domain/entity/chat_reaction_entity/chat_reaction_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/series_entity/series_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/series_request_entity/series_request_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/webinar_entity/webinar_entity.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures/failures.dart';
import '../../../meeting/domain/entity/meeting_config_entity.dart';
import '../../../meeting/domain/entity/meeting_interest_entity.dart';
import '../../../meeting/domain/entity/time_slot_entity.dart';
import '../../domain/entity/conversation_entity/conversation_entity.dart';
import '../../domain/entity/conversation_request_entity/conversation_request_entity.dart';
import '../../domain/entity/conversation_rtc_info_entity/conversation_rtc_info_entity.dart';
import '../../domain/entity/optin_entity/optin_entity.dart';
import '../../domain/entity/topic_entity/topic_entity.dart';
import '../../domain/repository/conversation_repository.dart';
import '../datasources/conversation_remote_datasource.dart';
import '../models/conversation_exceptions/conversation_exceptions.dart';
import '../models/conversation_failures/conversation_failures.dart';

final conversationRepositoryProvider = Provider<ConversationRepository>(
    (ref) => ConversationRepositoryImpl(ref.read));

class ConversationRepositoryImpl implements ConversationRepository {
  final Reader read;

  ConversationRepositoryImpl(this.read);

  @override
  Future<Either<Failure, List<ConversationByDate>>> getAllConversations(
      DateTime start, DateTime end) async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .getAllConversationsByDatefromRemote(start, end);
      return Right(response);
    } on ServerException catch (error) {
      final failure = ServerFailure(message: "Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<ConversationByDate>>> getMyConversations(
      DateTime start, DateTime end) async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .getMyConversationsByDatefromRemote(start, end);
      return Right(response);
    } on ServerException catch (error) {
      final failure = ServerFailure(message: "Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Optin>> postGroupOptin(List<MeetingInterest> interests,
      List<TimeSlot> timeslots, MeetingConfig config, Topic topic) async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .postGroupOptinToRemote(interests, timeslots, config, topic);
      return Right(response);
    } on ServerException catch (error) {
      final failure = ServerFailure(message: "Something went wrong");
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
    } on ServerException catch (error) {
      final failure = ServerFailure(message: "Something went wrong");
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
    } on ServerException catch (error) {
      final failure = ServerFailure(message: "Something went wrong");
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
    } on ServerException catch (error) {
      final failure = ServerFailure(message: "Something went wrong");
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
    } on ServerException catch (error) {
      final failure = ServerFailure(message: "Something went wrong");
      return Left(failure);
    } on GroupNotFoundException {
      return Left(ConversationFailure(
        message: "This seems to be an incorrect link. Return to home screen.",
        errorCode: ConversationFailuresType.groupNotFound,
      ));
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, ConversationRequest>> getWebinarRSVPRequest(
      int webinarId) async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .getWebinarRSVPRequestFromRemote(webinarId);
      return Right(response);
    } on ServerException catch (error) {
      final failure = ServerFailure(message: "Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, ConversationRequest>> postRequestToJoinGroup(
      ConversationRequest request) async {
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
  Future<Either<Failure, ConversationRtcInfo>> getConversationRtcInfo(
      int tableId) async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .getConversationRtcInfoFromRemote(tableId);
      return Right(response);
    } on ServerException catch (error) {
      final failure = ServerFailure(message: "Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Optin>>> getAllConversationOptins() async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .getAllConversationOptinsFromRemote();
      return Right(response);
    } on ServerException catch (error) {
      final failure = ServerFailure(message: "Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<OptinsByDate>>>
      getAllConversationOptinsByDate() async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .getAllConversationOptinsByDateFromRemote();
      return Right(response);
    } on ServerException catch (error) {
      final failure = ServerFailure(message: "Something went wrong");
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
    } on ServerException catch (error) {
      final failure = ServerFailure(message: "Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Conversation>> postCreateInstantConversation(
      Conversation conversation) async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .postCreateInstantConversationToRemote(conversation);
      return Right(response);
    } on ServerException catch (error) {
      final failure = ServerFailure(message: "Something went wrong");
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
    } on ServerException catch (error) {
      final failure = ServerFailure(message: "Something went wrong");
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
    } on ServerException catch (error) {
      final failure = ServerFailure(message: "Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Webinar>>> getUpcomingClubs(
      {String? userId}) async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .getUpcomingClubsfromRemote(userId: userId);
      return Right(response);
    } on ServerException catch (error) {
      final failure = ServerFailure(message: "Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Webinar>>> getPastClubs({String? userId, int? page, int? pageSize, int? categoryId}) async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .getPastClubsfromRemote(userId: userId, page: page, pageSize: pageSize, categoryId: categoryId);
      return Right(response);
    } on ServerException catch (error) {
      final failure = ServerFailure(message: "Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Webinar>>> getFeaturedClubs(
      {String? userId, int? page, int? pageSize}) async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .getFeaturedClubsfromRemote(userId: userId, page: page, pageSize: pageSize);
      return Right(response);
    } on ServerException catch (error) {
      final failure = ServerFailure(message: "Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<ChatReaction>>> getChatReactions() async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .getChatReactions();
      return Right(response);
    } on ServerException catch (error) {
      final failure = ServerFailure(message: "Something went wrong");
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
    } on ServerException catch (error) {
      final failure = ServerFailure(message: "Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Webinar>>> getSeries(
      {int? page, int? pageSize}) async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .getSeriesFromRemote(page: page, pageSize: pageSize);
      return Right(response);
    } on ServerException catch (error) {
      final failure = ServerFailure(message: "Something went wrong");
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
      final failure = ServerFailure(message: "Something went wrong");
      return Left(failure);
    } on GroupNotFoundException {
      return Left(ConversationFailure(
        message: "This seems to be an incorrect link. Return to home screen.",
        errorCode: ConversationFailuresType.groupNotFound,
      ));
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, SeriesRequest>> postRequestToRSVPSeries(
      SeriesRequest request) async {
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
  Future<Either<Failure, List<CategoriesDetailList>>> getWebinarCategories() async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .getWebinarCategoriesFromRemote();
      return Right(response);
    } on ServerException catch (error) {
      final failure = ServerFailure(message: "Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }
}
