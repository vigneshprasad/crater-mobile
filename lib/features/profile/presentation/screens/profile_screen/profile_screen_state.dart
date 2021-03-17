import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/core/error/failures.dart';
import 'package:worknetwork/features/meeting/domain/entity/meeting_interest_entity.dart';
import 'package:worknetwork/features/meeting/domain/entity/meeting_objective_entity.dart';
import 'package:worknetwork/features/meeting/domain/entity/user_meeting_preference_entity.dart';
import 'package:worknetwork/features/meeting/domain/repository/meeting_repository.dart';
import 'package:worknetwork/features/profile/data/repository/profile_repository_impl.dart';
import 'package:worknetwork/features/profile/domain/entity/profile_entity/profile_entity.dart';
import 'package:worknetwork/features/profile/domain/repository/profile_repository.dart';

final getProfileNotifierProvider = StateNotifierProvider.autoDispose
    .family<GetProfileNotifier, String>((ref, profileId) {
  final repository = ref.read(profileRepositoryProvider);
  final meetingRepository = KiwiContainer().resolve<MeetingRepository>();
  return GetProfileNotifier(repository, meetingRepository, profileId);
});

class GetProfileNotifier extends StateNotifier<AsyncValue<_ProfileScreenState>> {
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
    ]); 

    for(int i=0; i<response.length; i++) {
      final data = response[i];
      if (data.isLeft()) {
        final Failure error = data.getOrElse(null) as Failure;
        state = AsyncValue<_ProfileScreenState>.error(error);
        return;
      }
    } 
    
    final Profile _profile = response[0].getOrElse(null) as Profile;
    final UserMeetingPreference _preference = response[1].getOrElse(null) as UserMeetingPreference;
    final _ProfileScreenState _profileScreenState = _ProfileScreenState(_profile, _preference != null ? _preference.interests : [], _preference != null ? _preference.objectives : []);
    state = AsyncValue<_ProfileScreenState>.data(_profileScreenState);
  }
}

class _ProfileScreenState extends Equatable {
  final Profile profile;
  final List<MeetingInterest> interests;
  final List<MeetingObjective> objectives;

  const _ProfileScreenState(this.profile, this.interests, this.objectives);

  @override
  List<Object> get props => [profile, interests, objectives];
}
