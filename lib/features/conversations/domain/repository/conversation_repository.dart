import 'package:dartz/dartz.dart';
import 'package:worknetwork/features/conversations/domain/entity/chat_reaction_entity/chat_reaction_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/series_entity/series_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/series_request_entity/series_request_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/webinar_entity/webinar_entity.dart';

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

  Future<Either<Failure, List<Topic>>> getAllAMATopics();

  Future<Either<Failure, List<Topic>>> getAllTopics(int? parent);

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
  Future<Either<Failure, Topic>> postTopicSuggestion(Topic topic);
  Future<Either<Failure, List<Webinar>>> getLiveClubs({String? userId});
  Future<Either<Failure, List<Webinar>>> getUpcomingClubs({String? userId});
  Future<Either<Failure, List<Webinar>>> getPastClubs({String? userId, int? page, int? pageSize});
  Future<Either<Failure, List<Webinar>>> getFeaturedClubs({String? userId, int? page, int? pageSize});

  Future<Either<Failure, List<ChatReaction>>> getChatReactions();
  Future<Either<Failure, ChatReaction>> getChatReactionDetail(String id);

  Future<Either<Failure, List<Webinar>>> getSeries({int? page, int? pageSize});
  
  Future<Either<Failure, Series>> getSeriesDetails(int id);

  Future<Either<Failure, SeriesRequest>> postRequestToRSVPSeries(
      SeriesRequest request);
}
