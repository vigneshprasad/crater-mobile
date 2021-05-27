import 'package:dartz/dartz.dart';

import '../../../../core/error/failures/failures.dart';
import '../../../meeting/domain/entity/meeting_config_entity.dart';
import '../../../meeting/domain/entity/meeting_interest_entity.dart';
import '../../../meeting/domain/entity/time_slot_entity.dart';
import '../entity/conversation_entity/conversation_entity.dart';
import '../entity/conversation_request_entity/conversation_request_entity.dart';
import '../entity/conversation_rtc_info_entity/conversation_rtc_info_entity.dart';
import '../entity/optin_entity/optin_entity.dart';
import '../entity/topic_entity/topic_entity.dart';

abstract class ConversationRepository {
  Future<Either<Failure, List<ConversationByDate>>> getAllConversations(
      DateTime start, DateTime end);
  Future<Either<Failure, List<ConversationByDate>>> getMyConversations(
      DateTime start, DateTime end);
  Future<Either<Failure, Conversation>> retreiveConversation(int id);

  Future<Either<Failure, ConversationRtcInfo>> getConversationRtcInfo(
      int tableId);

  Future<Either<Failure, List<Topic>>> getAllArticleTopics();

  Future<Either<Failure, List<Topic>>> getAllTopics(int parent);

  Future<Either<Failure, Optin>> postGroupOptin(
    List<MeetingInterest> interests,
    List<TimeSlot> timeslots,
    MeetingConfig config,
    Topic topic,
  );

  Future<Either<Failure, ConversationRequest>> postRequestToJoinGroup(
      ConversationRequest request);

  Future<Either<Failure, List<Optin>>> getAllConversationOptins();

  Future<Either<Failure, List<OptinsByDate>>> getAllConversationOptinsByDate();

  Future<Either<Failure, List<DateTime>>> getInstantConversationTimeSlots();

  Future<Either<Failure, Conversation>> postCreateInstantConversation(
      Conversation conversation);
}
