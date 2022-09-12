import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/api_result/api_result.dart';
import 'package:worknetwork/core/error/failures/failures.dart';
import 'package:worknetwork/features/auth/presentation/screens/splash/splash_screen_state.dart';
import 'package:worknetwork/features/connection/data/models/creator_response.dart';
import 'package:worknetwork/features/connection/data/repository/connection_repository.dart';
import 'package:worknetwork/features/conversations/data/repository/conversation_repository_impl.dart';
import 'package:worknetwork/features/conversations/domain/entity/webinar_entity/webinar_entity.dart';

final creatorGridStateProvider = StateNotifierProvider.family<
    CreatorGridStateNotifier,
    ApiResult<List<CreatorGridRow>>,
    String>((ref, userId) {
  return CreatorGridStateNotifier(ref.read, userId);
});

class CreatorGridRow {
  final Webinar webinar;
  bool isFollowing;

  CreatorGridRow({required this.webinar, required this.isFollowing});
}

class CreatorGridStateNotifier
    extends StateNotifier<ApiResult<List<CreatorGridRow>>> {
  final Reader read;
  final pageSize = 12;
  int page = 1;
  late bool loadingPage;
  bool allLoaded = false;
  late List<Webinar> allProfiles;
  final String userId;

  List<int> followed = [];

  CreatorGridStateNotifier(
    this.read,
    this.userId,
  ) : super(ApiResult.loading()) {
    getProfileList('');
  }

  Future<Either<Failure, FollowCreatorResponse>> getProfileList(
    String tags,
  ) async {
    page = 1;
    allLoaded = false;
    loadingPage = true;
    state = ApiResult.loading();
    final response = await read(conversationRepositoryProvider)
        .getCreators(page: page, pageSize: pageSize);

    state = response.fold(
      (failure) {
        loadingPage = false;
        return ApiResult.error(null);
      },
      (profiles) {
        allProfiles = profiles.results;
        loadingPage = false;
        allLoaded = profiles.count == allProfiles.length;
        if (userId.isNotEmpty) {
          allLoaded = true;
        }
        return mapProfilesToCreatorRow();
      },
    );

    return response;
  }

  Future<Either<Failure, FollowCreatorResponse>?> getNextPageProfileList(
    String tags,
  ) async {
    if (loadingPage == true || allLoaded == true) {
      return null;
    }
    loadingPage = true;
    page = page + 1;
    final response = await read(conversationRepositoryProvider)
        .getCreators(page: page, pageSize: pageSize);

    state = response.fold(
      (failure) {
        loadingPage = false;
        return mapProfilesToCreatorRow();
      },
      (profiles) {
        allProfiles += profiles.results;
        loadingPage = false;
        allLoaded = profiles.count == allProfiles.length;

        return mapProfilesToCreatorRow();
      },
    );
    return response;
  }

  Future<Either<Failure, Creator>> followCreator(
    int id,
    BuildContext context,
  ) async {
    final authPK = read(authStateProvider.notifier).getUser()?.pk ?? '';

    final response = await read(connectionRepositoryProvider).followCreator(
      id,
      authPK,
    );

    followed.add(id);

    final rows = allProfiles.map((e) {
      final isFollowing = (followed.contains(e.id))
          ? (true)
          : (e.hostDetail?.creatorDetail?.isFollower ?? false);
      return CreatorGridRow(webinar: e, isFollowing: isFollowing);
    });
    state = ApiResult<List<CreatorGridRow>>.data(rows.toList());

    return response;
  }

  ApiResult<List<CreatorGridRow>> mapProfilesToCreatorRow() {
    final rows = allProfiles.map((e) {
      final isFollowing = (followed.contains(e.id))
          ? (true)
          : (e.hostDetail?.creatorDetail?.isFollower ?? false);
      return CreatorGridRow(webinar: e, isFollowing: isFollowing);
    });
    return ApiResult<List<CreatorGridRow>>.data(rows.toList());
  }
}
