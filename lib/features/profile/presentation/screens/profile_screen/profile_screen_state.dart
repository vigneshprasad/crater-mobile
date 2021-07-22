import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/features/auth/domain/entity/user_profile_entity.dart';
import 'package:worknetwork/features/auth/domain/repository/auth_repository.dart';
import 'package:worknetwork/features/signup/domain/entity/profile_intro_meta.dart';
import 'package:worknetwork/features/signup/domain/repository/profile_intro_repository.dart';

import '../../../../../core/error/failures.dart';
import '../../../../meeting/domain/entity/meeting_interest_entity.dart';
import '../../../../meeting/domain/entity/meeting_objective_entity.dart';
import '../../../../meeting/domain/entity/user_meeting_preference_entity.dart';
import '../../../../meeting/domain/repository/meeting_repository.dart';
import '../../../data/repository/profile_repository_impl.dart';
import '../../../domain/entity/profile_entity/profile_entity.dart';
import '../../../domain/repository/profile_repository.dart';

final getProfileNotifierProvider = StateNotifierProvider.autoDispose
    .family<GetProfileNotifier, AsyncValue<_ProfileScreenState>, String>(
        (ref, profileId) {
  final repository = ref.read(profileRepositoryProvider);
  final meetingRepository = KiwiContainer().resolve<MeetingRepository>();
  final authRepository = KiwiContainer().resolve<AuthRepository>();
  final profileIntroRepository =
      KiwiContainer().resolve<ProfileIntroRepository>();

  return GetProfileNotifier(
    repository,
    meetingRepository,
    profileId,
    profileIntroRepository,
    authRepository,
  );
});

class GetProfileNotifier
    extends StateNotifier<AsyncValue<_ProfileScreenState>> {
  final ProfileRepository _repository;
  final AuthRepository _authRepository;
  final MeetingRepository _meetingRepository;
  final ProfileIntroRepository _profileIntroRepository;
  final String _profileId;

  GetProfileNotifier(
    this._repository,
    this._meetingRepository,
    this._profileId,
    this._profileIntroRepository,
    this._authRepository,
  ) : super(const AsyncValue<_ProfileScreenState>.loading()) {
    retrieveProfile();
  }

  Future<void> retrieveProfile() async {
    state = const AsyncValue<_ProfileScreenState>.loading();
    final response = await Future.wait([
      _repository.retrieveProfile(_profileId),
      _meetingRepository.getMeetingPreference(),
      _repository.retrieveConnections(_profileId),
      _profileIntroRepository.getCompanies(),
      _profileIntroRepository.getEducations(),
      _profileIntroRepository.getExperiences(),
      _profileIntroRepository.getSectors(),
      _authRepository.getUserProfile(),
    ]);

    for (int i = 0; i < response.length; i++) {
      final data = response[i];
      if (data.isLeft()) {
        final error = data.getOrElse(() => null) as Failure?;
        state = AsyncValue<_ProfileScreenState>.error(error!);
        return;
      }
    }

    final _profile = response[0].getOrElse(() => null) as Profile?;
    final UserMeetingPreference? _preference =
        response[1].getOrElse(() => null) as UserMeetingPreference?;
    final connections = response[2].getOrElse(() => null) as List<Profile>?;

    final companies =
        response[3].getOrElse(() => null) as List<ProfileIntroMeta>?;
    final educations =
        response[4].getOrElse(() => null) as List<ProfileIntroMeta>?;
    final experiences =
        response[5].getOrElse(() => null) as List<ProfileIntroMeta>?;
    final sectors =
        response[6].getOrElse(() => null) as List<ProfileIntroMeta>?;
    final user = response[7].getOrElse(() => null) as UserProfile?;

    final Map<String, String> meta = {
      'Profession': _profile?.tag?.first.name ?? '',
      'Sector': sectors
              ?.firstWhere((element) => element.value == user?.sector)
              .name ??
          '',
      'Working with': companies
              ?.firstWhere((element) => element.value == user?.companyType)
              .name ??
          '',
      'Years of experience': experiences
              ?.firstWhere(
                  (element) => element.value == user?.yearsOfExperience)
              .name ??
          '',
      'Level of education': educations
              ?.firstWhere((element) => element.value == user?.educationLevel)
              .name ??
          '',
    };

    final _ProfileScreenState _profileScreenState = _ProfileScreenState(
      profile: _profile!,
      interests: _preference != null ? _preference.interests : [],
      objectives: _preference != null ? _preference.objectives! : [],
      connections: connections,
      meta: meta,
    );
    state = AsyncValue<_ProfileScreenState>.data(_profileScreenState);
  }
}

class _ProfileScreenState extends Equatable {
  final Profile profile;
  final List<MeetingInterest> interests;
  final List<MeetingObjective> objectives;
  final List<Profile>? connections;
  final Map<String, String> meta;

  const _ProfileScreenState({
    required this.profile,
    required this.interests,
    required this.objectives,
    this.connections,
    required this.meta,
  });

  @override
  List<Object> get props => [
        profile,
        interests,
        objectives,
        meta,
      ];
}
