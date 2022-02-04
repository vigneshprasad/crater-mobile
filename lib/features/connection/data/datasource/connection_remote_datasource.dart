import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/error/exceptions.dart';
import 'package:worknetwork/features/connection/data/models/creator_response.dart';

import 'package:worknetwork/features/connection/data/service/connection_api_service/connection_api_service.dart';
import 'package:worknetwork/features/profile/domain/entity/profile_entity/profile_entity.dart';

final connectionRemoteDatasourceProvider = Provider<ConnectionRemoteDatasource>(
    (ref) => ConnectionRemoteDatasourceImpl(ref.read));

abstract class ConnectionRemoteDatasource {
  Future<CreatorResponse> getCreatorsFromRemote(int page, int pageSize, {bool certified});
  Future<Creator> getCreatorFromRemote(int id);
  Future<List<Profile>> getCommunityMembersFromRemote(
      String community, int page);
}

class ConnectionRemoteDatasourceImpl implements ConnectionRemoteDatasource {
  final Reader read;

  ConnectionRemoteDatasourceImpl(this.read);

  @override
  Future<CreatorResponse> getCreatorsFromRemote(int page, int pageSize,
      {bool certified = true}) async {
    final response = await read(connectionApiServiceProvider)
        .getCreators({'certified': 'true', 'page': page, 'page_size': pageSize});
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

  @override
  Future<List<Profile>> getCommunityMembersFromRemote(
      String community, int page) async {
    final body = {
      "community": community,
      "page": page,
      'page_size': 10,
    };
    final response =
        await read(connectionApiServiceProvider).getCommunityMembers(body);
    if (response.statusCode == 200) {
      if (response.bodyString == '[]') {
        throw ServerException('Empty');
      }

      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      final jsonList = json['results'] as List;

      final list = jsonList.map((communityMember) {
        final profile = communityMember['profile_detail'] as Map?;
        return Profile.fromJson(profile as Map<String, dynamic>);
      }).toList();
      return list;
    } else {
      throw ServerException(response.error);
    }
  }
}
