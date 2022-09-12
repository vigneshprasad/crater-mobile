import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:worknetwork/constants/app_hive_boxes.dart';
import 'package:worknetwork/core/error/exceptions.dart';
import 'package:worknetwork/core/local_storage/local_storage.dart';
import 'package:worknetwork/features/auth/data/models/user_model.dart';
import 'package:worknetwork/features/auth/data/models/user_profile_model.dart';

final authLocalDatasourceProvider =
    FutureProvider<AuthLocalDataSource>((ref) async {
  final _ = await ref.watch(localStorageProvider.future);

  final auth = AuthLocalDataSourceImpl();
  auth.initStorage();

  return auth;
});

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
  late Box<UserModel> userBox;
  late Box<UserProfileModel> profileBox;

  static const rootUserKey = "ROOT_USER_KEY";
  static const rootUserProfileKey = "ROOT_USER_PROFILE_KEY";

  void initStorage() {
    userBox = Hive.box(AppHiveBoxes.userModelBox);
    profileBox = Hive.box(AppHiveBoxes.userProfileModelBox);
  }

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
    final token = user.token ?? cached?.token ?? '';
    final updated = user.copyWith(token: token);
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
