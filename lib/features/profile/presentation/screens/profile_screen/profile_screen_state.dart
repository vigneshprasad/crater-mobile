import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/auth/domain/entity/user_profile_entity.dart';
import 'package:worknetwork/features/connection/data/models/creator_response.dart';
import 'package:worknetwork/features/connection/data/repository/connection_repository.dart';

import 'package:worknetwork/features/profile/data/repository/profile_repository_impl.dart';
import 'package:worknetwork/features/profile/domain/repository/profile_repository.dart';

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
    // retrieveProfile();
  }

  Future<void> retrieveProfile({int? creatorId}) async {
    final profileResponse = await _repository.retrieveProfile(_profileId);
    final _profile =
        profileResponse.getOrElse(() => UserProfile(uuid: _profileId));

    Creator? _creator;
    if (creatorId != null) {
      final creatorResponse = await _connectionRepository.getCreator(creatorId);
      _creator = creatorResponse.getOrElse(() => const Creator());
    }

    final Map<String, String> meta = {};
    if (_profile.sectorDetail != null) {
      meta['Sector'] = _profile.sectorDetail?.name ?? '';
    }
    if (_profile.companyType != null) {
      meta['Working with'] = _profile.companyTypeDetail?.name ?? '';
    }
    if (_profile.yearsOfExperience != null) {
      meta['Years of experience'] = _profile.yearOfExperienceDetail?.name ?? '';
    }
    if (_profile.educationLevel != null) {
      meta['Level of education'] = _profile.educationLevelDetail?.name ?? '';
    }
    if (_profile.projectType != null) {
      meta['Project'] = _profile.projectTypeDetail?.name ?? '';
    }
    if (_profile.stageOfCompany != null) {
      meta['Stage of Company'] = _profile.stageOfCompanyDetail?.name ?? '';
    }
    if (_profile.companiesInvestedDetail != null) {
      meta['Invested in companies'] =
          _profile.companiesInvestedDetail?.name ?? '';
    }
    if (_profile.numberOfEmployeesDetail != null) {
      meta['Employees count'] = _profile.numberOfEmployeesDetail?.name ?? '';
    }
    if (_profile.companyTypeAdvisedDetail != null) {
      meta['Company Advised'] = _profile.companyTypeAdvisedDetail?.name ?? '';
    }

    final _ProfileScreenState _profileScreenState = _ProfileScreenState(
      profile: _profile,
      meta: meta,
      creator: _creator,
    );

    if (mounted) {
      state = AsyncValue<_ProfileScreenState>.data(_profileScreenState);
    }
  }
}

class _ProfileScreenState extends Equatable {
  final UserProfile profile;
  final Map<String, String> meta;
  final Creator? creator;

  const _ProfileScreenState({
    required this.profile,
    required this.meta,
    this.creator,
  });

  @override
  List<Object> get props => [
        profile,
        meta,
      ];
}
