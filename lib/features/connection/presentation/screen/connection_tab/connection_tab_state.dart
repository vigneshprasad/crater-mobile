import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/api_result/api_result.dart';
import 'package:worknetwork/core/error/failures/failures.dart';
import 'package:worknetwork/features/profile/data/repository/profile_repository_impl.dart';
import 'package:worknetwork/features/profile/domain/entity/profile_entity/profile_entity.dart';
import 'package:worknetwork/features/profile/presentation/screens/profile_screen/community_list_state.dart';

final connectionStateProvider = StateNotifierProvider.family<
    ConnectionStateNotifier, ApiResult<List<Profile>>, String>((ref, userId) {
  return ConnectionStateNotifier(ref.read, userId);
});

class ConnectionStateNotifier
    extends ProfileListStateNotifier<ApiResult<List<Profile>>> {
  final Reader read;
  final pageSize = 10;
  int page = 1;
  late bool loadingPage;
  late List<Profile> allProfiles;
  final String userId;

  ConnectionStateNotifier(
    this.read,
    this.userId,
  ) : super(ApiResult<List<Profile>>.loading()) {
    getProfileList('');
  }

  @override
  Future<Either<Failure, List<Profile>>> getProfileList(String tags) async {
    page = 1;
    allLoaded = false;
    loadingPage = true;
    state = ApiResult<List<Profile>>.loading();
    final response = await read(profileRepositoryProvider)
        .retrieveProfiles(tags, page, pageSize, userId);

    state = response.fold(
      (failure) {
        loadingPage = false;
        return ApiResult<List<Profile>>.error(null);
      },
      (profiles) {
        allProfiles = profiles;
        loadingPage = false;
        allLoaded = profiles.isEmpty || profiles.length < pageSize;
        if (userId.isNotEmpty) {
          allLoaded = true;
        }
        return ApiResult<List<Profile>>.data(allProfiles);
      },
    );

    return response;
  }

  @override
  Future<Either<Failure, List<Profile>>?> getNextPageProfileList(
    String tags,
  ) async {
    if (loadingPage == true || allLoaded == true) {
      return null;
    }
    loadingPage = true;
    page = page + 1;
    final response = await read(profileRepositoryProvider)
        .retrieveProfiles(tags, page, pageSize, userId);

    state = response.fold(
      (failure) {
        loadingPage = false;
        return ApiResult<List<Profile>>.data(allProfiles);
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
