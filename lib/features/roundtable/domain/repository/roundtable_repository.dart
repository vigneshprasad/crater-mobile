import 'package:dartz/dartz.dart';

import '../../../../core/error/failures/failures.dart';
import '../../../meeting/domain/entity/meeting_config_entity.dart';
import '../../../meeting/domain/entity/meeting_interest_entity.dart';
import '../../../meeting/domain/entity/time_slot_entity.dart';
import '../../data/models/agora_rtc_user_info/agora_rtc_user_info.dart';
import '../../data/models/create_table_meta/create_table_meta.dart';
import '../../data/models/roundtable_meta_api_response/roundtable_meta_api_response.dart';
import '../entity/agenda_entity/agenda_entity.dart';
import '../entity/category_entity/category_entity.dart';
import '../entity/optin_entity/optin_entity.dart';
import '../entity/roundtable_entity/roundtable_entity.dart';
import '../entity/roundtable_rtc_info/roundtable_rtc_info.dart';
import '../entity/topic_entity/topic_entity.dart';

abstract class RoundTableRepository {
  Future<Either<Failure, List<Category>>> getAllCategories();
  Future<Either<Failure, List<Category>>> getAllRoundTableCategories();
  Future<Either<Failure, List<Category>>> getMyRoundTableCategories();
  Future<Either<Failure, List<Category>>> getUpcomingRoundTableCategories();
  Future<Either<Failure, List<RoundTable>>> getAllRoundTables();
  Future<Either<Failure, List<RoundTable>>> getAllMyRoundTables();
  Future<Either<Failure, RoundTableMetaApiResponse>> getRoundTableMetaInfo();
  Future<Either<Failure, RoundTable>> retrieveRoundTable(int id);
  Future<Either<Failure, RoundtableRtcInfo>> getRoundTableRtcInfo(int tableId);
  Future<Either<Failure, AgoraRtcUserInfo>> getAgoraRtcUserInfo(String uid);
  Future<Either<Failure, List<Agenda>>> getAgendas(int categoryId);

  Future<Either<Failure, List<Topic>>> getAllTopics(int parent);
  Future<Either<Failure, Topic>> getRootTopic(int topicId);

  Future<Either<Failure, Optin>> postGroupOptin(
    List<MeetingInterest> interests,
    List<TimeSlot> timeslots,
    MeetingConfig config,
    Topic topic,
  );
}
