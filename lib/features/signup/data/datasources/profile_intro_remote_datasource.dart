import 'dart:convert';
import 'dart:io';

import '../../../../api/profile_intro/profile_intro_api_service.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/file_utils/file_converter.dart';
import '../../../auth/data/models/user_profile_model.dart';
import '../../../auth/domain/entity/user_profile_entity.dart';
import '../../domain/entity/profile_intro_meta.dart';
import '../models/profile_intro_meta_model.dart';

abstract class ProfileIntroRemoteDatasource {
  Future<List<ProfileIntroMeta>> getCompaniesFromRemote();
  Future<List<ProfileIntroMeta>> getSectorsFromRemote();
  Future<List<ProfileIntroMeta>> getExperiencesFromRemote();
  Future<List<ProfileIntroMeta>> getEducationsFromRemote();
  Future<UserProfile> postUserProfile(Map<String, dynamic> body, File? photo);
}

class ProfileIntroRemoteDatasourceImpl implements ProfileIntroRemoteDatasource {
  final ProfileIntroApiService profileIntroApiService;

  ProfileIntroRemoteDatasourceImpl(this.profileIntroApiService);

  @override
  Future<List<ProfileIntroMeta>> getCompaniesFromRemote() async {
    final response = await profileIntroApiService.getCompanies();
    if (response.statusCode == 200) {
      final Iterable list = jsonDecode(response.bodyString) as Iterable;
      return list
          .map((e) => ProfileIntroMetaModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<List<ProfileIntroMeta>> getEducationsFromRemote() async {
    final response = await profileIntroApiService.getEducations();
    if (response.statusCode == 200) {
      final Iterable list = jsonDecode(response.bodyString) as Iterable;
      return list
          .map((e) => ProfileIntroMetaModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<List<ProfileIntroMeta>> getSectorsFromRemote() async {
    final response = await profileIntroApiService.getSectors();
    if (response.statusCode == 200) {
      final Iterable list = jsonDecode(response.bodyString) as Iterable;
      return list
          .map((e) => ProfileIntroMetaModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<List<ProfileIntroMeta>> getExperiencesFromRemote() async {
    final response = await profileIntroApiService.getExperiences();
    if (response.statusCode == 200) {
      final Iterable list = jsonDecode(response.bodyString) as Iterable;
      return list
          .map((e) => ProfileIntroMetaModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<UserProfile> postUserProfile(
      Map<String, dynamic> body, File? photo) async {
    final newBody = Map<String, dynamic>.from(body);
    if (photo != null) {
      final file = FileConverter.getBase64FormateFile(photo.path);
      newBody['photo'] = file;
    }

    final response = await profileIntroApiService.postUserProfile(newBody);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return UserProfileModel.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }
}
