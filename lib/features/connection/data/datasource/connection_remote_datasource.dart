import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/error/exceptions.dart';
import 'package:worknetwork/features/connection/data/models/creator_response.dart';

import 'package:worknetwork/features/connection/data/service/connection_api_service/connection_api_service.dart';

final connectionRemoteDatasourceProvider = Provider<ConnectionRemoteDatasource>(
    (ref) => ConnectionRemoteDatasourceImpl(ref.read));

abstract class ConnectionRemoteDatasource {
  Future<CreatorResponse> getCreatorsFromRemote({bool certified});
  Future<Creator> getCreatorFromRemote(int id);
}

class ConnectionRemoteDatasourceImpl implements ConnectionRemoteDatasource {
  final Reader read;

  ConnectionRemoteDatasourceImpl(this.read);

  @override
  Future<CreatorResponse> getCreatorsFromRemote({bool certified = true}) async {
    final response = await read(connectionApiServiceProvider)
        .getCreators({'certified': 'true'});
    if (response.statusCode == 200) {
      if (response.bodyString == '[]') {
        throw ServerException('Empty');
      }
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return CreatorResponse.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<Creator> getCreatorFromRemote(int id) async {
    final response = await read(connectionApiServiceProvider).getCreator(id);
    if (response.statusCode == 200) {
      if (response.bodyString == '[]') {
        throw ServerException('Empty');
      }
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return Creator.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }
}
