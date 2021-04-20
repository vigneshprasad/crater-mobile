import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/conversations/data/models/conversation_exceptions/conversation_exceptions.dart';

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
      final message =
          jsonDecode(error.message as String) as Map<String, dynamic>;
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
      final message =
          jsonDecode(error.message as String) as Map<String, dynamic>;
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
      final message =
          jsonDecode(error.message as String) as Map<String, dynamic>;
      final failure = ServerFailure(message: "Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Topic>>> getAllTopics(int parent) async {
    try {
      final response = await read(conversationRemoteDatasourceProvider)
          .getAllTopicsFromRemote(parent);
      return Right(response);
    } on ServerException catch (error) {
      final message =
          jsonDecode(error.message as String) as Map<String, dynamic>;
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
      final message =
          jsonDecode(error.message as String) as Map<String, dynamic>;
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
      final message =
          jsonDecode(error.message as String) as Map<String, dynamic>;
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
      final message =
          jsonDecode(error.message as String) as Map<String, dynamic>;
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
      final message =
          jsonDecode(error.message as String) as Map<String, dynamic>;
      final failure = ServerFailure(message: "Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }
}
