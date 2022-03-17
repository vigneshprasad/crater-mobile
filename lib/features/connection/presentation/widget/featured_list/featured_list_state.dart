import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/error/failures.dart';
import 'package:worknetwork/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:worknetwork/features/connection/data/models/creator_response.dart';
import 'package:worknetwork/features/connection/data/repository/connection_repository.dart';

import '../../../../../core/api_result/api_result.dart';

final featuredConnectionStateProvider = StateNotifierProvider.family<
    FeaturedConnectionStateNotifier,
    ApiResult<List<Creator>>,
    String>((ref, userId) {
  return FeaturedConnectionStateNotifier(ref.read, userId);
});

class FeaturedConnectionStateNotifier
    extends StateNotifier<ApiResult<List<Creator>>> {
  final Reader read;
  final pageSize = 12;
  int page = 1;
  late bool loadingPage;
  bool allLoaded = false;
  late List<Creator> allProfiles;
  final String userId;

  FeaturedConnectionStateNotifier(
    this.read,
    this.userId,
  ) : super(ApiResult<List<Creator>>.loading()) {
    getProfileList('');
  }

  Future<Either<Failure, CreatorResponse>> getProfileList(String tags) async {
    page = 1;
    allLoaded = false;
    loadingPage = true;
    state = ApiResult<List<Creator>>.loading();
    final response = await read(connectionRepositoryProvider).getCreators(page, pageSize);

    state = response.fold(
      (failure) {
        loadingPage = false;
        return ApiResult<List<Creator>>.error(null);
      },
      (profiles) {
        allProfiles = profiles.results;
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

  Future<Either<Failure, CreatorResponse>?> getNextPageProfileList(
      String tags) async {
    if (loadingPage == true || allLoaded == true) {
      return null;
    }
    loadingPage = true;
    page = page + 1;
    final response = await read(connectionRepositoryProvider).getCreators(page, pageSize);

    state = response.fold(
      (failure) {
        loadingPage = false;
        return ApiResult<List<Creator>>.data(allProfiles);
      },
      (profiles) {
        allProfiles += profiles.results;
        loadingPage = false;
        allLoaded = profiles.count == allProfiles.length;

        return ApiResult<List<Creator>>.data(allProfiles);
      },
    );
    return response;
  }

  Future<Either<Failure, Creator>> followCreator(int id, BuildContext context) async {

    final authPK = BlocProvider.of<AuthBloc>(context).state.user?.pk ?? '';
    
    final response = await read(connectionRepositoryProvider)
        .followCreator(id, authPK,);

    return response;
  }
}
