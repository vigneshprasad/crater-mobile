import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/error/failures/failures.dart';
import 'package:worknetwork/features/auth/data/repository/auth_repository_impl.dart';
import 'package:worknetwork/features/conversations/domain/entity/conversation_entity/conversation_entity.dart';

final hubScreenProvider = StateNotifierProvider.autoDispose
    .family<HubScreenNotifier, AsyncValue<_HubScreenState>, int>(
        (ref, meetingId) {
  return HubScreenNotifier(ref.read);
});

class HubScreenNotifier extends StateNotifier<AsyncValue<_HubScreenState>> {
  final Reader read;

  HubScreenNotifier(
    this.read,
  ) : super(const AsyncValue.loading()) {
    retrieveProfile();
  }

  Future<void> retrieveProfile() async {
    state = const AsyncValue.loading();

    final response = await read(authRepositoryProvider).getUserPermission();

    if (response.isLeft()) {
      state = AsyncValue.error(ServerFailure('something went wrong'));
      return;
    }

    final permission = response.getOrElse(
      () => UserPermission(allowChat: false, allowCreateStream: false),
    );

    final _profileScreenState = _HubScreenState(permission: permission);
    state = AsyncValue.data(_profileScreenState);
  }
}

class _HubScreenState extends Equatable {
  final UserPermission permission;

  const _HubScreenState({
    required this.permission,
  });

  @override
  List<Object> get props => [permission];
}
