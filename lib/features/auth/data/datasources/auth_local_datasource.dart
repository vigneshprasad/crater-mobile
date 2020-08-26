import 'package:hive/hive.dart';

import '../../../../constants/app_hive_boxes.dart';
import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  /// Gets cached [UserModel] from cache
  ///
  /// Throws [CacheException] no cached data;
  UserModel getUserFromCache();

  Future<void> setUserToCache(UserModel user);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final Box<UserModel> box = Hive.box(AppHiveBoxes.userModelBox);

  static const rootUserKey = "ROOT_USER_KEY";

  AuthLocalDataSourceImpl();

  @override
  UserModel getUserFromCache() {
    if (box.isEmpty) throw CacheException();
    final user = box.get(rootUserKey);
    if (user == null) throw CacheException();
    return user;
  }

  @override
  Future<void> setUserToCache(UserModel user) async {
    await box.put(rootUserKey, user);
  }
}
