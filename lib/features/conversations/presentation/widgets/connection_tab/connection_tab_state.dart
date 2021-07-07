import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/auth/domain/entity/user_tag_entity.dart';
import 'package:worknetwork/features/signup/data/repository/signup_repository_impl.dart';
import '../../../../../core/api_result/api_result.dart';
import '../../../../../core/error/failures.dart';
import '../../../../profile/data/repository/profile_repository_impl.dart';
import '../../../../profile/domain/entity/profile_entity/profile_entity.dart';

final connectionStateProvider =
    StateNotifierProvider((ref) => ConnectionStateNotifier(ref.read));
final tagStateProvider =
    StateNotifierProvider((ref) => TagStateNotifier(ref.read));

class ConnectionStateNotifier extends StateNotifier<ApiResult<List<Profile>>> {
  final Reader read;

  ConnectionStateNotifier(
    this.read,
  ) : super(ApiResult<List<Profile>>.loading()) {
    getProfileList('');
  }

  Future<Either<Failure, List<Profile>>> getProfileList(String tags) async {
    state = ApiResult<List<Profile>>.loading();
    final response =
        await read(profileRepositoryProvider).retrieveProfiles(tags);

    state = response.fold(
      (failure) => ApiResult<List<Profile>>.error(null),
      (profiles) => ApiResult<List<Profile>>.data(
        profiles.where((element) => element.name.isNotEmpty).toList(),
      ),
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
