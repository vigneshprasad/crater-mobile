import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/api_result/api_result.dart';
import 'package:worknetwork/core/error/failures.dart';
import 'package:worknetwork/features/connection/data/repository/connection_repository.dart';
import 'package:worknetwork/features/profile/domain/entity/profile_entity/profile_entity.dart';

final communityStateProvider = StateNotifierProvider.family<
    CommunityStateNotifier, ApiResult<List<Profile>>, String>((ref, community) {
  return CommunityStateNotifier(ref.read, community);
});

abstract class ProfileListStateNotifier<T> extends StateNotifier<T> {
  ProfileListStateNotifier(T state) : super(state);

  bool allLoaded = false;
  Future<Either<Failure, List<Profile>>?> getNextPageProfileList(String tags);
  Future<Either<Failure, List<Profile>>> getProfileList(String community);
}

class CommunityStateNotifier
    extends ProfileListStateNotifier<ApiResult<List<Profile>>> {
  final Reader read;
  final pageSize = 10;
  int page = 1;
  late bool loadingPage;
  late List<Profile> allProfiles;
  final String community;

  CommunityStateNotifier(
    this.read,
    this.community,
  ) : super(ApiResult<List<Profile>>.loading()) {
    getProfileList(community);
  }

  @override
  Future<Either<Failure, List<Profile>>> getProfileList(
      String community) async {
    page = 1;
    allLoaded = false;
    loadingPage = true;
    state = ApiResult<List<Profile>>.loading();
    final response = await read(connectionRepositoryProvider)
        .getCommunityMembers(community, page);

    state = response.fold(
      (failure) {
        loadingPage = false;
        return ApiResult<List<Profile>>.error(null);
      },
      (profiles) {
        allProfiles = profiles;
        loadingPage = false;
        allLoaded = profiles.isEmpty || profiles.length < pageSize;
        return ApiResult<List<Profile>>.data(allProfiles);
      },
    );

    return response;
  }

  @override
  Future<Either<Failure, List<Profile>>?> getNextPageProfileList(
      String tags) async {
    if (loadingPage == true || allLoaded == true) {
      return null;
    }
    loadingPage = true;
    page = page + 1;
    final response = await read(connectionRepositoryProvider)
        .getCommunityMembers(community, page);

    state = response.fold(
      (failure) {
        loadingPage = false;
        return ApiResult<List<Profile>>.error(null);
      },
      (profiles) {
        allProfiles += profiles;
        loadingPage = false;
        allLoaded = profiles.isEmpty || profiles.length < pageSize;
        return ApiResult<List<Profile>>.data(allProfiles);
      },
    );
    return response;
  }
}
