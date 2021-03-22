import 'package:dartz/dartz.dart';

import '../../../../core/error/failures/failures.dart';
import '../../../meeting/domain/entity/meeting_config_entity.dart';
import '../../../meeting/domain/entity/meeting_interest_entity.dart';
import '../../../meeting/domain/entity/time_slot_entity.dart';
import '../entity/agenda_entity/agenda_entity.dart';
import '../entity/category_entity/category_entity.dart';
import '../entity/group_request/group_request_enitity.dart';
import '../entity/optin_entity/optin_entity.dart';
import '../entity/roundtable_entity/roundtable_entity.dart';
import '../entity/roundtable_rtc_info/roundtable_rtc_info.dart';
import '../entity/topic_entity/topic_entity.dart';

abstract class RoundTableRepository {
  Future<Either<Failure, List<RoundTable>>> getAllRoundTables(
      {List<int> topicsIds});
  Future<Either<Failure, List<RoundTable>>> getAllMyRoundTables(
      {List<int> topicsIds});
  Future<Either<Failure, RoundTable>> retrieveRoundTable(int id);
  Future<Either<Failure, List<Optin>>> getAllMyOptins();

  Future<Either<Failure, RoundtableRtcInfo>> getRoundTableRtcInfo(int tableId);
  Future<Either<Failure, List<Agenda>>> getAgendas(int categoryId);

  Future<Either<Failure, List<Topic>>> getAllTopics(int parent);
  Future<Either<Failure, List<Topic>>> getAllRootTopicsForGroups();

  Future<Either<Failure, Optin>> postGroupOptin(
    List<MeetingInterest> interests,
    List<TimeSlot> timeslots,
    MeetingConfig config,
    Topic topic,
  );

  Future<Either<Failure, GroupRequest>> postRequestToJoinGroup(
      GroupRequest request);
}
