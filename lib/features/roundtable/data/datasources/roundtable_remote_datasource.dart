import 'dart:convert';

import 'package:hooks_riverpod/all.dart';
import 'package:worknetwork/features/roundtable/data/services/rtc_api_service/rtc_api_service.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entity/category_entity/category_entity.dart';
import '../../domain/entity/roundtable_entity/roundtable_entity.dart';
import '../../domain/entity/roundtable_rtc_info/roundtable_rtc_info.dart';
import '../models/agora_rtc_user_info/agora_rtc_user_info.dart';
import '../models/roundtable_meta_api_response/roundtable_meta_api_response.dart';
import '../services/round_table_api_service/roundtable_api_service.dart';

final roundTableRemoteDatasourceProvider =
    Provider<RoundTableRemoteDatasource>((ref) {
  final RoundTableApiService roundTableApiService =
      ref.read(roundTableApiServiceProvider);
  final RtcApiService rtcApiService = ref.read(rtcApiServiceProvider);
  return RoundTableRemoteDatasourceImpl(roundTableApiService, rtcApiService);
});

abstract class RoundTableRemoteDatasource {
  /// Get List of Categories of All RoundTable from Remote server
  /// Throws [ServerException]
  Future<List<Category>> getAllRoundTableCategoriesFromRemote();

  /// Get List of Categories of User's RoundTable from Remote server
  /// Throws [ServerException]
  Future<List<Category>> getMyRoundTableCategoriesFromRemote();

  /// Get List of Categories of User's Upcoming RoundTable from Remote server
  /// Throws [ServerException]
  Future<List<Category>> getUpcomingRoundTableCategoriesFromRemote();

  /// Get List of RoundTables from Remote server
  /// Throws [ServerException]
  Future<List<RoundTable>> getRoundTablesFromRemote();

  /// Get List of RoundTables Hosted by User from Remote server
  /// Throws [ServerException]
  Future<List<RoundTable>> getMyRoundTablesFromRemote();

  /// Get Meta Info of RoundTables from Remote server
  /// Throws [ServerException]
  Future<RoundTableMetaApiResponse> getRoundTableMetaFromRemote();

  /// Retrieve RoundTable from Remote server by [id]
  /// Throws [ServerException]
  Future<RoundTable> retrieveRoundTableFromRemote(int id);

  /// Retrieve RoundTable RTC Info from Remote server by [tableId]
  /// Throws [ServerException]
  Future<RoundtableRtcInfo> getRoundTableRtcInfoFromRemote(int tableId);

  /// Retrieve Agora User RTC Info from Remote server by [uid]
  /// Throws [ServerException]
  Future<AgoraRtcUserInfo> getAgoraRtcUserInfoFromRemote(String uid);
}

class RoundTableRemoteDatasourceImpl implements RoundTableRemoteDatasource {
  final RoundTableApiService roundTableApiService;
  final RtcApiService rtcApiService;

  RoundTableRemoteDatasourceImpl(this.roundTableApiService, this.rtcApiService);

  @override
  Future<List<Category>> getAllRoundTableCategoriesFromRemote() async {
    final response = await roundTableApiService.getAllCategories();
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
  Future<List<Category>> getUpcomingRoundTableCategoriesFromRemote() async {
    final response = await roundTableApiService.getUpcomingTableCategories();
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
  Future<RoundTableMetaApiResponse> getRoundTableMetaFromRemote() async {
    final response = await roundTableApiService.getRoundTablesMeta();
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return RoundTableMetaApiResponse.fromJson(json);
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
  Future<AgoraRtcUserInfo> getAgoraRtcUserInfoFromRemote(String uid) async {
    final response = await rtcApiService.getRtcUserInfo(uid);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return AgoraRtcUserInfo.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }
}
