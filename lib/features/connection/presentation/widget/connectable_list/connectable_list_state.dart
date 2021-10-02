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

  ConnectableListStateNotifier(this.read, this.tag)
      : super(ApiResult<List<Profile>>.loading()) {
    getConnectableProfileList(tag);
  }

  Future<Either<Failure, List<Profile>>> getConnectableProfileList(
      String tags) async {
    state = ApiResult<List<Profile>>.loading();

    final response =
        await read(profileRepositoryProvider).retrieveProfiles(tags, 1, 5, '');

    state = response.fold(
      (failure) {
        return ApiResult<List<Profile>>.error(null);
      },
      (profiles) {
        return ApiResult<List<Profile>>.data(profiles);
      },
    );

    return response;
  }
}
