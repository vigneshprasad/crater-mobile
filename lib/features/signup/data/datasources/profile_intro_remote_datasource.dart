import 'dart:convert';
import 'dart:io';

import 'package:worknetwork/api/profile_intro/profile_intro_api_service.dart';
import 'package:worknetwork/features/auth/data/models/user_profile_model.dart';
import 'package:worknetwork/features/auth/domain/entity/user_profile_entity.dart';
import 'package:worknetwork/features/signup/data/models/profile_intro_meta_model.dart';
import 'package:worknetwork/features/signup/domain/entity/profile_intro_meta.dart';
import '../../../../core/error/exceptions.dart';

abstract class ProfileIntroRemoteDatasource {
  Future<List<ProfileIntroMeta>> getCompaniesFromRemote();
  Future<List<ProfileIntroMeta>> getSectorsFromRemote();
  Future<List<ProfileIntroMeta>> getExperiencesFromRemote();
  Future<List<ProfileIntroMeta>> getEducationsFromRemote();
  Future<UserProfile> postUserProfile(Map<String, dynamic> body, File photo);
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
      Map<String, dynamic> body, File photo) async {
    if (photo != null) {
      final file = FileConverter.getBase64FormateFile(photo.path);
      body['photo'] = file;
    }

    final response = await profileIntroApiService.postUserProfile(body);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return UserProfileModel.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }
}

class FileConverter {
  static String getBase64FormateFile(String path) {
    final File file = File(path);
    // Image image = Image.file(file);
    // ResizeImage(Image.asset(path).image, width: 150);
    // print('File is = ' + file.toString());
    final List<int> fileInByte = file.readAsBytesSync();

    final String fileInBase64 = base64Encode(fileInByte);
    return 'data:image/jpeg;base64,$fileInBase64';
  }
}
