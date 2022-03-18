import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/error/failures.dart' as F;
import 'package:worknetwork/core/error/failures/failures.dart';
import 'package:worknetwork/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:worknetwork/features/connection/data/models/creator_response.dart';
import 'package:worknetwork/features/connection/data/repository/connection_repository.dart';
import 'package:worknetwork/features/conversations/data/repository/conversation_repository_impl.dart';
import 'package:worknetwork/features/conversations/domain/entity/webinar_entity/webinar_entity.dart';

import '../../../../../core/api_result/api_result.dart';

final creatorStateProvider = StateNotifierProvider.family<
    CreatorStateNotifier,
    ApiResult<List<Creator>>,
    String>((ref, userId) {
  return CreatorStateNotifier(ref.read, userId);
});

class CreatorStateNotifier
    extends StateNotifier<ApiResult<List<Creator>>> {
  final Reader read;
  final pageSize = 12;
  int page = 1;
  late bool loadingPage;
  bool allLoaded = false;
  late List<Creator> allProfiles;
  final String userId;

  CreatorStateNotifier(
    this.read,
    this.userId,
  ) : super(ApiResult<List<Creator>>.loading()) {
    getProfileList('');
  }

  Future<Either<Failure, FollowCreatorResponse>> getProfileList(String tags) async {
    page = 1;
    allLoaded = false;
    loadingPage = true;
    state = ApiResult<List<Creator>>.loading();
    final response = await read(conversationRepositoryProvider).getCreators(page: page, pageSize: pageSize);

    state = response.fold(
      (failure) {
        loadingPage = false;
        return ApiResult<List<Creator>>.error(null);
      },
      (profiles) {
        allProfiles = creatorsFrom(profiles.results);
        loadingPage = false;
        allLoaded = profiles.count == allProfiles.length;
        if (userId.isNotEmpty) {
          allLoaded = true;
        }
        return ApiResult<List<Creator>>.data(allProfiles);
      },
    );

    return response;
  }

  List<Creator> creatorsFrom(List<Webinar> webinars) {
     List<Creator> creators = [];

      webinars.forEach((element) {
        final creator = element.hostDetail?.creatorDetail;
        if (creator != null && creator.isFollower == false) {
          creators.add(creator);
        }
      });

      return creators;
  }

  Future<Either<Failure, FollowCreatorResponse>?> getNextPageProfileList(
      String tags) async {
    if (loadingPage == true || allLoaded == true) {
      return null;
    }
    loadingPage = true;
    page = page + 1;
    final response = await read(conversationRepositoryProvider).getCreators(page: page, pageSize: pageSize);

    state = response.fold(
      (failure) {
        loadingPage = false;
        return ApiResult<List<Creator>>.data(allProfiles);
      },
      (profiles) {
        allProfiles += creatorsFrom(profiles.results);
        loadingPage = false;
        allLoaded = profiles.count == allProfiles.length;

        return ApiResult<List<Creator>>.data(allProfiles);
      },
    );
    return response;
  }

  Future<Either<F.Failure, Creator>> followCreator(int id, BuildContext context) async {

    final authPK = BlocProvider.of<AuthBloc>(context).state.user?.pk ?? '';
    
    final response = await read(connectionRepositoryProvider)
        .followCreator(id, authPK,);

    return response;
  }
}
