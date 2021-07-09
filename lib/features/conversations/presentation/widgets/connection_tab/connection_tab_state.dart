import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/api_result/api_result.dart';
import '../../../../../core/error/failures.dart';
import '../../../../auth/domain/entity/user_tag_entity.dart';
import '../../../../profile/data/repository/profile_repository_impl.dart';
import '../../../../profile/domain/entity/profile_entity/profile_entity.dart';
import '../../../../signup/data/repository/signup_repository_impl.dart';

final connectionStateProvider =
    StateNotifierProvider((ref) => ConnectionStateNotifier(ref.read));
final tagStateProvider =
    StateNotifierProvider((ref) => TagStateNotifier(ref.read));

class ConnectionStateNotifier extends StateNotifier<ApiResult<List<Profile>>> {
  final Reader read;
  int page = 1;
  bool loadingPage;
  bool allLoaded = false;
  List<Profile> allProfiles;

  ConnectionStateNotifier(
    this.read,
  ) : super(ApiResult<List<Profile>>.loading()) {
    getProfileList('');
  }

  Future<Either<Failure, List<Profile>>> getProfileList(String tags) async {
    page = 1;
    allLoaded = false;
    loadingPage = true;
    state = ApiResult<List<Profile>>.loading();
    final response =
        await read(profileRepositoryProvider).retrieveProfiles(tags, page);

    state = response.fold(
      (failure) {
        loadingPage = false;
        return ApiResult<List<Profile>>.error(null);
      },
      (profiles) {
        allProfiles = profiles;
        loadingPage = false;
        allLoaded = profiles.isEmpty;
        return ApiResult<List<Profile>>.data(allProfiles);
      },
    );

    return response;
  }

  Future<Either<Failure, List<Profile>>> getNextPageProfileList(
      String tags) async {
    if (loadingPage == true || allLoaded == true) {
      return null;
    }
    loadingPage = true;
    page = page + 1;
    final response =
        await read(profileRepositoryProvider).retrieveProfiles(tags, page);

    state = response.fold(
      (failure) {
        loadingPage = false;
        return ApiResult<List<Profile>>.error(null);
      },
      (profiles) {
        allProfiles += profiles;
        loadingPage = false;
        allLoaded = profiles.isEmpty;
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
