import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/error/failures.dart';
import 'package:worknetwork/features/connection/data/models/creator_response.dart';
import 'package:worknetwork/features/connection/data/repository/connection_repository.dart';
import 'package:worknetwork/features/meeting/data/repository/meeting_respository_impl.dart';

import '../../../../../core/api_result/api_result.dart';
import '../../../../auth/domain/entity/user_tag_entity.dart';
import '../../../../profile/data/repository/profile_repository_impl.dart';
import '../../../../profile/domain/entity/profile_entity/profile_entity.dart';
import '../../../../signup/data/repository/signup_repository_impl.dart';

final connectionStateProvider = StateNotifierProvider.family<
    ConnectionStateNotifier, ApiResult<List<Profile>>, String>((ref, userId) {
  return ConnectionStateNotifier(ref.read, userId);
});

final tagStateProvider =
    StateNotifierProvider<TagStateNotifier, ApiResult<List<UserTag>>>(
        (ref) => TagStateNotifier(ref.read));

class ConnectionStateNotifier extends StateNotifier<ApiResult<List<Profile>>> {
  final Reader read;
  final pageSize = 10;
  int page = 1;
  late bool loadingPage;
  bool allLoaded = false;
  late List<Profile> allProfiles;
  final String userId;

  ConnectionStateNotifier(
    this.read,
    this.userId,
  ) : super(ApiResult<List<Profile>>.loading()) {
    getProfileList('');
  }

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

  Future<Either<Failure, List<Profile>>?> getNextPageProfileList(
      String tags) async {
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

class TagStateNotifier extends StateNotifier<ApiResult<List<UserTag>>> {
  final Reader read;

  TagStateNotifier(
    this.read,
  ) : super(ApiResult<List<UserTag>>.loading()) {
    getTagList();
  }

  Future<Either<Failure, List<UserTag>>> getTagList() async {
    state = ApiResult<List<UserTag>>.loading();
    final response = await read(signupRepositoryProvider).getUserTags();

    state = response.fold(
      (failure) => ApiResult<List<UserTag>>.error(null),
      (tags) => ApiResult<List<UserTag>>.data(tags),
    );

    return response;
  }
}
