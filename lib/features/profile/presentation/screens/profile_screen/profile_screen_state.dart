import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kiwi/kiwi.dart';

import '../../../../../core/error/failures.dart';
import '../../../../meeting/domain/entity/meeting_interest_entity.dart';
import '../../../../meeting/domain/entity/meeting_objective_entity.dart';
import '../../../../meeting/domain/entity/user_meeting_preference_entity.dart';
import '../../../../meeting/domain/repository/meeting_repository.dart';
import '../../../data/repository/profile_repository_impl.dart';
import '../../../domain/entity/profile_entity/profile_entity.dart';
import '../../../domain/repository/profile_repository.dart';

final getProfileNotifierProvider = StateNotifierProvider.autoDispose
    .family<GetProfileNotifier, String>((ref, profileId) {
  final repository = ref.read(profileRepositoryProvider);
  final meetingRepository = KiwiContainer().resolve<MeetingRepository>();
  return GetProfileNotifier(repository, meetingRepository, profileId);
});

class GetProfileNotifier
    extends StateNotifier<AsyncValue<_ProfileScreenState>> {
  final ProfileRepository _repository;
  final MeetingRepository _meetingRepository;
  final String _profileId;

  GetProfileNotifier(this._repository, this._meetingRepository, this._profileId)
      : super(const AsyncValue<_ProfileScreenState>.loading()) {
    retrieveProfile();
  }

  Future<void> retrieveProfile() async {
    state = const AsyncValue<_ProfileScreenState>.loading();
    final response = await Future.wait([
      _repository.retrieveProfile(_profileId),
      _meetingRepository.getMeetingPreference(),
      _repository.retrieveConnections(_profileId),
    ]);

    for (int i = 0; i < response.length; i++) {
      final data = response[i];
      if (data.isLeft()) {
        final Failure error = data.getOrElse(null) as Failure;
        state = AsyncValue<_ProfileScreenState>.error(error);
        return;
      }
    }

    final Profile _profile = response[0].getOrElse(null) as Profile;
    final UserMeetingPreference _preference =
        response[1].getOrElse(null) as UserMeetingPreference;
    final connections = response[2].getOrElse(null) as List<Profile>;
    final _ProfileScreenState _profileScreenState = _ProfileScreenState(
      profile: _profile,
      interests: _preference != null ? _preference.interests : [],
      objectives: _preference != null ? _preference.objectives : [],
      connections: connections,
    );
    state = AsyncValue<_ProfileScreenState>.data(_profileScreenState);
  }
}

class _ProfileScreenState extends Equatable {
  final Profile profile;
  final List<MeetingInterest> interests;
  final List<MeetingObjective> objectives;
  final List<Profile> connections;

  const _ProfileScreenState(
      {this.profile, this.interests, this.objectives, this.connections});

  @override
  List<Object> get props => [profile, interests, objectives];
}
