import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/auth/domain/entity/user_profile_entity.dart';
import 'package:worknetwork/features/connection/data/models/creator_response.dart';
import 'package:worknetwork/features/connection/data/repository/connection_repository.dart';

import '../../../data/repository/profile_repository_impl.dart';
import '../../../domain/repository/profile_repository.dart';

final getProfileNotifierProvider = StateNotifierProvider.autoDispose
    .family<GetProfileNotifier, AsyncValue<_ProfileScreenState>, String>(
        (ref, profileId) {
  final repository = ref.read(profileRepositoryProvider);
  final connectionRepository = ref.read(connectionRepositoryProvider);

  return GetProfileNotifier(
    repository,
    connectionRepository,
    profileId,
  );
});

class GetProfileNotifier
    extends StateNotifier<AsyncValue<_ProfileScreenState>> {
  final ProfileRepository _repository;
  final ConnectionRepository _connectionRepository;
  final String _profileId;

  GetProfileNotifier(
    this._repository,
    this._connectionRepository,
    this._profileId,
  ) : super(const AsyncValue<_ProfileScreenState>.loading()) {
    retrieveProfile();
  }

  Future<void> retrieveProfile() async {
    state = const AsyncValue<_ProfileScreenState>.loading();
    // final response = await Future.wait([
    // _meetingRepository.getMeetingPreference(),
    // _repository.retrieveConnections(_profileId),
    // _profileIntroRepository.getCompanies(),
    // _profileIntroRepository.getEducations(),
    // _profileIntroRepository.getExperiences(),
    // _profileIntroRepository.getSectors(),
    // _authRepository.getUserProfile(),
    // ]);

    // for (int i = 0; i < response.length; i++) {
    //   final data = response[i];
    //   if (data.isLeft()) {
    //     final error = data.swap().getOrElse(() => ServerFailure());
    //     state = AsyncValue<_ProfileScreenState>.error(error);
    //     return;
    //   }
    // }

    final profileResponse = await _repository.retrieveProfile(_profileId);
    final _profile = profileResponse
        .getOrElse(() => UserProfile(uuid: _profileId)) as UserProfile;

    final creatorResponse =
        await _connectionRepository.getCreator(_profile.pk!);
    final _creator =
        creatorResponse.getOrElse(() => const Creator()) as Creator;
    // final UserMeetingPreference _preference = response[1]
    //     .getOrElse(() => UserMeetingPreference()) as UserMeetingPreference;
    // final connections =
    //     response[2].getOrElse(() => List<Profile>.empty()) as List<Profile>;

    // final companies =
    //     response[3].getOrElse(() => List<ProfileIntroMeta>.empty())
    //         as List<ProfileIntroMeta>;
    // final educations =
    //     response[4].getOrElse(() => List<ProfileIntroMeta>.empty())
    //         as List<ProfileIntroMeta>;
    // final experiences =
    //     response[5].getOrElse(() => List<ProfileIntroMeta>.empty())
    //         as List<ProfileIntroMeta>;
    // final sectors = response[6].getOrElse(() => List<ProfileIntroMeta>.empty())
    //     as List<ProfileIntroMeta>;
    // final user = response[1].getOrElse(() => UserProfile()) as UserProfile;

    // final Map<String, String> meta = {};
    // if (_profile.tag?.first.name != null) {
    //   meta['Profession'] = _profile.tag?.first.name ?? '';
    // }
    // if (user.sector != null) {
    //   meta['Sector'] =
    //       sectors.firstWhere((element) => element.value == user.sector).name ??
    //           '';
    // }
    // if (user.companyType != null) {
    //   meta['Working with'] = companies
    //           .firstWhere((element) => element.value == user.companyType)
    //           .name ??
    //       '';
    // }
    // if (user.yearsOfExperience != null) {
    //   meta['Years of experience'] = experiences
    //           .firstWhere((element) => element.value == user.yearsOfExperience)
    //           .name ??
    //       '';
    // }
    // if (user.educationLevel != null) {
    //   meta['Level of education'] = educations
    //           .firstWhere((element) => element.value == user.educationLevel)
    //           .name ??
    //       '';
    // }

    final _ProfileScreenState _profileScreenState = _ProfileScreenState(
      profile: _profile,
      // interests: [],
      // objectives: [],
      // connections: [],
      meta: {},
      creator: _creator,
    );

    if (mounted) {
      state = AsyncValue<_ProfileScreenState>.data(_profileScreenState);
    }
  }
}

class _ProfileScreenState extends Equatable {
  final UserProfile profile;
  // final List<MeetingInterest> interests;
  // final List<MeetingObjective> objectives;
  // final List<Profile>? connections;
  final Map<String, String> meta;
  final Creator? creator;

  const _ProfileScreenState({
    required this.profile,
    // required this.interests,
    // required this.objectives,
    // this.connections,
    required this.meta,
    this.creator,
  });

  @override
  List<Object> get props => [
        profile,
        // interests,
        // objectives,
        meta,
      ];
}
