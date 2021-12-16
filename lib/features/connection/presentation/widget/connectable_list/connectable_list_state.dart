import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/error/failures.dart';
import 'package:worknetwork/features/profile/data/repository/profile_repository_impl.dart';

import '../../../../../core/api_result/api_result.dart';
import '../../../../profile/domain/entity/profile_entity/profile_entity.dart';

final connectableStateProvider = StateNotifierProvider.family<
    ConnectableListStateNotifier,
    ApiResult<List<Profile>>,
    String>((ref, tag) => ConnectableListStateNotifier(ref.read, tag));

class ConnectableListStateNotifier
    extends StateNotifier<ApiResult<List<Profile>>> {
  final Reader read;
  final String tag;
  late bool loadingPage;
  final pageSize = 10;
  int page = 1;
  late List<Profile> allProfiles;
  bool allLoaded = false;

  ConnectableListStateNotifier(this.read, this.tag)
      : super(ApiResult<List<Profile>>.loading()) {
    getConnectableProfileList(tag);
  }

  Future<Either<Failure, List<Profile>>> getConnectableProfileList(
      String tags) async {
    state = ApiResult<List<Profile>>.loading();
    page = 1;
    allLoaded = false;
    loadingPage = true;
    final response = await read(profileRepositoryProvider)
        .retrieveProfiles(tags, page, pageSize, '');

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

  Future<Either<Failure, List<Profile>>?> getNextPageConnectableProfileList(
      String tags) async {
    if (loadingPage == true || allLoaded == true) {
      return null;
    }
    loadingPage = true;
    page = page + 1;

    final response = await read(profileRepositoryProvider)
        .retrieveProfiles(tags, page, pageSize, '');

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
