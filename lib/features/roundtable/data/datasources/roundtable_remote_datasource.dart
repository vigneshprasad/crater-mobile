import 'dart:convert';

import 'package:hooks_riverpod/all.dart';
import 'package:kiwi/kiwi.dart';

import '../../../../api/meets/meets_api_service.dart';
import '../../../../core/error/exceptions.dart';
import '../../../meeting/domain/entity/meeting_config_entity.dart';
import '../../../meeting/domain/entity/meeting_interest_entity.dart';
import '../../../meeting/domain/entity/time_slot_entity.dart';
import '../../domain/entity/agenda_entity/agenda_entity.dart';
import '../../domain/entity/category_entity/category_entity.dart';
import '../../domain/entity/optin_entity/optin_entity.dart';
import '../../domain/entity/roundtable_entity/roundtable_entity.dart';
import '../../domain/entity/roundtable_rtc_info/roundtable_rtc_info.dart';
import '../../domain/entity/topic_entity/topic_entity.dart';
import '../services/round_table_api_service/roundtable_api_service.dart';
import '../services/rtc_api_service/rtc_api_service.dart';

final roundTableRemoteDatasourceProvider =
    Provider<RoundTableRemoteDatasource>((ref) {
  final RoundTableApiService roundTableApiService =
      ref.read(roundTableApiServiceProvider);
  final RtcApiService rtcApiService = ref.read(rtcApiServiceProvider);
  final MeetsApiService meetsApiService = KiwiContainer().resolve();
  return RoundTableRemoteDatasourceImpl(
    roundTableApiService,
    rtcApiService,
    meetsApiService,
  );
});

abstract class RoundTableRemoteDatasource {
  /// Get List of All Topcics from Remote server
  /// filter based on [parent] topic id.
  /// Throws [ServerException]
  Future<List<Topic>> getAllTopicsFromRemote(int parent);

  /// Get Root Topic for a topic based on [id]
  /// Throws [ServerException]
  Future<Topic> getRootTopicFromRemote(int parent);

  /// Get List of All Categories from Remote server
  /// Throws [ServerException]
  Future<List<Category>> getAllCategoriesFromRemote();

  /// Get List of Categories of All RoundTable from Remote server
  /// Throws [ServerException]
  Future<List<Category>> getAllRoundTableCategoriesFromRemote();

  /// Get List of Categories of User's RoundTable from Remote server
  /// Throws [ServerException]
  Future<List<Category>> getMyRoundTableCategoriesFromRemote();

  /// Get List of RoundTables from Remote server
  /// Throws [ServerException]
  Future<List<RoundTable>> getRoundTablesFromRemote();

  /// Get List of RoundTables Hosted by User from Remote server
  /// Throws [ServerException]
  Future<List<RoundTable>> getMyRoundTablesFromRemote();

  /// Retrieve RoundTable from Remote server by [id]
  /// Throws [ServerException]
  Future<RoundTable> retrieveRoundTableFromRemote(int id);

  /// Retrieve RoundTable RTC Info from Remote server by [tableId]
  /// Throws [ServerException]
  Future<RoundtableRtcInfo> getRoundTableRtcInfoFromRemote(int tableId);

  /// Retrieve List of Agendas by [categoryId]
  /// Throws [ServerException]
  Future<List<Agenda>> getAgendasFromRemote(int categoryId);

  /// Post Opt-in for Group Meeting to Remote Server
  /// Throws [ServerException]
  Future<Optin> postGroupOptinToRemote(
    List<MeetingInterest> interests,
    List<TimeSlot> timeslots,
    MeetingConfig config,
    Topic topic,
  );

  /// Get All User Optins from Remote Server
  /// Throws [ServerException]
  Future<List<Optin>> getAllUserOptinsFromRemote();
}

class RoundTableRemoteDatasourceImpl implements RoundTableRemoteDatasource {
  final RoundTableApiService roundTableApiService;
  final RtcApiService rtcApiService;
  final MeetsApiService meetsApiService;

  RoundTableRemoteDatasourceImpl(
    this.roundTableApiService,
    this.rtcApiService,
    this.meetsApiService,
  );

  @override
  Future<List<Category>> getAllCategoriesFromRemote() async {
    final response = await roundTableApiService.getAlMyOptins();
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.bodyString) as Iterable;
      return jsonList
          .map(
              (category) => Category.fromJson(category as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<List<Category>> getAllRoundTableCategoriesFromRemote() async {
    final response = await roundTableApiService.getAllCategoriesForTables();
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.bodyString) as Iterable;
      return jsonList
          .map(
              (category) => Category.fromJson(category as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<List<Category>> getMyRoundTableCategoriesFromRemote() async {
    final response = await roundTableApiService.getUserTableCategories();
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.bodyString) as Iterable;
      return jsonList
          .map((table) => Category.fromJson(table as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<List<RoundTable>> getRoundTablesFromRemote() async {
    final response = await roundTableApiService.getRoundTables();
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.bodyString) as Iterable;
      return jsonList
          .map((table) => RoundTable.fromJson(table as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<List<RoundTable>> getMyRoundTablesFromRemote() async {
    final response = await roundTableApiService.getMyRoundTables();
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.bodyString) as Iterable;
      return jsonList
          .map((category) =>
              RoundTable.fromJson(category as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<RoundTable> retrieveRoundTableFromRemote(int id) async {
    final response = await roundTableApiService.retrieveRoundTable(id);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return RoundTable.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<RoundtableRtcInfo> getRoundTableRtcInfoFromRemote(int tableId) async {
    final body = {
      "channel_id": tableId,
    };
    final response = await rtcApiService.getRtcInfo(body);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return RoundtableRtcInfo.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<List<Agenda>> getAgendasFromRemote(int categoryId) async {
    final response = await roundTableApiService.getAgendaByCategory(categoryId);
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.bodyString) as Iterable;
      return jsonList
          .map((agenda) => Agenda.fromJson(agenda as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<List<Topic>> getAllTopicsFromRemote(int parent) async {
    final response = await roundTableApiService.getAllTopics(parent);
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
  Future<Topic> getRootTopicFromRemote(int parent) async {
    final response = await roundTableApiService.getRootTopic(parent);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return Topic.fromJson(json);
    } else if (response.statusCode == 204) {
      return null;
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<Optin> postGroupOptinToRemote(
    List<MeetingInterest> interests,
    List<TimeSlot> timeslots,
    MeetingConfig config,
    Topic topic,
  ) async {
    final body = {
      "interests": interests.map((interest) => interest.pk).toList(),
      "time_slots": timeslots.map((slot) => slot.pk).toList(),
      "meeting": config.pk,
      "topic": topic.id,
    };
    final response = await roundTableApiService.postGroupOptin(body);
    if (response.statusCode == 201) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return Optin.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<List<Optin>> getAllUserOptinsFromRemote() async {
    final response = await roundTableApiService.getAlMyOptins();
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.bodyString) as Iterable;
      return jsonList
          .map((json) => Optin.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }
}
