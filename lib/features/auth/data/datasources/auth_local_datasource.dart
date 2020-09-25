import 'package:hive/hive.dart';

import '../../../../constants/app_hive_boxes.dart';
import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';
import '../models/user_profile_model.dart';

abstract class AuthLocalDataSource {
  /// Gets cached [UserModel] from cache
  ///
  /// Throws [CacheException] no cached data;
  UserModel getUserFromCache();

  UserProfileModel getUserProfileFromCache();

  Future<void> setUserToCache(UserModel user);

  Future<void> updateUserToCache(UserModel user);

  Future<void> setUserProfileToCache(UserProfileModel profile);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final Box<UserModel> userBox = Hive.box(AppHiveBoxes.userModelBox);
  final Box<UserProfileModel> profileBox =
      Hive.box(AppHiveBoxes.userProfileModelBox);

  static const rootUserKey = "ROOT_USER_KEY";
  static const rootUserProfileKey = "ROOT_USER_PROFILE_KEY";

  AuthLocalDataSourceImpl();

  @override
  UserModel getUserFromCache() {
    if (userBox.isEmpty) throw CacheException();
    final user = userBox.get(rootUserKey);
    if (user == null) throw CacheException();
    return user;
  }

  @override
  Future<void> setUserToCache(UserModel user) async {
    await userBox.put(rootUserKey, user);
  }

  @override
  Future<void> updateUserToCache(UserModel user) async {
    final cached = userBox.get(rootUserKey);
    final updated = user.copyWith(token: cached.token);
    await userBox.put(rootUserKey, updated);
  }

  @override
  UserProfileModel getUserProfileFromCache() {
    if (profileBox.isEmpty) throw CacheException();
    final profile = profileBox.get(rootUserProfileKey);
    if (profile == null) throw CacheException();
    return profile;
  }

  @override
  Future<void> setUserProfileToCache(UserProfileModel profile) async {
    await profileBox.put(rootUserProfileKey, profile);
  }
}
