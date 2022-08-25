import 'package:dartz/dartz.dart';
import 'package:worknetwork/core/error/failures/failures.dart';
import 'package:worknetwork/features/connection/data/models/creator_response.dart';
import 'package:worknetwork/features/conversations/domain/entity/chat_reaction_entity/chat_reaction_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/conversation_entity/conversation_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/conversation_request_entity/conversation_request_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/series_entity/series_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/series_request_entity/series_request_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/topic_entity/topic_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/webinar_entity/webinar_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/webinar_entity/webinar_request_entity.dart';

abstract class ConversationRepository {
  Future<Either<Failure, List<ConversationByDate>>> getAllConversations(
    DateTime start,
    DateTime end,
  );
  Future<Either<Failure, List<ConversationByDate>>> getMyConversations(
    DateTime start,
    DateTime end,
  );
  Future<Either<Failure, Webinar>> retreiveConversation(int id);

  Future<Either<Failure, List<Topic>>> getAllArticleTopics();

  Future<Either<Failure, List<Topic>>> getAllAMATopics();

  Future<Either<Failure, List<Topic>>> getAllTopics(int? parent);

  Future<Either<Failure, ConversationRequest>> getWebinarRSVPRequest(
    int webinarId,
  );

  Future<Either<Failure, ConversationRequest>> postRequestToJoinGroup(
    ConversationRequest request,
  );

  Future<Either<Failure, List<DateTime>>> getInstantConversationTimeSlots();

  Future<Either<Failure, Conversation>> postCreateInstantConversation(
    Conversation conversation,
  );
  Future<Either<Failure, Topic>> postTopicSuggestion(Topic topic);
  Future<Either<Failure, List<Webinar>>> getAllClubs();
  Future<Either<Failure, List<Webinar>>> getLiveClubs({String? userId});
  Future<Either<Failure, FollowCreatorResponse>> getUpcomingClubs({
    String? userId,
    int? page,
    int? pageSize,
  });
  Future<Either<Failure, List<Webinar>>> getPastClubs({
    String? userId,
    int? page,
    int? pageSize,
    int? categoryId,
  });
  Future<Either<Failure, FollowCreatorResponse>> getFeaturedClubs({
    String? userId,
    int? page,
    int? pageSize,
  });

  Future<Either<Failure, List<ChatReaction>>> getChatReactions();
  Future<Either<Failure, ChatReaction>> getChatReactionDetail(String id);

  Future<Either<Failure, List<Webinar>>> getSeries({int? page, int? pageSize});

  Future<Either<Failure, Series>> getSeriesDetails(int id);

  Future<Either<Failure, SeriesRequest>> postRequestToRSVPSeries(
    SeriesRequest request,
  );

  Future<Either<Failure, List<CategoriesDetailList>>> getWebinarCategories();

  Future<Either<Failure, FollowCreatorResponse>> getCreators({
    int? page,
    int? pageSize,
  });

  Future<Either<Failure, Webinar>> postWebinar(WebinarRequest request);
}
