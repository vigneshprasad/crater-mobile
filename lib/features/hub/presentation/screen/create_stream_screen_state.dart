import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/core/error/failures/failures.dart';
import 'package:worknetwork/features/conversations/data/repository/conversation_repository_impl.dart';
import 'package:worknetwork/features/conversations/domain/entity/series_entity/series_entity.dart';
import 'package:worknetwork/features/meeting/domain/repository/dyte_repository.dart';

final createStreamProvider = StateNotifierProvider.autoDispose
    .family<CreateStreamNotifier, AsyncValue<_CreateStreamScreenState>, int>(
        (ref, meetingId) {
  
  return CreateStreamNotifier(ref.read);
});

class CreateStreamNotifier
    extends StateNotifier<AsyncValue<_CreateStreamScreenState>> {
  final Reader read;

  CreateStreamNotifier(
    this.read,
  ) : super(const AsyncValue.loading()) {
    retrieveProfile();
  }

  Future<void> retrieveProfile() async {
    state = const AsyncValue.loading();

    final response =
        await read(conversationRepositoryProvider).getWebinarCategories();

    if (response.isLeft()) {
      state = AsyncValue.error(ServerFailure(message: 'something went wrong'));
      return;
    }

    final categories = response.getOrElse(() => []);

    final _profileScreenState =
        _CreateStreamScreenState(categories: categories);
    state = AsyncValue.data(_profileScreenState);
  }
}

class _CreateStreamScreenState extends Equatable {
  final List<CategoriesDetailList> categories;

  const _CreateStreamScreenState({
    required this.categories,
  });

  @override
  List<Object> get props => [
        categories,
      ];
}
