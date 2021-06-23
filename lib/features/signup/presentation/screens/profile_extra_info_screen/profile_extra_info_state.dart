import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/features/auth/presentation/bloc/auth_bloc.dart';

import '../../../../../core/api_result/api_result.dart';
import '../../../data/models/profile_extra_meta/profile_extra_meta.dart';
import '../../../data/repository/profile_meta_repository_impl.dart';

final profileFormMetaStateProvider =
    StateNotifierProvider.family<ProfileFormMetaStateNotifier, int>(
        (ref, id) => ProfileFormMetaStateNotifier(id, ref.read));

class ProfileFormMetaStateNotifier
    extends StateNotifier<ApiResult<ProfileExtraMeta>> {
  final int _tagId;
  final Reader read;
  ProfileFormMetaStateNotifier(this._tagId, this.read)
      : super(ApiResult<ProfileExtraMeta>.loading()) {
    getData();
  }

  Future<void> getData() async {
    state = ApiResult<ProfileExtraMeta>.loading();
    final result = await read(profileMetaRepositoryProvider)
        .getProfileExtraInfoMeta(_tagId);
    state = result.fold(
      (failure) => ApiResult<ProfileExtraMeta>.error(failure),
      (data) {
        final authState = KiwiContainer().resolve<AuthBloc>().state;
        final name = authState.profile != null
            ? authState.profile.name
            : authState.user.name;
        data =
            data.copyWith(question: data.question.replaceAll("{name}", name));
        return ApiResult<ProfileExtraMeta>.data(data);
      },
    );
  }
}
