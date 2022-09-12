import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/error/failures/failures.dart';
import 'package:worknetwork/features/auth/data/models/api/referrals_response_model.dart';
import 'package:worknetwork/features/auth/data/repository/auth_repository_impl.dart';

final walletScreenProvider = StateNotifierProvider.autoDispose
    .family<WalletScreenNotifier, AsyncValue<_WalletScreenState>, int>(
        (ref, meetingId) {
  return WalletScreenNotifier(ref.read);
});

class WalletScreenNotifier
    extends StateNotifier<AsyncValue<_WalletScreenState>> {
  final Reader read;

  int page = 1;
  final pageSize = 20;
  List<Referral> referrals = [];
  bool isLoading = false;

  WalletScreenNotifier(
    this.read,
  ) : super(const AsyncValue.loading()) {
    retrieveReferral();
  }

  Future<void> retrieveReferral() async {
    state = const AsyncValue.loading();

    final response =
        await read(authRepositoryProvider).getReferrals(page, pageSize);

    if (response.isLeft()) {
      state = AsyncValue.error(ServerFailure('something went wrong'));
      return;
    }

    final data = response.getOrElse(() => const ReferralsResponse());

    referrals = data.results ?? [];

    final _profileScreenState = _WalletScreenState(referrals: referrals);
    state = AsyncValue.data(_profileScreenState);
  }

  Future<void> retrieveNextPage() async {
    if (isLoading) {
      return;
    }

    isLoading = true;
    page += 1;

    final response =
        await read(authRepositoryProvider).getReferrals(page, pageSize);

    if (response.isLeft()) {
      return;
    }

    final data = response.getOrElse(() => const ReferralsResponse());

    referrals += data.results ?? [];

    final _profileScreenState = _WalletScreenState(referrals: referrals);
    state = AsyncValue.data(_profileScreenState);

    isLoading = false;
  }
}

class _WalletScreenState extends Equatable {
  final List<Referral> referrals;

  const _WalletScreenState({
    required this.referrals,
  });

  @override
  List<Object> get props => [referrals];
}
