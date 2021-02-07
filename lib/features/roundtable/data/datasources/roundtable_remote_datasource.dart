import 'dart:convert';

import 'package:hooks_riverpod/all.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entity/category_entity/category_entity.dart';
import '../../domain/entity/roundtable_entity/roundtable_entity.dart';
import '../models/roundtable_meta_api_response/roundtable_meta_api_response.dart';
import '../services/round_table_api_service/roundtable_api_service.dart';

final roundTableRemoteDatasourceProvider =
    Provider<RoundTableRemoteDatasource>((ref) {
  final RoundTableApiService apiService =
      ref.read(roundTableApiServiceProvider);
  return RoundTableRemoteDatasourceImpl(apiService);
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
}

class RoundTableRemoteDatasourceImpl implements RoundTableRemoteDatasource {
  final RoundTableApiService apiService;

  RoundTableRemoteDatasourceImpl(this.apiService);

  @override
  Future<List<Category>> getAllRoundTableCategoriesFromRemote() async {
    final response = await apiService.getAllCategories();
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
    final response = await apiService.getUserTableCategories();
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
    final response = await apiService.getUpcomingTableCategories();
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
    final response = await apiService.getRoundTables();
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
    final response = await apiService.getMyRoundTables();
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
    final response = await apiService.getRoundTablesMeta();
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return RoundTableMetaApiResponse.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<RoundTable> retrieveRoundTableFromRemote(int id) async {
    final response = await apiService.retrieveRoundTable(id);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return RoundTable.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }
}
